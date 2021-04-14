#pragma once

#include <string>

std::string getBinDir();
std::string getToolchainDir();
std::string getSysrootDir(const std::string &tuple);
std::string getCXXIncludeDir(const std::string &tuple);
std::string getLIBGCCDir_typeA(const std::string &tuple);
std::string getLIBGCCDir_typeB(const std::string &tuple);
