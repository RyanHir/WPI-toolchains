from . import unpack


def repack(repack_dir, download_dir, gcc_release, sysroot_tuple, target_tuple):
    with unpack.change_dir(repack_dir):
        unpack.merge_pkgs(repack_dir, download_dir)
        unpack.sysroot_clean(repack_dir)
        unpack.header_fix(repack_dir, gcc_release, sysroot_tuple)
        unpack.tuple_rename(repack_dir, gcc_release, sysroot_tuple, target_tuple)
        unpack.sysroot_package(repack_dir, download_dir)
