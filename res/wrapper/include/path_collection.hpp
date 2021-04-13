#pragma once

#include <string>

std::string getBinDir();
std::string getToolchainDir();
std::string getSysrootDir(const std::string &tuple);
std::string getCXXIncludeDir(const std::string &tuple);
std::string getLIBGCCDir(const std::string &tuple);
