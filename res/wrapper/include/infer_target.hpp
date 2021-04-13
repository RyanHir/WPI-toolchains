#pragma once

#include <string>

struct InferedTarget {
    std::string target;
    std::string exe;
};

InferedTarget infer_target(const std::string&);
