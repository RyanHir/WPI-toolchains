#include "sysroot_args.hpp"
#include "path_collection.hpp"
#include "vendor/whereami.h"
#include <assert.h>
#include <stdexcept>

std::vector<std::string> genSysrootArgs(const std::string& target, const std::string& exe)
{
    std::vector<std::string> args;
    std::string sysroot_dir = getSysrootDir(target);
    std::string libgcc_a_dir = getLIBGCCDir_typeA(target);
    std::string libgcc_b_dir = getLIBGCCDir_typeB(target);
    args.push_back("--sysroot=" + sysroot_dir);
    args.push_back("--gcc-toolchain=" + sysroot_dir);
    args.push_back("-L" + libgcc_a_dir);
    args.push_back("-B" + libgcc_a_dir);
    args.push_back("-L" + libgcc_b_dir);
    args.push_back("-B" + libgcc_b_dir);
    args.push_back("-I" + getCXXIncludeDir(target));
    return args;
}
