#include "infer_target.hpp"

#include <string.h>
#include <sstream>
#include <vector>
#include <regex>

#define DELIMETER "-"

static std::string bin_name_only(const std::string &data)
{
    size_t position = data.find_last_of("\\/");
    if (position == std::string::npos) {
        return data;
    }
    return data.substr(position + 1, data.length());
}

static std::vector<std::string> split_string(const std::string &data)
{
    std::vector<std::string> split_words;
    // Duplicate string as strtok, needs write access
    char *copy = strdup(data.c_str());
    char *token = strtok(copy, DELIMETER);
    while (token != NULL)
    {
        split_words.push_back(token);
        token = strtok(NULL, DELIMETER);
    }
    free(copy);
    return split_words;
}

static std::string merge_strings(std::vector<std::string> &data)
{
    std::string stream;
    for (auto &word : data)
    {
        stream.append(std::move(word));
        stream.append(DELIMETER);
    }
    stream.pop_back(); // Pop back to remove trailing delimiter
    return stream;
}

InferedTarget infer_target(const std::string &bin_name)
{
    InferedTarget out;
    auto words = split_string(bin_name_only(bin_name));

    out.exe = std::move(words.back());
    words.pop_back();

    out.target = merge_strings(words);
    return out;
}
