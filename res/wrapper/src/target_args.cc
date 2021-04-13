#include "target_args.hpp"
#include <string.h>
#include <map>

struct TargetArgs
{
    const char *abi;
    const char *cpu;
    const char *fpu;
    const char *arch;
};

static TargetArgs rio_cfg = {
    .abi = "softfp",
    .cpu = "cortex-a9",
    .fpu = "vfpv3",
    .arch = "armv7-a"};
static TargetArgs rpi_cfg = {
    .abi = "hard",
    .cpu = "",
    .fpu = "vfp",
    .arch = "armv6z"};
static TargetArgs armhf_cfg = {
    .abi = "hard",
    .cpu = "",
    .fpu = "vfpv3-d16",
    .arch = "armv7-a"};
static TargetArgs arm64_cfg = {
    .abi = "hard",
    .cpu = "",
    .fpu = "",
    .arch = "armv8-a"};

static std::map<std::string, TargetArgs>
    args{
        {"arm-nilrt-linux-gnueabi", rio_cfg},
        {"arm-raspi-linux-gnueabihf", rpi_cfg},
        {"arm-linux-gnueabihf", armhf_cfg},
        {"aarch64-linux-gnu", arm64_cfg},
    };

static inline void genFlag(const char *prefix, const char *suffix, std::vector<std::string> &output)
{
    if (suffix[0] != '\0')
    {
        std::string buf_str;
        size_t prefix_len = strlen(prefix);
        size_t suffix_len = strlen(suffix);
        buf_str.resize(prefix_len + suffix_len);
        memcpy(&buf_str[0], prefix, prefix_len);
        memcpy(&buf_str[0] + prefix_len, suffix, suffix_len);
        output.push_back(buf_str);
    }
}

std::vector<std::string> genTargetArgs(const std::string &target)
{
    std::vector<std::string> sys_args;
    const TargetArgs selected_settings = args.at(target.c_str());
    sys_args.push_back("--target=" + target);
    sys_args.push_back("-fuse-ld=lld");
    genFlag("-mfpu=", selected_settings.fpu, sys_args);
    genFlag("-mcpu=", selected_settings.cpu, sys_args);
    genFlag("-march=", selected_settings.arch, sys_args);
    genFlag("-mfloat-abi=", selected_settings.abi, sys_args);
    return sys_args;
}
