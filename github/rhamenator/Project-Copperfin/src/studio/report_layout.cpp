#include "copperfin/studio/report_layout.h"

#include <algorithm>
#include <charconv>
#include <cctype>
#include <optional>
#include <string_view>
#include <unordered_map>

namespace copperfin::studio {

namespace {

using vfp::DbfRecord;

std::string trim_copy(std::string text) {
    const auto first = std::find_if(text.begin(), text.end(), [](unsigned char ch) {
        return std::isspace(ch) == 0;
    });
    text.erase(text.begin(), first);

    while (!text.empty() && std::isspace(static_cast<unsigned char>(text.back())) != 0) {
        text.pop_back();
    }

    return text;
}

const vfp::DbfRecordValue* find_value(const DbfRecord& record, std::string_view field_name) {
    for (const auto& value : record.values) {
        if (value.field_name == field_name) {
            return &value;
        }
    }
    return nullptr;
}

std::string value_or_empty(const DbfRecord& record, std::string_view field_name) {
    const auto* value = find_value(record, field_name);
    return value == nullptr ? std::string() : value->display_value;
}

std::optional<int> parse_scaled_int(const DbfRecord& record, std::string_view field_name) {
    const std::string raw = trim_copy(value_or_empty(record, field_name));
    if (raw.empty()) {
        return std::nullopt;
    }

    const auto dot = raw.find('.');
    const std::string integer_portion = dot == std::string::npos ? raw : raw.substr(0U, dot);
    if (integer_portion.empty()) {
        return std::nullopt;
    }

    int value = 0;
    const auto [ptr, ec] = std::from_chars(integer_portion.data(), integer_portion.data() + integer_portion.size(), value);
    if (ec != std::errc() || ptr != (integer_portion.data() + integer_portion.size())) {
        return std::nullopt;
    }

    return value;
}

int parse_scaled_int_or_default(const DbfRecord& record, std::string_view field_name, int fallback = 0) {
    const auto parsed = parse_scaled_int(record, field_name);
    return parsed.value_or(fallback);
}

std::string band_kind_name(int objcode) {
    switch (objcode) {
        case 0:
            return "title";
        case 1:
            return "page_header";
        case 2:
            return "column_header";
        case 3:
            return "group_header";
        case 4:
            return "detail";
        case 5:
            return "group_footer";
        case 6:
            return "column_footer";
        case 7:
            return "page_footer";
        case 8:
            return "summary";
        case 9:
            return "detail_header";
        case 10:
            return "detail_footer";
        default:
            return "other";
    }
}

std::string band_title(int objcode) {
    switch (objcode) {
        case 0:
            return "Title";
        case 1:
            return "Page Header";
        case 2:
            return "Column Header";
        case 3:
            return "Group Header";
        case 4:
            return "Detail";
        case 5:
            return "Group Footer";
        case 6:
            return "Column Footer";
        case 7:
            return "Page Footer";
        case 8:
            return "Summary";
        case 9:
            return "Detail Header";
        case 10:
            return "Detail Footer";
        default:
            return "Other Band";
    }
}

std::string object_kind_name(int objtype) {
    switch (objtype) {
        case 5:
            return "label";
        case 6:
            return "line";
        case 7:
            return "rectangle";
        case 8:
            return "field";
        case 9:
            return "band";
        case 10:
            return "group";
        case 17:
            return "picture";
        case 18:
            return "variable";
        default:
            return "object";
    }
}

std::string first_non_empty(const DbfRecord& record, std::initializer_list<std::string_view> field_names) {
    for (const auto field_name : field_names) {
        const std::string value = trim_copy(value_or_empty(record, field_name));
        if (!value.empty() && value != "<memo block 0>") {
            return value;
        }
    }
    return {};
}

StudioLayoutObjectSnapshot build_layout_object(const DbfRecord& record) {
    StudioLayoutObjectSnapshot object;
    object.record_index = record.record_index;
    object.object_kind = object_kind_name(parse_scaled_int_or_default(record, "OBJTYPE"));
    object.title = first_non_empty(record, {"NAME", "EXPR", "UNIQUEID"});
    object.expression = first_non_empty(record, {"EXPR"});
    object.left = parse_scaled_int_or_default(record, "HPOS");
    object.top = parse_scaled_int_or_default(record, "VPOS");
    object.width = std::max(0, parse_scaled_int_or_default(record, "WIDTH"));
    object.height = std::max(0, parse_scaled_int_or_default(record, "HEIGHT"));

    if (object.title.empty()) {
        object.title = "Record " + std::to_string(record.record_index);
    }

    const auto add_highlight = [&](std::string_view name) {
        const std::string value = first_non_empty(record, {name});
        if (!value.empty()) {
            object.highlights.push_back({std::string(name), value});
        }
    };

    add_highlight("EXPR");
    add_highlight("FONTFACE");
    add_highlight("FONTSIZE");
    add_highlight("MODE");

    return object;
}

bool is_report_family(const StudioDocumentModel& document) {
    return document.kind == StudioAssetKind::report || document.kind == StudioAssetKind::label;
}

bool is_layout_object_type(int objtype) {
    return objtype == 5 || objtype == 6 || objtype == 7 || objtype == 8 || objtype == 17 || objtype == 18;
}

bool is_report_root_record(const DbfRecord& record) {
    return parse_scaled_int_or_default(record, "OBJTYPE") == 1;
}

bool is_band_record(const DbfRecord& record) {
    return parse_scaled_int_or_default(record, "OBJTYPE") == 9;
}

void append_report_settings(const DbfRecord& record, std::vector<StudioNamedValue>& settings) {
    const std::string expr = value_or_empty(record, "EXPR");
    std::size_t start = 0U;
    while (start <= expr.size()) {
        const std::size_t end = expr.find('\n', start);
        std::string line = end == std::string::npos ? expr.substr(start) : expr.substr(start, end - start);
        if (!line.empty() && line.back() == '\r') {
            line.pop_back();
        }

        const auto equals = line.find('=');
        if (equals != std::string::npos) {
            const std::string name = trim_copy(line.substr(0U, equals));
            const std::string value = trim_copy(line.substr(equals + 1U));
            if (!name.empty()) {
                settings.push_back({name, value});
            }
        }

        if (end == std::string::npos) {
            break;
        }
        start = end + 1U;
    }

    const auto append_numeric = [&](std::string_view field_name) {
        const std::string value = trim_copy(value_or_empty(record, field_name));
        if (!value.empty()) {
            settings.push_back({std::string(field_name), value});
        }
    };

    append_numeric("TOPMARGIN");
    append_numeric("BOTMARGIN");
    append_numeric("GRIDV");
    append_numeric("GRIDH");
}

std::string make_section_id(std::size_t record_index, int objcode) {
    return band_kind_name(objcode) + "_" + std::to_string(record_index);
}

std::size_t find_section_index(
    const std::vector<StudioReportSectionSnapshot>& sections,
    int top,
    int height) {
    for (std::size_t index = 0; index < sections.size(); ++index) {
        const auto& section = sections[index];
        const int section_bottom = section.top + std::max(section.height, 1);
        const int object_bottom = top + std::max(height, 1);
        const bool begins_inside = top >= section.top && top < section_bottom;
        const bool overlaps = object_bottom > section.top && top < section_bottom;
        if (begins_inside || overlaps) {
            return index;
        }
    }
    return sections.size();
}

}  // namespace

StudioReportLayoutSnapshot build_report_layout(const StudioDocumentModel& document) {
    StudioReportLayoutSnapshot snapshot;
    if (!is_report_family(document) || !document.table_preview_available) {
        return snapshot;
    }

    snapshot.available = true;
    snapshot.is_label = document.kind == StudioAssetKind::label;
    snapshot.document_title = document.display_name;

    for (const auto& record : document.table_preview.records) {
        if (record.deleted) {
            continue;
        }

        if (is_report_root_record(record)) {
            append_report_settings(record, snapshot.settings);
            continue;
        }

        if (is_band_record(record)) {
            const int objcode = parse_scaled_int_or_default(record, "OBJCODE");
            snapshot.sections.push_back({
                .id = make_section_id(record.record_index, objcode),
                .title = band_title(objcode),
                .band_kind = band_kind_name(objcode),
                .record_index = record.record_index,
                .top = parse_scaled_int_or_default(record, "VPOS"),
                .height = std::max(0, parse_scaled_int_or_default(record, "HEIGHT"))
            });
        }
    }

    std::sort(snapshot.sections.begin(), snapshot.sections.end(), [](const StudioReportSectionSnapshot& left,
                                                                     const StudioReportSectionSnapshot& right) {
        if (left.top != right.top) {
            return left.top < right.top;
        }
        return left.record_index < right.record_index;
    });

    for (const auto& record : document.table_preview.records) {
        if (record.deleted) {
            continue;
        }

        const int objtype = parse_scaled_int_or_default(record, "OBJTYPE");
        if (!is_layout_object_type(objtype)) {
            continue;
        }

        StudioLayoutObjectSnapshot object = build_layout_object(record);
        const std::size_t section_index = find_section_index(snapshot.sections, object.top, object.height);
        if (section_index < snapshot.sections.size()) {
            snapshot.sections[section_index].objects.push_back(std::move(object));
        } else {
            snapshot.unplaced_objects.push_back(std::move(object));
        }
    }

    for (auto& section : snapshot.sections) {
        std::sort(section.objects.begin(), section.objects.end(), [](const StudioLayoutObjectSnapshot& left,
                                                                    const StudioLayoutObjectSnapshot& right) {
            if (left.top != right.top) {
                return left.top < right.top;
            }
            if (left.left != right.left) {
                return left.left < right.left;
            }
            return left.record_index < right.record_index;
        });
    }

    std::sort(snapshot.unplaced_objects.begin(), snapshot.unplaced_objects.end(), [](const StudioLayoutObjectSnapshot& left,
                                                                                    const StudioLayoutObjectSnapshot& right) {
        if (left.top != right.top) {
            return left.top < right.top;
        }
        if (left.left != right.left) {
            return left.left < right.left;
        }
        return left.record_index < right.record_index;
    });

    return snapshot;
}

}  // namespace copperfin::studio
