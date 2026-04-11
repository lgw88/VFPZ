#pragma once

#include "copperfin/studio/document_model.h"

#include <string>
#include <vector>

namespace copperfin::studio {

struct LaunchParseResult {
    bool ok = false;
    bool show_help = false;
    bool output_json = false;
    StudioOpenRequest request{};
    std::string error;
};

LaunchParseResult parse_launch_arguments(const std::vector<std::string>& args);

}  // namespace copperfin::studio
