#include "sysroot_args.hpp"
#include "path_collection.hpp"
#include "vendor/whereami.h"
#include <assert.h>
#include <stdexcept>

std::vector<std::string> genSysrootArgs(const std::string& target, const std::string& exe)
{
    std::vector<std::string> args;
    std::string sysroot_dir = getSysrootDir(target);
    std::string libgcc_dir = getLIBGCCDir(target);
    args.push_back("--sysroot=" + sysroot_dir);
    args.push_back("--gcc-toolchain=" + sysroot_dir);
    args.push_back("-L" + libgcc_dir);
    args.push_back("-B" + libgcc_dir);
    args.push_back("-I" + getCXXIncludeDir(target));
    return args;
}
