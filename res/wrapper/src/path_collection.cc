#include <assert.h>
#include "path_collection.hpp"
#include "vendor/whereami.h"

#if not defined(_WIN32)
#define DIR_SEPERATOR "/"
#else
#define DIR_SEPERATOR "\\"
#endif

#if not defined(LLVM_GCC_VERSION)
#define LLVM_GCC_VERSION "1.1.1"
#endif

std::string getBinDir()
{
    std::string path;
    int dirname_len;
    path.resize(wai_getExecutablePath(NULL, 0, NULL));
    wai_getExecutablePath(&path[0], path.length(), &dirname_len);
    return path.substr(0, dirname_len) + DIR_SEPERATOR;
}

std::string getToolchainDir()
{
    std::string path = getBinDir();
    path += ".." DIR_SEPERATOR;
    return path;
}

std::string getSysrootDir(const std::string &tuple)
{
    std::string path = getToolchainDir();
    path += tuple + DIR_SEPERATOR;
    return path;
}

std::string getCXXIncludeDir(const std::string &tuple)
{
    std::string path = getSysrootDir(tuple);
    path += "usr" DIR_SEPERATOR "include" DIR_SEPERATOR "c++" DIR_SEPERATOR "v1" DIR_SEPERATOR;
    return path;
}

std::string getLIBGCCDir(const std::string &tuple)
{
    std::string path = getSysrootDir(tuple);
    path += "usr" DIR_SEPERATOR "lib" DIR_SEPERATOR + tuple;
    return path + DIR_SEPERATOR LLVM_GCC_VERSION DIR_SEPERATOR;
}
