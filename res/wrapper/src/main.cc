#include "infer_target.hpp"
#include "target_args.hpp"
#include "sysroot_args.hpp"
#include "path_collection.hpp"

#include <iostream>

static int run_exe(const std::string &cmd, const std::vector<std::string> &args)
{
    std::string arg_str;
    arg_str += "\"" + cmd + "\"";
    for (const auto &arg : args)
    {
        arg_str += " \"" + arg + "\"";
    }
    return std::system(arg_str.c_str());
}

int main(int argc, char **argv)
{
    auto target_data = infer_target(argv[0]);
    std::vector<std::string> args;
    {
        auto target_args = genTargetArgs(target_data.target);
        args.insert(args.end(), target_args.begin(), target_args.end());
    }
    {
        auto sysroot_args = genSysrootArgs(target_data.target, target_data.exe);
        args.insert(args.end(), sysroot_args.begin(), sysroot_args.end());
    }
    args.push_back("-Qunused-arguments");
    for (int iter = 1; iter != argc; iter++)
    {
        args.push_back(argv[iter]);
    }
    return run_exe(getBinDir() + target_data.exe, args);
}
