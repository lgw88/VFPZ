#pragma once

#include "copperfin/studio/document_model.h"

#include <cstddef>
#include <string>
#include <vector>

namespace copperfin::studio {

struct StudioNamedValue {
    std::string name;
    std::string value;
};

struct StudioLayoutObjectSnapshot {
    std::size_t record_index = 0;
    std::string object_kind;
    std::string title;
    std::string expression;
    int left = 0;
    int top = 0;
    int width = 0;
    int height = 0;
    std::vector<StudioNamedValue> highlights;
};

struct StudioReportSectionSnapshot {
    std::string id;
    std::string title;
    std::string band_kind;
    std::size_t record_index = 0;
    int top = 0;
    int height = 0;
    std::vector<StudioLayoutObjectSnapshot> objects;
};

struct StudioReportLayoutSnapshot {
    bool available = false;
    bool is_label = false;
    std::string document_title;
    std::vector<StudioNamedValue> settings;
    std::vector<StudioReportSectionSnapshot> sections;
    std::vector<StudioLayoutObjectSnapshot> unplaced_objects;
};

[[nodiscard]] StudioReportLayoutSnapshot build_report_layout(const StudioDocumentModel& document);

}  // namespace copperfin::studio
