from contextlib import contextmanager
from packaging import version
from pathlib import Path
import os
import tarfile


@contextmanager
def change_dir(directory):
    origin = Path().absolute()
    try:
        os.chdir(str(Path(directory).absolute()))
        yield
    finally:
        os.chdir(str(origin))


def remove_dir(directory):
    path = Path(directory)
    for child in path.glob("*"):
        if child.is_file() or child.is_symlink():
            child.unlink()
        else:
            remove_dir(child)
    path.rmdir()
    assert not directory.exists()


def _unpack_pkg(file: Path, compression):
    assert file.exists() and file.is_file()
    parent = file.parent
    (parent / "extract").mkdir()
    extract_dir = Path(parent, "extract")
    with change_dir(extract_dir):
        fd = os.popen("ar x {}".format(file))
        if fd.close() is not None:
            raise OSError("Failed to extract pkg: %s" % fd.read())
        _tarname = "data.tar.%s" % compression
        with tarfile.open(_tarname) as data:
            data.extractall(".")
        Path(extract_dir, "debian-binary").unlink()
        Path(extract_dir, "control.tar.%s" % compression).unlink()
        Path(extract_dir, _tarname).unlink()
    extract_dir.rename(file.with_suffix(""))


def unpack_pkg(file):
    path = Path(file).absolute()
    print("Unpacking", path)
    ext = path.suffix
    if path.suffix == ".deb":
        _unpack_pkg(path, "xz")
    elif path.suffix == ".ipk":
        _unpack_pkg(path, "gz")
    else:
        msg = "Unexpected file extension: %s"
        raise ValueError(msg % path.suffix)
    retval = path.with_suffix("")
    assert retval.is_dir()
    return retval.resolve()


def merge_pkgs(workdir: Path, downloaddir: Path):
    (workdir / "tmpdir").mkdir()
    tmpdir = Path(workdir, "tmpdir")
    pkgs = [x for x in workdir.iterdir() if x.is_file()]
    for pkg in pkgs:
        unpack_dir = unpack_pkg(pkg)
        pkg.unlink()
        fd = os.popen("cp -r '{}'/* '{}'".format(unpack_dir, tmpdir))
        if fd.close() is not None:
            raise OSError("Could not move contents of {}".format(unpack_dir))
        remove_dir(unpack_dir)
    fd = os.popen("mv '{}'/* .".format(tmpdir))
    if fd.close() is not None:
        raise OSError("Could not move contents of {}".format(tmpdir))
    remove_dir(tmpdir)


def sysroot_clean(workdir: Path):
    to_remove = ["etc", "bin", "sbin", "libexec",
                 "usr/bin", "usr/sbin", "usr/share", "usr/libexec"]
    for directory in to_remove:
        directory = Path(".", directory)
        if directory.exists():
            remove_dir(directory)


def header_fix(workdir: Path, release, target_tuple):
    def _rename(path: Path):
        assert type(release) is str
        if not path.exists():
            return
        major = release.split(".")[0]
        with change_dir(path):
            pwd = Path(major)
            if pwd.exists():
                pwd.rename(release)
        pass
    _rename(workdir / "usr/lib/gcc/" / target_tuple)
    _rename(workdir / "usr/include/c++" / target_tuple)
    _rename(workdir / "usr/include/c++")
    _rename(workdir / "usr/include/" / target_tuple / "c++")


def tuple_rename(workdir: Path, release, sysroot_tuple, target_tuple):
    def _rename(path: Path):
        if not path.exists():
            return
        with change_dir(path):
            pwd = Path(sysroot_tuple)
            if pwd.exists():
                pwd.rename(target_tuple)
        pass
    _rename(workdir / "usr/include/c++" / release)
    _rename(workdir / "usr/include/")
    _rename(workdir / "usr/lib/gcc")
    _rename(workdir / "usr/lib")
    _rename(workdir / "lib")


def sysroot_package(workdir: Path, downloaddir: Path):
    workdir = workdir.absolute()
    outdir = downloaddir / "sysroot-libc-linux"
    with change_dir("/tmp"):
        try:
            remove_dir(outdir)
        except:
            pass
        workdir.rename(outdir)
        Path(workdir).mkdir()
    with change_dir(downloaddir):
        out_file = Path("sysroot-libc-linux.tar")
        if out_file.exists():
            out_file.unlink()
        with tarfile.open(str(out_file), mode="x") as out:
            out.add("sysroot-libc-linux")
