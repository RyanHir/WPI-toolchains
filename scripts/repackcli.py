from argparse import ArgumentParser
from pathlib import Path
import librepack
import sys


def args():
    parser = ArgumentParser(prog="repackcli")
    parser.add_argument("--repackdir", required=True)
    parser.add_argument("--downloaddir", required=True)
    parser.add_argument("--gccver", required=True)
    parser.add_argument("--tuple", required=True)
    parser.add_argument("--rename_tuple", required=True)
    return parser.parse_args()


def main():
    _args = args()
    print(_args)
    repackdir = Path(_args.repackdir)
    downloaddir = Path(_args.downloaddir)
    librepack.repack(repackdir, downloaddir, _args.gccver, _args.tuple, _args.rename_tuple)
    pass


if __name__ == "__main__":
    main()
