#include "copperfin/runtime/prg_engine.h"
#include "copperfin/runtime/xasset_methods.h"
#include "copperfin/studio/document_model.h"
#include "copperfin/studio/report_layout.h"
#include "copperfin/vfp/asset_inspector.h"
#include "copperfin/vfp/dbf_table.h"

#include <algorithm>
#include <cctype>
#include <cmath>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <functional>
#include <optional>
#include <process.h>
#include <set>
#include <sstream>
#include <utility>

namespace copperfin::runtime {

namespace {

enum class StatementKind {
    assignment,
    expression,
    do_command,
    do_while_statement,
    do_case_statement,
    case_statement,
    otherwise_statement,
    calculate_command,
    count_command,
    sum_command,
    average_command,
    text_command,
    total_command,
    do_form,
    report_form,
    label_form,
    activate_surface,
    release_surface,
    return_statement,
    if_statement,
    else_statement,
    endif_statement,
    for_statement,
    endfor_statement,
    loop_statement,
    exit_statement,
    enddo_statement,
    endcase_statement,
    read_events,
    clear_events,
    seek_command,
    locate_command,
    scan_statement,
    endscan_statement,
    replace_command,
    append_blank_command,
    delete_command,
    recall_command,
    go_command,
    skip_command,
    select_command,
    use_command,
    set_order,
    set_command,
    set_library,
    set_datasession,
    set_default,
    on_error,
    public_declaration,
    local_declaration,
    no_op
};

struct Statement {
    StatementKind kind = StatementKind::no_op;
    SourceLocation location{};
    std::string text;
    std::string identifier;
    std::string expression;
    std::string secondary_expression;
    std::string tertiary_expression;
    std::string quaternary_expression;
    std::vector<std::string> names;
};

struct Routine {
    std::string name;
    std::vector<Statement> statements;
};

struct Program {
    std::string path;
    Routine main{};
    std::map<std::string, Routine> routines;
};

struct LoopState {
    std::size_t for_statement_index = 0;
    std::size_t endfor_statement_index = 0;
    std::string variable_name;
    double end_value = 0.0;
    double step_value = 1.0;
};

struct ScanState {
    std::size_t scan_statement_index = 0;
    std::size_t endscan_statement_index = 0;
    int work_area = 0;
    std::string for_expression;
};

struct WhileState {
    std::size_t do_while_statement_index = 0;
    std::size_t enddo_statement_index = 0;
};

struct CaseState {
    std::size_t do_case_statement_index = 0;
    std::size_t endcase_statement_index = 0;
    bool matched = false;
};

struct Frame {
    std::string file_path;
    std::string routine_name;
    const Routine* routine = nullptr;
    std::size_t pc = 0;
    std::map<std::string, PrgValue> locals;
    std::set<std::string> local_names;
    std::vector<LoopState> loops;
    std::vector<ScanState> scans;
    std::vector<WhileState> whiles;
    std::vector<CaseState> cases;
};

struct ExecutionOutcome {
    bool ok = true;
    bool waiting_for_events = false;
    bool frame_returned = false;
    std::string message;
};

struct CursorState {
    struct OrderState {
        std::string name;
        std::string expression;
        std::string index_path;
    };

    int work_area = 0;
    std::string alias;
    std::string source_path;
    std::string dbf_identity;
    std::string source_kind;
    bool remote = false;
    std::size_t field_count = 0;
    std::size_t record_count = 0;
    std::size_t recno = 0;
    bool found = false;
    bool bof = true;
    bool eof = true;
    std::vector<OrderState> orders;
    std::string active_order_name;
    std::string active_order_expression;
    std::string active_order_path;
    std::string filter_expression;
};

struct IndexedCandidate {
    std::string key;
    std::size_t recno = 0;
};

struct CursorPositionSnapshot {
    std::size_t recno = 0;
    bool found = false;
    bool bof = true;
    bool eof = true;
    std::string active_order_name;
    std::string active_order_expression;
    std::string active_order_path;
};

struct ReplaceAssignment {
    std::string field_name;
    std::string expression;
};

struct CalculateAssignment {
    std::string aggregate_expression;
    std::string variable_name;
};

enum class AggregateScopeKind {
    all_records,
    rest_records,
    next_records,
    record
};

struct AggregateScopeClause {
    AggregateScopeKind kind = AggregateScopeKind::all_records;
    std::string raw_value;
};

struct TotalCommandPlan {
    std::string target_expression;
    std::string on_field_name;
    std::vector<std::string> field_names;
    AggregateScopeClause scope;
    std::string for_expression;
    std::string while_expression;
    std::string in_expression;
};

struct RegisteredApiFunction {
    int handle = 0;
    std::string variant;
    std::string function_name;
    std::string argument_types;
    std::string return_type;
    std::string dll_name;
};

struct LogicalLine {
    std::size_t line_number = 0;
    std::string text;
    bool is_text_block = false;
    std::string block_text;
};

struct DataSessionState {
    int selected_work_area = 1;
    int next_work_area = 1;
    std::map<int, std::string> aliases;
    std::map<int, CursorState> cursors;
};

std::string trim_copy(std::string value) {
    value.erase(value.begin(), std::find_if(value.begin(), value.end(), [](unsigned char ch) {
        return std::isspace(ch) == 0;
    }));
    while (!value.empty() && std::isspace(static_cast<unsigned char>(value.back())) != 0) {
        value.pop_back();
    }
    return value;
}

std::string lowercase_copy(std::string value) {
    std::transform(value.begin(), value.end(), value.begin(), [](unsigned char ch) {
        return static_cast<char>(std::tolower(ch));
    });
    return value;
}

bool starts_with_insensitive(const std::string& value, const std::string& prefix) {
    if (value.size() < prefix.size()) {
        return false;
    }
    for (std::size_t index = 0; index < prefix.size(); ++index) {
        if (std::tolower(static_cast<unsigned char>(value[index])) !=
            std::tolower(static_cast<unsigned char>(prefix[index]))) {
            return false;
        }
    }
    return true;
}

std::string normalize_identifier(std::string value) {
    return lowercase_copy(trim_copy(std::move(value)));
}

std::string normalize_path(const std::string& value) {
    if (value.empty()) {
        return {};
    }
    return std::filesystem::path(value).lexically_normal().string();
}

bool is_index_file_path(const std::string& value) {
    const std::string extension = lowercase_copy(std::filesystem::path(trim_copy(value)).extension().string());
    return extension == ".cdx" || extension == ".dcx" || extension == ".idx" ||
           extension == ".ndx" || extension == ".mdx";
}

std::string unquote_string(std::string value) {
    value = trim_copy(std::move(value));
    if (value.size() >= 2U && value.front() == '\'' && value.back() == '\'') {
        return value.substr(1U, value.size() - 2U);
    }
    return value;
}

std::string take_first_token(std::string value) {
    value = trim_copy(std::move(value));
    if (value.empty()) {
        return value;
    }
    if (value.front() == '\'') {
        const auto closing = value.find('\'', 1U);
        if (closing != std::string::npos) {
            return value.substr(0U, closing + 1U);
        }
        return value;
    }

    const auto separator = value.find(' ');
    return separator == std::string::npos ? value : value.substr(0U, separator);
}

std::pair<std::string, std::string> split_first_word(std::string value) {
    value = trim_copy(std::move(value));
    if (value.empty()) {
        return {};
    }

    const auto separator = value.find(' ');
    if (separator == std::string::npos) {
        return {value, {}};
    }

    return {
        value.substr(0U, separator),
        trim_copy(value.substr(separator + 1U))
    };
}

std::string uppercase_copy(std::string value);

std::string take_keyword_value(const std::string& text, const std::string& keyword) {
    const std::string upper = uppercase_copy(text);
    const std::string pattern = " " + uppercase_copy(keyword) + " ";
    const auto position = upper.find(pattern);
    if (position == std::string::npos) {
        return {};
    }
    return take_first_token(text.substr(position + pattern.size()));
}

std::string uppercase_copy(std::string value) {
    std::transform(value.begin(), value.end(), value.begin(), [](unsigned char ch) {
        return static_cast<char>(std::toupper(ch));
    });
    return value;
}

bool is_bare_identifier_text(const std::string& value) {
    return !value.empty() && std::all_of(value.begin(), value.end(), [](unsigned char ch) {
        return std::isalnum(ch) != 0 || ch == '_';
    });
}

std::string collapse_identifier(const std::string& value) {
    std::string normalized;
    normalized.reserve(value.size());

    for (char ch : value) {
        const auto raw = static_cast<unsigned char>(ch);
        if (std::isalnum(raw) == 0) {
            continue;
        }
        normalized.push_back(static_cast<char>(std::toupper(raw)));
    }

    return normalized;
}

std::string unquote_identifier(std::string value) {
    value = trim_copy(std::move(value));
    if (value.size() >= 2U) {
        if ((value.front() == '\'' && value.back() == '\'') ||
            (value.front() == '"' && value.back() == '"')) {
            return value.substr(1U, value.size() - 2U);
        }
    }
    return value;
}

std::string normalize_index_value(std::string value) {
    value = trim_copy(std::move(value));
    if (value == ".T.") {
        return "true";
    }
    if (value == ".F.") {
        return "false";
    }
    return value;
}

std::optional<std::string> record_field_value(const vfp::DbfRecord& record, const std::string& field_name) {
    const std::string normalized_field = collapse_identifier(field_name);
    for (const auto& value : record.values) {
        if (collapse_identifier(value.field_name) == normalized_field) {
            return value.display_value;
        }
    }
    return std::nullopt;
}

vfp::DbfRecord make_synthetic_sql_record(std::size_t recno) {
    const auto synthetic_name = [&]() {
        switch (recno) {
            case 1U:
                return std::string{"ALPHA"};
            case 2U:
                return std::string{"BRAVO"};
            case 3U:
                return std::string{"CHARLIE"};
            default:
                return "ROW" + std::to_string(recno);
        }
    };

    return vfp::DbfRecord{
        .record_index = recno - 1U,
        .deleted = false,
        .values = {
            vfp::DbfRecordValue{.field_name = "ID", .field_type = 'N', .display_value = std::to_string(recno)},
            vfp::DbfRecordValue{.field_name = "NAME", .field_type = 'C', .display_value = synthetic_name()},
            vfp::DbfRecordValue{.field_name = "AMOUNT", .field_type = 'N', .display_value = std::to_string(recno * 10U)},
        }
    };
}

std::string evaluate_index_expression(const std::string& expression, const vfp::DbfRecord& record) {
    const std::string trimmed = trim_copy(expression);
    const std::string upper = uppercase_copy(trimmed);

    const auto apply_unary = [&](const std::string& prefix, auto&& transform) -> std::optional<std::string> {
        if (!starts_with_insensitive(trimmed, prefix + "(") || trimmed.back() != ')') {
            return std::nullopt;
        }

        const std::string inner = trim_copy(trimmed.substr(prefix.size() + 1U, trimmed.size() - prefix.size() - 2U));
        std::string value = evaluate_index_expression(inner, record);
        transform(value);
        return value;
    };

    if (const auto upper_value = apply_unary("UPPER", [](std::string& value) {
            value = uppercase_copy(value);
        })) {
        return *upper_value;
    }
    if (const auto lower_value = apply_unary("LOWER", [](std::string& value) {
            std::transform(value.begin(), value.end(), value.begin(), [](unsigned char ch) {
                return static_cast<char>(std::tolower(ch));
            });
        })) {
        return *lower_value;
    }
    if (const auto trim_value = apply_unary("ALLTRIM", [](std::string& value) {
            value = trim_copy(std::move(value));
        })) {
        return *trim_value;
    }
    if (const auto ltrim_value = apply_unary("LTRIM", [](std::string& value) {
            const auto first = std::find_if(value.begin(), value.end(), [](unsigned char ch) {
                return std::isspace(ch) == 0;
            });
            value.erase(value.begin(), first);
        })) {
        return *ltrim_value;
    }
    if (const auto rtrim_value = apply_unary("RTRIM", [](std::string& value) {
            while (!value.empty() && std::isspace(static_cast<unsigned char>(value.back())) != 0) {
                value.pop_back();
            }
        })) {
        return *rtrim_value;
    }

    if (trimmed.size() >= 2U &&
        ((trimmed.front() == '\'' && trimmed.back() == '\'') ||
         (trimmed.front() == '"' && trimmed.back() == '"'))) {
        return unquote_identifier(trimmed);
    }

    if (const auto field_value = record_field_value(record, trimmed)) {
        return normalize_index_value(*field_value);
    }

    return normalize_index_value(trimmed);
}

bool has_keyword(const std::string& text, const std::string& keyword) {
    const std::string upper = " " + uppercase_copy(text) + " ";
    const std::string pattern = " " + uppercase_copy(keyword) + " ";
    return upper.find(pattern) != std::string::npos;
}

bool parse_object_handle_reference(const PrgValue& value, int& handle, std::string& prog_id) {
    if (value.kind != PrgValueKind::string) {
        return false;
    }

    const std::string prefix = "object:";
    if (value.string_value.rfind(prefix, 0) != 0) {
        return false;
    }

    const auto separator = value.string_value.rfind('#');
    if (separator == std::string::npos || separator <= prefix.size()) {
        return false;
    }

    prog_id = value.string_value.substr(prefix.size(), separator - prefix.size());
    try {
        handle = std::stoi(value.string_value.substr(separator + 1U));
    } catch (...) {
        return false;
    }
    return true;
}

std::string strip_inline_comment(const std::string& line) {
    bool in_string = false;
    for (std::size_t index = 0; index < line.size(); ++index) {
        const char ch = line[index];
        if (ch == '\'') {
            in_string = !in_string;
            continue;
        }
        if (!in_string && ch == '&' && (index + 1U) < line.size() && line[index + 1U] == '&') {
            return line.substr(0U, index);
        }
    }
    return line;
}

std::vector<LogicalLine> load_logical_lines(const std::string& path) {
    std::ifstream input(path, std::ios::binary);
    std::vector<LogicalLine> lines;
    if (!input) {
        return lines;
    }

    std::string raw_line;
    std::size_t line_number = 0;
    std::size_t current_start = 0;
    std::string current_text;
    bool continuing = false;

    while (std::getline(input, raw_line)) {
        ++line_number;
        if (!raw_line.empty() && raw_line.back() == '\r') {
            raw_line.pop_back();
        }

        const std::string text_probe = trim_copy(strip_inline_comment(raw_line));
        if (!continuing && (uppercase_copy(text_probe) == "TEXT" || starts_with_insensitive(text_probe, "TEXT "))) {
            const std::size_t block_start = line_number;
            std::string block_text;
            while (std::getline(input, raw_line)) {
                ++line_number;
                if (!raw_line.empty() && raw_line.back() == '\r') {
                    raw_line.pop_back();
                }

                if (uppercase_copy(trim_copy(strip_inline_comment(raw_line))) == "ENDTEXT") {
                    break;
                }

                block_text += raw_line;
                block_text += "\n";
            }

            lines.push_back({
                .line_number = block_start,
                .text = text_probe,
                .is_text_block = true,
                .block_text = std::move(block_text)
            });
            continuing = false;
            current_text.clear();
            continue;
        }

        std::string line = strip_inline_comment(raw_line);
        if (!continuing) {
            current_start = line_number;
            current_text.clear();
        }

        const std::string trimmed = trim_copy(line);
        if (!current_text.empty() && !trimmed.empty()) {
            current_text += " ";
        }
        current_text += trimmed;

        if (!trimmed.empty() && trimmed.back() == ';') {
            current_text.pop_back();
            continuing = true;
            continue;
        }

        continuing = false;
        lines.push_back({
            .line_number = current_start,
            .text = trim_copy(current_text)
        });
    }

    if (continuing && !current_text.empty()) {
        lines.push_back({
            .line_number = current_start,
            .text = trim_copy(current_text)
        });
    }

    return lines;
}

Statement make_statement(StatementKind kind, const std::string& path, std::size_t line, const std::string& text) {
    Statement statement;
    statement.kind = kind;
    statement.location = {.file_path = normalize_path(path), .line = line};
    statement.text = text;
    return statement;
}

std::vector<std::string> split_csv_like(const std::string& text) {
    std::vector<std::string> parts;
    std::string current;
    int nesting = 0;
    bool in_string = false;

    for (char ch : text) {
        if (ch == '\'') {
            in_string = !in_string;
            current.push_back(ch);
            continue;
        }
        if (!in_string) {
            if (ch == '(') {
                ++nesting;
            } else if (ch == ')' && nesting > 0) {
                --nesting;
            } else if (ch == ',' && nesting == 0) {
                parts.push_back(trim_copy(current));
                current.clear();
                continue;
            }
        }
        current.push_back(ch);
    }

    if (!current.empty()) {
        parts.push_back(trim_copy(current));
    }
    return parts;
}

std::size_t find_keyword_top_level(const std::string& text, const std::string& keyword) {
    const std::string upper = uppercase_copy(text);
    const std::string target = uppercase_copy(keyword);
    int nesting = 0;
    bool in_string = false;

    for (std::size_t index = 0; index < upper.size(); ++index) {
        const char ch = upper[index];
        if (ch == '\'') {
            in_string = !in_string;
            continue;
        }
        if (in_string) {
            continue;
        }
        if (ch == '(') {
            ++nesting;
            continue;
        }
        if (ch == ')' && nesting > 0) {
            --nesting;
            continue;
        }
        if (nesting != 0) {
            continue;
        }
        if ((index == 0U || std::isspace(static_cast<unsigned char>(upper[index - 1U])) != 0) &&
            upper.compare(index, target.size(), target) == 0) {
            const std::size_t tail = index + target.size();
            if (tail >= upper.size() || std::isspace(static_cast<unsigned char>(upper[tail])) != 0) {
                return index;
            }
        }
    }

    return std::string::npos;
}

std::string trim_command_keyword(const std::string& text, const std::string& keyword) {
    const std::size_t position = find_keyword_top_level(text, keyword);
    if (position == std::string::npos) {
        return {};
    }
    return trim_copy(text.substr(position + keyword.size()));
}

std::size_t find_keyword_top_level_from(
    const std::string& text,
    const std::string& keyword,
    std::size_t start_index) {
    const std::string upper = uppercase_copy(text);
    const std::string target = uppercase_copy(keyword);

    bool in_string = false;
    int nesting = 0;
    for (std::size_t index = start_index; index < upper.size(); ++index) {
        const char ch = upper[index];
        if (ch == '\'' && (index == 0U || upper[index - 1U] != '\\')) {
            in_string = !in_string;
            continue;
        }
        if (in_string) {
            continue;
        }
        if (ch == '(') {
            ++nesting;
            continue;
        }
        if (ch == ')' && nesting > 0) {
            --nesting;
            continue;
        }
        if (nesting != 0) {
            continue;
        }
        if ((index == 0U || std::isspace(static_cast<unsigned char>(upper[index - 1U])) != 0) &&
            upper.compare(index, target.size(), target) == 0) {
            const std::size_t tail = index + target.size();
            if (tail >= upper.size() || std::isspace(static_cast<unsigned char>(upper[tail])) != 0) {
                return index;
            }
        }
    }

    return std::string::npos;
}

std::size_t find_first_keyword_top_level(
    const std::string& text,
    std::initializer_list<std::string> keywords,
    std::size_t start_index = 0U) {
    std::size_t result = std::string::npos;
    for (const std::string& keyword : keywords) {
        const std::size_t position = find_keyword_top_level_from(text, keyword, start_index);
        if (position == std::string::npos) {
            continue;
        }
        result = result == std::string::npos ? position : std::min(result, position);
    }
    return result;
}

std::size_t find_last_keyword_top_level(
    const std::string& text,
    std::initializer_list<std::string> keywords) {
    std::size_t result = std::string::npos;
    for (const std::string& keyword : keywords) {
        std::size_t search_index = 0U;
        while (search_index < text.size()) {
            const std::size_t position = find_keyword_top_level_from(text, keyword, search_index);
            if (position == std::string::npos) {
                break;
            }
            result = result == std::string::npos ? position : std::max(result, position);
            search_index = position + 1U;
        }
    }
    return result;
}

std::string extract_command_clause(
    const std::string& text,
    const std::string& keyword,
    std::initializer_list<std::string> stop_keywords = {}) {
    const std::size_t position = find_keyword_top_level(text, keyword);
    if (position == std::string::npos) {
        return {};
    }

    const std::size_t value_start = position + keyword.size();
    const std::size_t value_end = find_first_keyword_top_level(text, stop_keywords, value_start);
    if (value_end == std::string::npos) {
        return trim_copy(text.substr(value_start));
    }
    return trim_copy(text.substr(value_start, value_end - value_start));
}

std::vector<ReplaceAssignment> parse_replace_assignments(const std::string& text) {
    std::vector<ReplaceAssignment> assignments;
    for (const std::string& part : split_csv_like(text)) {
        const std::size_t with_position = find_keyword_top_level(part, "WITH");
        if (with_position == std::string::npos) {
            continue;
        }
        assignments.push_back({
            .field_name = trim_copy(part.substr(0U, with_position)),
            .expression = trim_copy(part.substr(with_position + 4U))
        });
    }
    return assignments;
}

std::vector<CalculateAssignment> parse_calculate_assignments(const std::string& text) {
    std::vector<CalculateAssignment> assignments;
    for (const std::string& part : split_csv_like(text)) {
        std::size_t to_position = find_keyword_top_level(part, "INTO");
        std::size_t keyword_length = 4U;
        if (to_position == std::string::npos) {
            to_position = find_keyword_top_level(part, "TO");
            keyword_length = 2U;
        }
        if (to_position == std::string::npos) {
            continue;
        }
        assignments.push_back({
            .aggregate_expression = trim_copy(part.substr(0U, to_position)),
            .variable_name = trim_copy(part.substr(to_position + keyword_length))
        });
    }
    return assignments;
}

AggregateScopeClause parse_aggregate_scope_clause(const std::string& text, std::string& expression_text) {
    AggregateScopeClause scope;
    expression_text = trim_copy(text);
    if (expression_text.empty()) {
        return scope;
    }

    const std::size_t keyword_position = find_last_keyword_top_level(expression_text, {"NEXT", "RECORD", "REST", "ALL"});
    if (keyword_position == std::string::npos) {
        return scope;
    }

    const std::string keyword_and_tail = trim_copy(expression_text.substr(keyword_position));
    const auto [keyword, tail] = split_first_word(keyword_and_tail);
    const std::string normalized_keyword = normalize_identifier(keyword);

    if ((normalized_keyword == "all" || normalized_keyword == "rest") && !tail.empty()) {
        return scope;
    }
    if ((normalized_keyword == "next" || normalized_keyword == "record") && tail.empty()) {
        return scope;
    }
    if (normalized_keyword != "all" &&
        normalized_keyword != "rest" &&
        normalized_keyword != "next" &&
        normalized_keyword != "record") {
        return scope;
    }

    expression_text = trim_copy(expression_text.substr(0U, keyword_position));
    if (normalized_keyword == "rest") {
        scope.kind = AggregateScopeKind::rest_records;
    } else if (normalized_keyword == "next") {
        scope.kind = AggregateScopeKind::next_records;
        scope.raw_value = tail;
    } else if (normalized_keyword == "record") {
        scope.kind = AggregateScopeKind::record;
        scope.raw_value = tail;
    }
    return scope;
}

std::string format_total_numeric_value(double value, std::uint8_t decimal_count) {
    std::ostringstream stream;
    if (decimal_count == 0U) {
        stream << static_cast<long long>(std::llround(value));
    } else {
        stream << std::fixed << std::setprecision(decimal_count) << value;
    }
    return stream.str();
}

std::optional<TotalCommandPlan> parse_total_command_plan(const std::string& body, std::string& error_message) {
    TotalCommandPlan plan;
    plan.target_expression = extract_command_clause(body, "TO", {"ON"});
    plan.on_field_name = extract_command_clause(body, "ON", {"FIELDS", "FOR", "WHILE", "IN", "NOOPTIMIZE", "ALL", "REST", "NEXT", "RECORD"});
    const std::string fields_text = extract_command_clause(body, "FIELDS", {"FOR", "WHILE", "IN", "NOOPTIMIZE", "ALL", "REST", "NEXT", "RECORD"});
    if (!fields_text.empty()) {
        plan.field_names = split_csv_like(fields_text);
        for (std::string& field_name : plan.field_names) {
            field_name = trim_copy(std::move(field_name));
        }
        plan.field_names.erase(
            std::remove_if(plan.field_names.begin(), plan.field_names.end(), [](const std::string& field_name) {
                return field_name.empty();
            }),
            plan.field_names.end());
    }

    plan.for_expression = extract_command_clause(body, "FOR", {"WHILE", "IN", "NOOPTIMIZE"});
    plan.while_expression = extract_command_clause(body, "WHILE", {"IN", "NOOPTIMIZE"});
    plan.in_expression = extract_command_clause(body, "IN", {"NOOPTIMIZE"});

    std::string scope_text = trim_copy(body);
    const std::size_t for_position = find_first_keyword_top_level(scope_text, {"FOR", "WHILE", "IN", "NOOPTIMIZE"});
    if (for_position != std::string::npos) {
        scope_text = trim_copy(scope_text.substr(0U, for_position));
    }
    std::string ignored_expression;
    plan.scope = parse_aggregate_scope_clause(scope_text, ignored_expression);

    if (plan.target_expression.empty()) {
        error_message = "TOTAL requires a TO target";
        return std::nullopt;
    }
    if (plan.on_field_name.empty()) {
        error_message = "TOTAL requires an ON field";
        return std::nullopt;
    }
    return plan;
}

Program parse_program(const std::string& path) {
    Program program;
    program.path = normalize_path(path);
    program.main.name = "main";

    Routine* current = &program.main;
    for (const auto& logical_line : load_logical_lines(path)) {
        const std::size_t line_number = logical_line.line_number;
        const std::string line = trim_copy(logical_line.text);
        if (line.empty()) {
            continue;
        }
        if (line[0] == '*' || starts_with_insensitive(line, "* ") || starts_with_insensitive(line, "#")) {
            continue;
        }

        const std::string upper = uppercase_copy(line);
        if (starts_with_insensitive(line, "PROCEDURE ") || starts_with_insensitive(line, "FUNCTION ")) {
            const auto separator = line.find(' ');
            Routine routine;
            routine.name = trim_copy(line.substr(separator + 1U));
            current = &program.routines[normalize_identifier(routine.name)];
            *current = std::move(routine);
            continue;
        }
        if (starts_with_insensitive(line, "ENDPROC") || starts_with_insensitive(line, "ENDFUNC") || starts_with_insensitive(line, "END FUNC")) {
            current = &program.main;
            continue;
        }

        Statement statement = make_statement(StatementKind::no_op, path, line_number, line);
        if (starts_with_insensitive(line, "IF ")) {
            statement.kind = StatementKind::if_statement;
            statement.expression = trim_copy(line.substr(3U));
        } else if (upper == "DO CASE") {
            statement.kind = StatementKind::do_case_statement;
        } else if (starts_with_insensitive(line, "CASE ")) {
            statement.kind = StatementKind::case_statement;
            statement.expression = trim_copy(line.substr(5U));
        } else if (upper == "OTHERWISE") {
            statement.kind = StatementKind::otherwise_statement;
        } else if (upper == "ELSE") {
            statement.kind = StatementKind::else_statement;
        } else if (upper == "ENDIF") {
            statement.kind = StatementKind::endif_statement;
        } else if (starts_with_insensitive(line, "FOR ")) {
            statement.kind = StatementKind::for_statement;
            const std::string body = trim_copy(line.substr(4U));
            const auto equals = body.find('=');
            const auto to_position = uppercase_copy(body).find(" TO ");
            if (equals != std::string::npos && to_position != std::string::npos && to_position > equals) {
                statement.identifier = trim_copy(body.substr(0U, equals));
                statement.expression = trim_copy(body.substr(equals + 1U, to_position - equals - 1U));
                const auto step_position = uppercase_copy(body).find(" STEP ", to_position + 4U);
                if (step_position == std::string::npos) {
                    statement.secondary_expression = trim_copy(body.substr(to_position + 4U));
                } else {
                    statement.secondary_expression = trim_copy(body.substr(to_position + 4U, step_position - to_position - 4U));
                    statement.tertiary_expression = trim_copy(body.substr(step_position + 6U));
                }
            }
        } else if (starts_with_insensitive(line, "DO WHILE ")) {
            statement.kind = StatementKind::do_while_statement;
            statement.expression = trim_copy(line.substr(9U));
        } else if (upper == "ENDFOR") {
            statement.kind = StatementKind::endfor_statement;
        } else if (upper == "ENDDO") {
            statement.kind = StatementKind::enddo_statement;
        } else if (upper == "ENDCASE") {
            statement.kind = StatementKind::endcase_statement;
        } else if (upper == "LOOP" || upper == "CONTINUE") {
            statement.kind = StatementKind::loop_statement;
        } else if (upper == "EXIT") {
            statement.kind = StatementKind::exit_statement;
        } else if (starts_with_insensitive(line, "DO FORM ")) {
            statement.kind = StatementKind::do_form;
            statement.identifier = trim_copy(line.substr(8U));
        } else if (starts_with_insensitive(line, "REPORT FORM ")) {
            statement.kind = StatementKind::report_form;
            statement.identifier = trim_copy(line.substr(12U));
        } else if (starts_with_insensitive(line, "LABEL FORM ")) {
            statement.kind = StatementKind::label_form;
            statement.identifier = trim_copy(line.substr(11U));
        } else if (starts_with_insensitive(line, "ACTIVATE POPUP ")) {
            statement.kind = StatementKind::activate_surface;
            statement.identifier = "popup";
            statement.expression = trim_copy(line.substr(15U));
        } else if (starts_with_insensitive(line, "ACTIVATE MENU ")) {
            statement.kind = StatementKind::activate_surface;
            statement.identifier = "menu";
            statement.expression = trim_copy(line.substr(14U));
        } else if (starts_with_insensitive(line, "RELEASE POPUP ")) {
            statement.kind = StatementKind::release_surface;
            statement.identifier = "popup";
            statement.expression = trim_copy(line.substr(14U));
        } else if (starts_with_insensitive(line, "RELEASE MENU ")) {
            statement.kind = StatementKind::release_surface;
            statement.identifier = "menu";
            statement.expression = trim_copy(line.substr(13U));
        } else if (starts_with_insensitive(line, "DO ")) {
            statement.kind = StatementKind::do_command;
            statement.identifier = trim_copy(line.substr(3U));
        } else if (upper == "READ EVENTS") {
            statement.kind = StatementKind::read_events;
        } else if (upper == "CLEAR EVENTS") {
            statement.kind = StatementKind::clear_events;
        } else if (starts_with_insensitive(line, "SEEK ")) {
            statement.kind = StatementKind::seek_command;
            const std::string body = trim_copy(line.substr(5U));
            const std::size_t tail_start = find_first_keyword_top_level(body, {"ORDER", "TAG", "IN"});
            statement.expression = tail_start == std::string::npos ? body : trim_copy(body.substr(0U, tail_start));
            statement.secondary_expression = extract_command_clause(body, "IN", {"ORDER", "TAG"});
            statement.tertiary_expression = extract_command_clause(body, "ORDER", {"TAG", "IN"});
            if (statement.tertiary_expression.empty()) {
                const std::string tag_name = extract_command_clause(body, "TAG", {"ORDER", "IN"});
                if (!tag_name.empty()) {
                    statement.tertiary_expression = "TAG " + tag_name;
                }
            }
        } else if (starts_with_insensitive(line, "CALCULATE ")) {
            statement.kind = StatementKind::calculate_command;
            const std::string body = trim_copy(line.substr(10U));
            const std::size_t for_position = find_keyword_top_level(body, "FOR");
            const std::size_t in_position = find_keyword_top_level(body, "IN");
            std::size_t tail_start = std::string::npos;
            if (for_position != std::string::npos && in_position != std::string::npos) {
                tail_start = std::min(for_position, in_position);
            } else if (for_position != std::string::npos) {
                tail_start = for_position;
            } else if (in_position != std::string::npos) {
                tail_start = in_position;
            }
            statement.expression = tail_start == std::string::npos ? body : trim_copy(body.substr(0U, tail_start));
            statement.secondary_expression = extract_command_clause(body, "FOR", {"IN"});
            statement.tertiary_expression = extract_command_clause(body, "IN");
        } else if (upper == "COUNT" || starts_with_insensitive(line, "COUNT ")) {
            statement.kind = StatementKind::count_command;
            const std::string body = upper == "COUNT" ? std::string{} : trim_copy(line.substr(6U));
            const std::size_t tail_start = find_first_keyword_top_level(body, {"FOR", "TO", "INTO", "WHILE", "IN", "NOOPTIMIZE"});
            statement.expression = tail_start == std::string::npos ? body : trim_copy(body.substr(0U, tail_start));
            statement.secondary_expression = extract_command_clause(body, "FOR", {"WHILE", "TO", "INTO", "IN", "NOOPTIMIZE"});
            statement.tertiary_expression = extract_command_clause(body, "WHILE", {"TO", "INTO", "IN", "NOOPTIMIZE"});
            statement.quaternary_expression = extract_command_clause(body, "IN", {"NOOPTIMIZE"});
            statement.identifier = extract_command_clause(body, "INTO", {"FOR", "WHILE", "IN", "NOOPTIMIZE"});
            if (statement.identifier.empty()) {
                statement.identifier = extract_command_clause(body, "TO", {"FOR", "WHILE", "IN", "NOOPTIMIZE"});
            }
        } else if (upper == "SUM" || starts_with_insensitive(line, "SUM ")) {
            statement.kind = StatementKind::sum_command;
            const std::string body = upper == "SUM" ? std::string{} : trim_copy(line.substr(4U));
            const std::size_t tail_start = find_first_keyword_top_level(body, {"FOR", "TO", "INTO", "WHILE", "IN", "NOOPTIMIZE"});
            statement.expression = tail_start == std::string::npos ? body : trim_copy(body.substr(0U, tail_start));
            statement.secondary_expression = extract_command_clause(body, "FOR", {"WHILE", "TO", "INTO", "IN", "NOOPTIMIZE"});
            statement.tertiary_expression = extract_command_clause(body, "WHILE", {"TO", "INTO", "IN", "NOOPTIMIZE"});
            statement.quaternary_expression = extract_command_clause(body, "IN", {"NOOPTIMIZE"});
            statement.identifier = extract_command_clause(body, "INTO", {"FOR", "WHILE", "IN", "NOOPTIMIZE"});
            if (statement.identifier.empty()) {
                statement.identifier = extract_command_clause(body, "TO", {"FOR", "WHILE", "IN", "NOOPTIMIZE"});
            }
        } else if (upper == "AVERAGE" || starts_with_insensitive(line, "AVERAGE ")) {
            statement.kind = StatementKind::average_command;
            const std::string body = upper == "AVERAGE" ? std::string{} : trim_copy(line.substr(8U));
            const std::size_t tail_start = find_first_keyword_top_level(body, {"FOR", "TO", "INTO", "WHILE", "IN", "NOOPTIMIZE"});
            statement.expression = tail_start == std::string::npos ? body : trim_copy(body.substr(0U, tail_start));
            statement.secondary_expression = extract_command_clause(body, "FOR", {"WHILE", "TO", "INTO", "IN", "NOOPTIMIZE"});
            statement.tertiary_expression = extract_command_clause(body, "WHILE", {"TO", "INTO", "IN", "NOOPTIMIZE"});
            statement.quaternary_expression = extract_command_clause(body, "IN", {"NOOPTIMIZE"});
            statement.identifier = extract_command_clause(body, "INTO", {"FOR", "WHILE", "IN", "NOOPTIMIZE"});
            if (statement.identifier.empty()) {
                statement.identifier = extract_command_clause(body, "TO", {"FOR", "WHILE", "IN", "NOOPTIMIZE"});
            }
        } else if (upper == "TOTAL" || starts_with_insensitive(line, "TOTAL ")) {
            statement.kind = StatementKind::total_command;
            statement.expression = upper == "TOTAL" ? std::string{} : trim_copy(line.substr(6U));
        } else if (logical_line.is_text_block && (upper == "TEXT" || starts_with_insensitive(line, "TEXT "))) {
            statement.kind = StatementKind::text_command;
            const std::string body = upper == "TEXT" ? std::string{} : trim_copy(line.substr(4U));
            statement.identifier = extract_command_clause(body, "TO", {"ADDITIVE", "NOSHOW", "TEXTMERGE", "PRETEXT"});
            statement.expression = logical_line.block_text;
            statement.secondary_expression = has_keyword(body, "ADDITIVE") ? "additive" : std::string{};
            statement.tertiary_expression = has_keyword(body, "TEXTMERGE") ? "textmerge" : std::string{};
            statement.quaternary_expression = has_keyword(body, "NOSHOW") ? "noshow" : std::string{};
        } else if (upper == "LOCATE" || starts_with_insensitive(line, "LOCATE ")) {
            statement.kind = StatementKind::locate_command;
            const std::string body = upper == "LOCATE" ? std::string{} : trim_copy(line.substr(7U));
            statement.expression = extract_command_clause(body, "FOR", {"IN"});
            statement.secondary_expression = extract_command_clause(body, "IN");
        } else if (upper == "SCAN" || starts_with_insensitive(line, "SCAN ")) {
            statement.kind = StatementKind::scan_statement;
            const std::string body = upper == "SCAN" ? std::string{} : trim_copy(line.substr(5U));
            statement.expression = extract_command_clause(body, "FOR", {"IN"});
            statement.secondary_expression = extract_command_clause(body, "IN");
        } else if (upper == "ENDSCAN") {
            statement.kind = StatementKind::endscan_statement;
        } else if (upper == "APPEND BLANK") {
            statement.kind = StatementKind::append_blank_command;
        } else if (starts_with_insensitive(line, "REPLACE ")) {
            statement.kind = StatementKind::replace_command;
            const std::string body = trim_copy(line.substr(8U));
            const std::size_t in_position = find_keyword_top_level(body, "IN");
            if (in_position == std::string::npos) {
                statement.expression = body;
            } else {
                statement.expression = trim_copy(body.substr(0U, in_position));
                statement.secondary_expression = trim_copy(body.substr(in_position + 2U));
            }
        } else if (upper == "DELETE" || starts_with_insensitive(line, "DELETE ")) {
            statement.kind = StatementKind::delete_command;
            const std::string body = upper == "DELETE" ? std::string{} : trim_copy(line.substr(7U));
            statement.expression = trim_command_keyword(body, "FOR");
            statement.secondary_expression = trim_command_keyword(body, "IN");
        } else if (upper == "RECALL" || starts_with_insensitive(line, "RECALL ")) {
            statement.kind = StatementKind::recall_command;
            const std::string body = upper == "RECALL" ? std::string{} : trim_copy(line.substr(7U));
            statement.expression = trim_command_keyword(body, "FOR");
            statement.secondary_expression = trim_command_keyword(body, "IN");
        } else if (starts_with_insensitive(line, "GOTO ") || starts_with_insensitive(line, "GO ")) {
            statement.kind = StatementKind::go_command;
            const std::string body = starts_with_insensitive(line, "GOTO ")
                ? trim_copy(line.substr(5U))
                : trim_copy(line.substr(3U));
            statement.expression = take_first_token(body);
            statement.secondary_expression = take_keyword_value(body, "IN");
        } else if (upper == "SKIP" || starts_with_insensitive(line, "SKIP ")) {
            statement.kind = StatementKind::skip_command;
            const std::string body = upper == "SKIP" ? std::string{} : trim_copy(line.substr(5U));
            if (starts_with_insensitive(body, "IN ")) {
                statement.expression = "1";
                statement.secondary_expression = trim_copy(body.substr(3U));
            } else {
                statement.expression = body.empty() ? "1" : take_first_token(body);
                statement.secondary_expression = take_keyword_value(body, "IN");
            }
        } else if (starts_with_insensitive(line, "SELECT ")) {
            statement.kind = StatementKind::select_command;
            statement.expression = trim_copy(line.substr(7U));
        } else if (upper == "USE" || starts_with_insensitive(line, "USE ")) {
            statement.kind = StatementKind::use_command;
            const std::string body = upper == "USE" ? std::string{} : trim_copy(line.substr(4U));
            if (starts_with_insensitive(body, "IN ")) {
                statement.secondary_expression = trim_copy(body.substr(3U));
            } else if (!body.empty()) {
                statement.expression = take_first_token(body);
                statement.identifier = take_keyword_value(body, "ALIAS");
                statement.secondary_expression = take_keyword_value(body, "IN");
                statement.tertiary_expression = has_keyword(body, "AGAIN") ? "again" : std::string{};
            }
        } else if (starts_with_insensitive(line, "SET DATASESSION TO ")) {
            statement.kind = StatementKind::set_datasession;
            statement.expression = trim_copy(line.substr(19U));
        } else if (starts_with_insensitive(line, "SET LIBRARY TO ")) {
            statement.kind = StatementKind::set_library;
            statement.expression = trim_copy(line.substr(15U));
        } else if (starts_with_insensitive(line, "SET ORDER TO ")) {
            statement.kind = StatementKind::set_order;
            const std::string body = trim_copy(line.substr(13U));
            const std::string upper_body = uppercase_copy(body);
            const auto in_position = upper_body.find(" IN ");
            if (in_position == std::string::npos) {
                statement.expression = body;
            } else {
                statement.expression = trim_copy(body.substr(0U, in_position));
                statement.secondary_expression = trim_copy(body.substr(in_position + 4U));
            }
        } else if (starts_with_insensitive(line, "SET DEFAULT TO ")) {
            statement.kind = StatementKind::set_default;
            statement.expression = trim_copy(line.substr(15U));
        } else if (starts_with_insensitive(line, "SET ")) {
            statement.kind = StatementKind::set_command;
            statement.expression = trim_copy(line.substr(4U));
        } else if (starts_with_insensitive(line, "ON ERROR ")) {
            statement.kind = StatementKind::on_error;
            statement.expression = trim_copy(line.substr(9U));
        } else if (starts_with_insensitive(line, "PUBLIC ")) {
            statement.kind = StatementKind::public_declaration;
            statement.names = split_csv_like(line.substr(7U));
        } else if (starts_with_insensitive(line, "LOCAL ")) {
            statement.kind = StatementKind::local_declaration;
            statement.names = split_csv_like(line.substr(6U));
        } else if (upper == "RETURN" || starts_with_insensitive(line, "RETURN ")) {
            statement.kind = StatementKind::return_statement;
        } else {
            const auto equals = line.find('=');
            if (!line.empty() && line[0] == '=') {
                statement.kind = StatementKind::expression;
                statement.expression = trim_copy(line.substr(1U));
            } else if (equals != std::string::npos) {
                statement.kind = StatementKind::assignment;
                statement.identifier = trim_copy(line.substr(0U, equals));
                statement.expression = trim_copy(line.substr(equals + 1U));
            } else {
                statement.kind = StatementKind::expression;
                statement.expression = line;
            }
        }

        current->statements.push_back(std::move(statement));
    }

    return program;
}

PrgValue make_empty_value() {
    return {};
}

PrgValue make_boolean_value(bool value) {
    PrgValue result;
    result.kind = PrgValueKind::boolean;
    result.boolean_value = value;
    return result;
}

PrgValue make_number_value(double value) {
    PrgValue result;
    result.kind = PrgValueKind::number;
    result.number_value = value;
    return result;
}

PrgValue make_string_value(std::string value) {
    PrgValue result;
    result.kind = PrgValueKind::string;
    result.string_value = std::move(value);
    return result;
}

bool value_as_bool(const PrgValue& value) {
    switch (value.kind) {
        case PrgValueKind::boolean:
            return value.boolean_value;
        case PrgValueKind::number:
            return std::abs(value.number_value) > 0.000001;
        case PrgValueKind::string:
            return !value.string_value.empty();
        case PrgValueKind::empty:
            return false;
    }
    return false;
}

double value_as_number(const PrgValue& value) {
    switch (value.kind) {
        case PrgValueKind::boolean:
            return value.boolean_value ? 1.0 : 0.0;
        case PrgValueKind::number:
            return value.number_value;
        case PrgValueKind::string:
            return value.string_value.empty() ? 0.0 : std::stod(value.string_value);
        case PrgValueKind::empty:
            return 0.0;
    }
    return 0.0;
}

std::string value_as_string(const PrgValue& value) {
    switch (value.kind) {
        case PrgValueKind::boolean:
            return value.boolean_value ? "true" : "false";
        case PrgValueKind::number: {
            std::ostringstream stream;
            if (std::abs(value.number_value - std::round(value.number_value)) < 0.000001) {
                stream << std::llround(value.number_value);
            } else {
                stream << value.number_value;
            }
            return stream.str();
        }
        case PrgValueKind::string:
            return value.string_value;
        case PrgValueKind::empty:
            return {};
    }
    return {};
}

}  // namespace

struct PrgRuntimeSession::Impl {
    explicit Impl(RuntimeSessionOptions session_options)
        : options(std::move(session_options)) {
    }

    RuntimeSessionOptions options;
    std::map<std::string, Program> programs;
    std::vector<Frame> stack;
    std::map<std::string, PrgValue> globals;
    std::vector<RuntimeBreakpoint> breakpoints;
    std::vector<RuntimeEvent> events;
    RuntimePauseState last_state{};
    std::string default_directory;
    std::string last_error_message;
    SourceLocation last_fault_location{};
    std::string last_fault_statement;
    std::string error_handler;
    std::map<int, std::map<std::string, std::string>> set_state_by_session;
    int current_data_session = 1;
    std::map<int, int> next_sql_handle_by_session;
    std::map<int, int> next_api_handle_by_session;
    int next_ole_handle = 1;
    std::map<int, DataSessionState> data_sessions;
    std::map<int, std::map<int, RuntimeSqlConnectionState>> sql_connections_by_session;
    std::map<int, RuntimeOleObjectState> ole_objects;
    std::set<std::string> loaded_libraries;
    std::map<int, std::map<int, RegisteredApiFunction>> registered_api_functions_by_session;
    bool entry_pause_pending = false;
    bool waiting_for_events = false;
    std::optional<std::size_t> event_dispatch_return_depth;
    bool restore_event_loop_after_dispatch = false;
    std::size_t executed_statement_count = 0;

    Program& load_program(const std::string& path) {
        const std::string normalized = normalize_path(path);
        const auto existing = programs.find(normalized);
        if (existing != programs.end()) {
            return existing->second;
        }
        auto [inserted, _] = programs.emplace(normalized, parse_program(normalized));
        return inserted->second;
    }

    void push_main_frame(const std::string& path) {
        Program& program = load_program(path);
        stack.push_back({
            .file_path = program.path,
            .routine_name = "main",
            .routine = &program.main,
            .pc = 0
        });
    }

    void push_routine_frame(const std::string& path, const Routine& routine) {
        stack.push_back({
            .file_path = normalize_path(path),
            .routine_name = routine.name,
            .routine = &routine,
            .pc = 0
        });
    }

    const Statement* current_statement() const {
        if (stack.empty()) {
            return nullptr;
        }
        const Frame& frame = stack.back();
        if (frame.routine == nullptr || frame.pc >= frame.routine->statements.size()) {
            return nullptr;
        }
        return &frame.routine->statements[frame.pc];
    }

    DataSessionState& current_session_state() {
        auto [iterator, _] = data_sessions.try_emplace(current_data_session);
        iterator->second.selected_work_area = std::max(1, iterator->second.selected_work_area);
        iterator->second.next_work_area = std::max(1, iterator->second.next_work_area);
        return iterator->second;
    }

    const DataSessionState& current_session_state() const {
        const auto found = data_sessions.find(current_data_session);
        if (found != data_sessions.end()) {
            return found->second;
        }
        static const DataSessionState empty_session{};
        return empty_session;
    }

    int current_selected_work_area() const {
        return current_session_state().selected_work_area;
    }

    std::map<int, RuntimeSqlConnectionState>& current_sql_connections() {
        auto [iterator, _] = sql_connections_by_session.try_emplace(current_data_session);
        return iterator->second;
    }

    const std::map<int, RuntimeSqlConnectionState>& current_sql_connections() const {
        const auto found = sql_connections_by_session.find(current_data_session);
        if (found != sql_connections_by_session.end()) {
            return found->second;
        }

        static const std::map<int, RuntimeSqlConnectionState> empty_connections;
        return empty_connections;
    }

    int& current_sql_handle_counter() {
        auto [iterator, _] = next_sql_handle_by_session.try_emplace(current_data_session, 1);
        iterator->second = std::max(1, iterator->second);
        return iterator->second;
    }

    int& current_api_handle_counter() {
        auto [iterator, _] = next_api_handle_by_session.try_emplace(current_data_session, 1);
        iterator->second = std::max(1, iterator->second);
        return iterator->second;
    }

    std::map<int, RegisteredApiFunction>& current_registered_api_functions() {
        auto [iterator, _] = registered_api_functions_by_session.try_emplace(current_data_session);
        return iterator->second;
    }

    const std::map<int, RegisteredApiFunction>& current_registered_api_functions() const {
        const auto found = registered_api_functions_by_session.find(current_data_session);
        if (found != registered_api_functions_by_session.end()) {
            return found->second;
        }

        static const std::map<int, RegisteredApiFunction> empty_registered_functions;
        return empty_registered_functions;
    }

    RuntimePauseState build_pause_state(DebugPauseReason reason, std::string message = {}) {
        RuntimePauseState state;
        state.paused = reason != DebugPauseReason::completed;
        state.completed = reason == DebugPauseReason::completed;
        state.waiting_for_events = waiting_for_events;
        state.reason = reason;
        state.message = std::move(message);
        state.executed_statement_count = executed_statement_count;
        state.globals = globals;
        state.events = events;
        const DataSessionState& session = current_session_state();
        state.work_area.selected = session.selected_work_area;
        state.work_area.data_session = current_data_session;
        state.work_area.aliases = session.aliases;
        for (const auto& [_, cursor] : session.cursors) {
            state.cursors.push_back({
                .work_area = cursor.work_area,
                .alias = cursor.alias,
                .source_path = cursor.source_path,
                .source_kind = cursor.source_kind,
                .filter_expression = cursor.filter_expression,
                .remote = cursor.remote,
                .record_count = cursor.record_count,
                .recno = cursor.recno,
                .bof = cursor.bof,
                .eof = cursor.eof
            });
        }
        for (const auto& [_, connection] : current_sql_connections()) {
            state.sql_connections.push_back(connection);
        }
        for (const auto& [_, object] : ole_objects) {
            state.ole_objects.push_back(object);
        }

        if (reason == DebugPauseReason::error) {
            const auto error_event = std::find_if(events.rbegin(), events.rend(), [](const RuntimeEvent& event) {
                return event.category == "runtime.error";
            });
            if (error_event != events.rend()) {
                state.location = error_event->location;
            } else if (!last_fault_location.file_path.empty()) {
                state.location = last_fault_location;
            }
            if (!last_fault_statement.empty()) {
                state.statement_text = last_fault_statement;
            }
        } else if (const Statement* statement = current_statement()) {
            state.location = statement->location;
            state.statement_text = statement->text;
        }

        for (auto iterator = stack.rbegin(); iterator != stack.rend(); ++iterator) {
            RuntimeStackFrame frame;
            frame.file_path = iterator->file_path;
            frame.routine_name = iterator->routine_name;
            if (iterator->routine != nullptr && iterator->pc < iterator->routine->statements.size()) {
                frame.line = iterator->routine->statements[iterator->pc].location.line;
            }
            frame.locals = iterator->locals;
            state.call_stack.push_back(std::move(frame));
        }

        last_state = state;
        return state;
    }

    int next_available_work_area() const {
        return std::max(1, current_session_state().next_work_area);
    }

    int allocate_work_area() {
        DataSessionState& session = current_session_state();
        const int allocated = next_available_work_area();
        session.next_work_area = allocated + 1;
        return allocated;
    }

    int reserve_work_area(int requested_area) {
        DataSessionState& session = current_session_state();
        if (requested_area <= 0) {
            return allocate_work_area();
        }
        if (requested_area >= session.next_work_area) {
            session.next_work_area = requested_area + 1;
        }
        return requested_area;
    }

    int select_work_area(int requested_area) {
        DataSessionState& session = current_session_state();
        requested_area = reserve_work_area(requested_area);
        session.selected_work_area = requested_area;
        return session.selected_work_area;
    }

    CursorState* find_cursor_by_area(int area) {
        auto& session = current_session_state();
        const auto found = session.cursors.find(area);
        return found == session.cursors.end() ? nullptr : &found->second;
    }

    const CursorState* find_cursor_by_area(int area) const {
        const auto& session = current_session_state();
        const auto found = session.cursors.find(area);
        return found == session.cursors.end() ? nullptr : &found->second;
    }

    CursorState* find_cursor_by_alias(const std::string& alias) {
        const std::string normalized = normalize_identifier(alias);
        if (normalized.empty()) {
            return find_cursor_by_area(current_selected_work_area());
        }

        auto& session = current_session_state();
        const auto found = std::find_if(session.aliases.begin(), session.aliases.end(), [&](const auto& pair) {
            return normalize_identifier(pair.second) == normalized;
        });
        if (found == session.aliases.end()) {
            return nullptr;
        }
        return find_cursor_by_area(found->first);
    }

    const CursorState* find_cursor_by_alias(const std::string& alias) const {
        const std::string normalized = normalize_identifier(alias);
        if (normalized.empty()) {
            return find_cursor_by_area(current_selected_work_area());
        }

        const auto& session = current_session_state();
        const auto found = std::find_if(session.aliases.begin(), session.aliases.end(), [&](const auto& pair) {
            return normalize_identifier(pair.second) == normalized;
        });
        if (found == session.aliases.end()) {
            return nullptr;
        }
        return find_cursor_by_area(found->first);
    }

    CursorState* resolve_cursor_target(const std::string& designator) {
        const std::string trimmed = trim_copy(designator);
        if (trimmed.empty()) {
            return find_cursor_by_area(current_selected_work_area());
        }

        const std::string normalized_designator =
            trimmed.size() >= 2U && trimmed.front() == '\'' && trimmed.back() == '\''
            ? unquote_string(trimmed)
            : trimmed;

        const bool numeric_selection = std::all_of(normalized_designator.begin(), normalized_designator.end(), [](unsigned char ch) {
            return std::isdigit(ch) != 0;
        });
        if (numeric_selection) {
            return find_cursor_by_area(std::stoi(normalized_designator));
        }
        return find_cursor_by_alias(normalized_designator);
    }

    const CursorState* resolve_cursor_target(const std::string& designator) const {
        const std::string trimmed = trim_copy(designator);
        if (trimmed.empty()) {
            return find_cursor_by_area(current_selected_work_area());
        }

        const std::string normalized_designator =
            trimmed.size() >= 2U && trimmed.front() == '\'' && trimmed.back() == '\''
            ? unquote_string(trimmed)
            : trimmed;

        const bool numeric_selection = std::all_of(normalized_designator.begin(), normalized_designator.end(), [](unsigned char ch) {
            return std::isdigit(ch) != 0;
        });
        if (numeric_selection) {
            return find_cursor_by_area(std::stoi(normalized_designator));
        }
        return find_cursor_by_alias(normalized_designator);
    }

    void close_cursor(const std::string& designator) {
        DataSessionState& session = current_session_state();
        CursorState* cursor = resolve_cursor_target(designator);
        if (cursor == nullptr) {
            return;
        }
        const int closed_work_area = cursor->work_area;
        if (session.selected_work_area == cursor->work_area) {
            session.selected_work_area = cursor->work_area;
        }
        session.aliases.erase(cursor->work_area);
        session.cursors.erase(cursor->work_area);
        session.next_work_area = std::min(session.next_work_area, closed_work_area);
    }

    std::vector<CursorState::OrderState> load_cursor_orders(const std::string& table_path) const {
        std::vector<CursorState::OrderState> orders;
        const auto inspection = vfp::inspect_asset(table_path);
        if (!inspection.ok) {
            return orders;
        }

        for (const auto& index_asset : inspection.indexes) {
            if (!index_asset.probe.tags.empty()) {
                for (const auto& tag : index_asset.probe.tags) {
                    if (tag.key_expression_hint.empty()) {
                        continue;
                    }
                    orders.push_back({
                        .name = tag.name_hint.empty() ? collapse_identifier(tag.key_expression_hint) : tag.name_hint,
                        .expression = tag.key_expression_hint,
                        .index_path = normalize_path(index_asset.path)
                    });
                }
                continue;
            }

            if (!index_asset.probe.key_expression_hint.empty()) {
                const std::string fallback_name = std::filesystem::path(index_asset.path).stem().string();
                orders.push_back({
                    .name = fallback_name.empty() ? collapse_identifier(index_asset.probe.key_expression_hint) : fallback_name,
                    .expression = index_asset.probe.key_expression_hint,
                    .index_path = normalize_path(index_asset.path)
                });
            }
        }

        return orders;
    }

    bool can_open_table_cursor(
        const std::string& resolved_path,
        const std::string& alias,
        bool remote,
        bool allow_again,
        int target_area) {
        DataSessionState& session = current_session_state();
        const std::string normalized_alias = normalize_identifier(alias);
        const std::string normalized_path = normalize_path(resolved_path);

        for (const auto& [work_area, cursor] : session.cursors) {
            if (work_area == target_area) {
                continue;
            }

            if (!normalized_alias.empty() && normalize_identifier(cursor.alias) == normalized_alias) {
                last_error_message = "Alias already open in this data session: " + alias;
                return false;
            }

            if (!remote && !allow_again && !normalized_path.empty() &&
                normalize_path(cursor.source_path) == normalized_path) {
                last_error_message = "Table already open in this data session; USE AGAIN is required: " + resolved_path;
                return false;
            }
        }

        return true;
    }

    std::optional<int> resolve_use_target_work_area(const std::string& in_expression) {
        const std::string trimmed_expression = trim_copy(in_expression);
        if (trimmed_expression.empty()) {
            return current_selected_work_area();
        }

        std::string area_text;
        if (trimmed_expression.size() >= 2U && trimmed_expression.front() == '\'' && trimmed_expression.back() == '\'') {
            area_text = unquote_string(trimmed_expression);
        } else {
            const PrgValue area_value = evaluate_expression(trimmed_expression, stack.back());
            area_text = trim_copy(value_as_string(area_value));
            if (area_text.empty()) {
                const bool bare_identifier = std::all_of(trimmed_expression.begin(), trimmed_expression.end(), [](unsigned char ch) {
                    return std::isalnum(ch) != 0 || ch == '_';
                });
                if (bare_identifier) {
                    area_text = trimmed_expression;
                }
            }
        }
        if (area_text.empty()) {
            return 0;
        }

        const bool numeric_selection = std::all_of(area_text.begin(), area_text.end(), [](unsigned char ch) {
            return std::isdigit(ch) != 0;
        });
        if (numeric_selection) {
            return std::stoi(area_text);
        }

        CursorState* existing = find_cursor_by_alias(area_text);
        if (existing == nullptr) {
            last_error_message = "USE target work area not found: " + area_text;
            return std::nullopt;
        }

        return existing->work_area;
    }

    std::string resolve_sql_cursor_auto_target() {
        return find_cursor_by_area(current_selected_work_area()) == nullptr ? std::string{} : "0";
    }

    bool is_set_enabled(const std::string& option_name) const {
        const auto session_found = set_state_by_session.find(current_data_session);
        if (session_found == set_state_by_session.end()) {
            return false;
        }

        const auto found = session_found->second.find(normalize_identifier(option_name));
        if (found == session_found->second.end()) {
            return false;
        }

        const std::string normalized_value = normalize_identifier(found->second);
        return normalized_value != "off" && normalized_value != "false" && normalized_value != "0";
    }

    std::map<std::string, std::string>& current_set_state() {
        auto [iterator, _] = set_state_by_session.try_emplace(current_data_session);
        return iterator->second;
    }

    const std::map<std::string, std::string>& current_set_state() const {
        const auto found = set_state_by_session.find(current_data_session);
        if (found != set_state_by_session.end()) {
            return found->second;
        }

        static const std::map<std::string, std::string> empty_state;
        return empty_state;
    }

    void move_cursor_to(CursorState& cursor, long long target_recno) {
        if (cursor.record_count == 0U) {
            cursor.recno = 0U;
            cursor.bof = true;
            cursor.eof = true;
            return;
        }

        if (target_recno <= 0) {
            cursor.recno = 0U;
            cursor.bof = true;
            cursor.eof = false;
            return;
        }

        const auto record_count = static_cast<long long>(cursor.record_count);
        if (target_recno > record_count) {
            cursor.recno = static_cast<std::size_t>(record_count + 1);
            cursor.bof = false;
            cursor.eof = true;
            return;
        }

        cursor.recno = static_cast<std::size_t>(target_recno);
        cursor.bof = false;
        cursor.eof = false;
    }

    bool activate_order(CursorState& cursor, const std::string& order_designator) {
        const std::string trimmed = trim_copy(order_designator);
        if (trimmed.empty() || trimmed == "0") {
            cursor.active_order_name.clear();
            cursor.active_order_expression.clear();
            cursor.active_order_path.clear();
            return true;
        }

        std::string target_name = trimmed;
        if (starts_with_insensitive(target_name, "TAG ")) {
            target_name = trim_copy(target_name.substr(4U));
        }
        target_name = unquote_identifier(target_name);

        const bool numeric_selection = !target_name.empty() &&
            std::all_of(target_name.begin(), target_name.end(), [](unsigned char ch) { return std::isdigit(ch) != 0; });
        if (numeric_selection) {
            const std::size_t index = static_cast<std::size_t>(std::max(1, std::stoi(target_name))) - 1U;
            if (index >= cursor.orders.size()) {
                last_error_message = "Requested order does not exist";
                return false;
            }

            cursor.active_order_name = cursor.orders[index].name;
            cursor.active_order_expression = cursor.orders[index].expression;
            cursor.active_order_path = cursor.orders[index].index_path;
            return true;
        }

        const std::string normalized_target = collapse_identifier(target_name);
        const auto found = std::find_if(cursor.orders.begin(), cursor.orders.end(), [&](const CursorState::OrderState& order) {
            return collapse_identifier(order.name) == normalized_target;
        });
        if (found == cursor.orders.end()) {
            last_error_message = "Requested order/tag was not found";
            return false;
        }

        cursor.active_order_name = found->name;
        cursor.active_order_expression = found->expression;
        cursor.active_order_path = found->index_path;
        return true;
    }

    bool seek_in_cursor(CursorState& cursor, const std::string& search_key) {
        cursor.found = false;
        if (cursor.remote) {
            last_error_message = "SEEK is not yet supported on remote SQL cursors";
            move_cursor_to(cursor, static_cast<long long>(cursor.record_count + 1U));
            return false;
        }

        if (cursor.source_path.empty()) {
            last_error_message = "SEEK requires a local table-backed cursor";
            return false;
        }

        if (cursor.active_order_expression.empty()) {
            if (!cursor.orders.empty()) {
                cursor.active_order_name = cursor.orders.front().name;
                cursor.active_order_expression = cursor.orders.front().expression;
                cursor.active_order_path = cursor.orders.front().index_path;
            } else {
                last_error_message = "SEEK requires an active order";
                return false;
            }
        }

        const auto table_result = vfp::parse_dbf_table_from_file(cursor.source_path, cursor.record_count);
        if (!table_result.ok) {
            last_error_message = table_result.error;
            return false;
        }

        const std::string normalized_target = evaluate_index_expression(search_key, vfp::DbfRecord{});
        std::vector<IndexedCandidate> candidates;
        candidates.reserve(table_result.table.records.size());

        for (const auto& record : table_result.table.records) {
            candidates.push_back({
                .key = evaluate_index_expression(cursor.active_order_expression, record),
                .recno = record.record_index + 1U
            });
        }

        std::sort(candidates.begin(), candidates.end(), [](const IndexedCandidate& left, const IndexedCandidate& right) {
            if (left.key != right.key) {
                return left.key < right.key;
            }
            return left.recno < right.recno;
        });

        const auto lower = std::lower_bound(
            candidates.begin(),
            candidates.end(),
            normalized_target,
            [](const IndexedCandidate& candidate, const std::string& value) {
                return candidate.key < value;
            });

        const bool exact_match_required = is_set_enabled("exact");
        const auto is_match = [&](const std::string& candidate) {
            if (exact_match_required) {
                return candidate == normalized_target;
            }
            return candidate.rfind(normalized_target, 0U) == 0U;
        };

        if (lower != candidates.end() && is_match(lower->key)) {
            move_cursor_to(cursor, static_cast<long long>(lower->recno));
            cursor.found = true;
            return true;
        }

        if (is_set_enabled("near") && lower != candidates.end()) {
            move_cursor_to(cursor, static_cast<long long>(lower->recno));
            cursor.found = false;
            return false;
        }

        move_cursor_to(cursor, static_cast<long long>(cursor.record_count + 1U));
        return false;
    }

    CursorPositionSnapshot capture_cursor_snapshot(const CursorState& cursor) const {
        return {
            .recno = cursor.recno,
            .found = cursor.found,
            .bof = cursor.bof,
            .eof = cursor.eof,
            .active_order_name = cursor.active_order_name,
            .active_order_expression = cursor.active_order_expression,
            .active_order_path = cursor.active_order_path
        };
    }

    void restore_cursor_snapshot(CursorState& cursor, const CursorPositionSnapshot& snapshot) const {
        cursor.recno = snapshot.recno;
        cursor.found = snapshot.found;
        cursor.bof = snapshot.bof;
        cursor.eof = snapshot.eof;
        cursor.active_order_name = snapshot.active_order_name;
        cursor.active_order_expression = snapshot.active_order_expression;
        cursor.active_order_path = snapshot.active_order_path;
    }

    bool current_record_matches_visibility(const CursorState& cursor, const Frame& frame, const std::string& extra_expression) {
        const auto record = current_record(cursor);
        if (!record.has_value()) {
            return false;
        }
        if (is_set_enabled("deleted") && record->deleted) {
            return false;
        }
        if (!cursor.filter_expression.empty() && !value_as_bool(evaluate_expression(cursor.filter_expression, frame, &cursor))) {
            return false;
        }
        if (!extra_expression.empty() && !value_as_bool(evaluate_expression(extra_expression, frame, &cursor))) {
            return false;
        }
        return true;
    }

    bool seek_visible_record(
        CursorState& cursor,
        const Frame& frame,
        long long start_recno,
        int direction,
        const std::string& extra_expression,
        bool preserve_on_failure) {
        const CursorPositionSnapshot original = capture_cursor_snapshot(cursor);
        const long long first = direction >= 0 ? std::max<long long>(1, start_recno) : std::min<long long>(start_recno, static_cast<long long>(cursor.record_count));
        for (long long recno = first;
             recno >= 1 && recno <= static_cast<long long>(cursor.record_count);
             recno += direction) {
            move_cursor_to(cursor, recno);
            if (current_record_matches_visibility(cursor, frame, extra_expression)) {
                return true;
            }
        }

        if (preserve_on_failure) {
            restore_cursor_snapshot(cursor, original);
        } else if (direction >= 0) {
            move_cursor_to(cursor, static_cast<long long>(cursor.record_count + 1U));
        } else {
            move_cursor_to(cursor, 0);
        }
        return false;
    }

    bool move_by_visible_records(CursorState& cursor, const Frame& frame, long long delta) {
        if (delta == 0) {
            return current_record_matches_visibility(cursor, frame, {});
        }

        const int direction = delta > 0 ? 1 : -1;
        long long remaining = std::llabs(delta);
        long long next_start = static_cast<long long>(cursor.recno) + direction;
        while (remaining > 0) {
            if (!seek_visible_record(cursor, frame, next_start, direction, {}, false)) {
                return false;
            }
            --remaining;
            next_start = static_cast<long long>(cursor.recno) + direction;
        }
        return true;
    }

    std::optional<vfp::DbfRecord> current_record(const CursorState& cursor) const {
        if (cursor.recno == 0U || cursor.eof) {
            return std::nullopt;
        }

        if (cursor.remote) {
            if (cursor.recno > cursor.record_count) {
                return std::nullopt;
            }
            return make_synthetic_sql_record(cursor.recno);
        }
        if (cursor.source_path.empty()) {
            return std::nullopt;
        }

        const auto table_result = vfp::parse_dbf_table_from_file(cursor.source_path, cursor.recno);
        if (!table_result.ok || cursor.recno > table_result.table.records.size()) {
            return std::nullopt;
        }

        return table_result.table.records[cursor.recno - 1U];
    }

    std::optional<PrgValue> resolve_field_value(const std::string& identifier, const CursorState* preferred_cursor) const {
        const auto value_from_record = [&](const CursorState* cursor, const std::string& field_name) -> std::optional<PrgValue> {
            if (cursor == nullptr) {
                return std::nullopt;
            }
            const auto record = current_record(*cursor);
            if (!record.has_value()) {
                return std::nullopt;
            }
            if (collapse_identifier(field_name) == "DELETED") {
                return make_boolean_value(record->deleted);
            }
            const auto field_value = record_field_value(*record, field_name);
            if (!field_value.has_value()) {
                return std::nullopt;
            }

            const auto raw_field = std::find_if(record->values.begin(), record->values.end(), [&](const vfp::DbfRecordValue& value) {
                return collapse_identifier(value.field_name) == collapse_identifier(field_name);
            });
            if (raw_field == record->values.end()) {
                return make_string_value(*field_value);
            }

            switch (raw_field->field_type) {
                case 'L':
                    return make_boolean_value(normalize_index_value(*field_value) == "true");
                case 'N':
                case 'F':
                case 'I':
                case 'Y':
                    if (trim_copy(*field_value).empty()) {
                        return make_number_value(0.0);
                    }
                    return make_number_value(std::stod(trim_copy(*field_value)));
                default:
                    return make_string_value(*field_value);
            }
        };

        const auto separator = identifier.find('.');
        if (separator != std::string::npos) {
            const std::string designator = identifier.substr(0U, separator);
            const std::string field_name = identifier.substr(separator + 1U);
            if (auto value = value_from_record(resolve_cursor_target(designator), field_name)) {
                return value;
            }
        }

        if (auto value = value_from_record(preferred_cursor, identifier)) {
            return value;
        }

        return value_from_record(resolve_cursor_target({}), identifier);
    }

    std::optional<std::size_t> find_matching_endscan(const Frame& frame, std::size_t pc) const {
        if (frame.routine == nullptr) {
            return std::nullopt;
        }
        int depth = 0;
        for (std::size_t index = pc + 1U; index < frame.routine->statements.size(); ++index) {
            const auto kind = frame.routine->statements[index].kind;
            if (kind == StatementKind::scan_statement) {
                ++depth;
            } else if (kind == StatementKind::endscan_statement) {
                if (depth == 0) {
                    return index;
                }
                --depth;
            }
        }
        return std::nullopt;
    }

    bool locate_next_matching_record(
        CursorState& cursor,
        const std::string& for_expression,
        const Frame& frame,
        std::size_t start_recno) {
        if (!cursor.remote && cursor.source_path.empty()) {
            last_error_message = "This command requires a local table-backed cursor";
            return false;
        }

        const bool found = seek_visible_record(
            cursor,
            frame,
            static_cast<long long>(start_recno),
            1,
            for_expression,
            false);
        cursor.found = found;
        return true;
    }

    bool replace_current_record_fields(
        CursorState& cursor,
        const std::vector<ReplaceAssignment>& assignments,
        const Frame& frame) {
        if (cursor.remote) {
            last_error_message = "REPLACE is not yet supported on remote SQL cursors";
            return false;
        }
        if (cursor.source_path.empty() || cursor.recno == 0U || cursor.eof) {
            last_error_message = "REPLACE requires a current local record";
            return false;
        }

        for (const auto& assignment : assignments) {
            const PrgValue value = evaluate_expression(assignment.expression, frame);
            const auto result = vfp::replace_record_field_value(
                cursor.source_path,
                cursor.recno - 1U,
                assignment.field_name,
                value_as_string(value));
            if (!result.ok) {
                last_error_message = result.error;
                return false;
            }
            cursor.record_count = result.record_count;
        }
        return true;
    }

    bool append_blank_record(CursorState& cursor) {
        if (cursor.remote) {
            last_error_message = "APPEND BLANK is not yet supported on remote SQL cursors";
            return false;
        }
        if (cursor.source_path.empty()) {
            last_error_message = "APPEND BLANK requires a local table-backed cursor";
            return false;
        }

        const auto result = vfp::append_blank_record_to_file(cursor.source_path);
        if (!result.ok) {
            last_error_message = result.error;
            return false;
        }

        cursor.record_count = result.record_count;
        move_cursor_to(cursor, static_cast<long long>(result.record_count));
        cursor.found = false;
        return true;
    }

    bool set_deleted_flag(CursorState& cursor, const Frame& frame, const std::string& for_expression, bool deleted) {
        if (cursor.remote) {
            last_error_message = deleted
                ? "DELETE is not yet supported on remote SQL cursors"
                : "RECALL is not yet supported on remote SQL cursors";
            return false;
        }
        if (cursor.source_path.empty()) {
            last_error_message = "This command requires a local table-backed cursor";
            return false;
        }

        std::vector<std::size_t> target_records;
        if (for_expression.empty()) {
            if (cursor.recno == 0U || cursor.eof) {
                last_error_message = "This command requires a current local record";
                return false;
            }
            target_records.push_back(cursor.recno);
        } else {
            const auto table_result = vfp::parse_dbf_table_from_file(cursor.source_path, cursor.record_count);
            if (!table_result.ok) {
                last_error_message = table_result.error;
                return false;
            }

            const CursorPositionSnapshot original = capture_cursor_snapshot(cursor);
            for (const auto& record : table_result.table.records) {
                move_cursor_to(cursor, static_cast<long long>(record.record_index + 1U));
                if (current_record_matches_visibility(cursor, frame, for_expression)) {
                    target_records.push_back(record.record_index + 1U);
                }
            }
            restore_cursor_snapshot(cursor, original);
        }

        for (const std::size_t recno : target_records) {
            const auto result = vfp::set_record_deleted_flag(cursor.source_path, recno - 1U, deleted);
            if (!result.ok) {
                last_error_message = result.error;
                return false;
            }
            cursor.record_count = result.record_count;
        }

        return true;
    }

    std::string evaluate_cursor_designator_expression(const std::string& expression, const Frame& frame) {
        const std::string trimmed_expression = trim_copy(expression);
        if (trimmed_expression.empty()) {
            return {};
        }

        if (trimmed_expression.size() >= 2U &&
            ((trimmed_expression.front() == '\'' && trimmed_expression.back() == '\'') ||
             (trimmed_expression.front() == '"' && trimmed_expression.back() == '"'))) {
            return unquote_identifier(trimmed_expression);
        }

        const PrgValue evaluated = evaluate_expression(trimmed_expression, frame);
        const std::string designator = trim_copy(value_as_string(evaluated));
        if (!designator.empty()) {
            return designator;
        }

        return is_bare_identifier_text(trimmed_expression) ? trimmed_expression : std::string{};
    }

    std::string try_parse_designator_argument(const std::string& raw_argument, const Frame& frame) {
        if (raw_argument.empty()) {
            return {};
        }

        const std::string designator = evaluate_cursor_designator_expression(raw_argument, frame);
        return resolve_cursor_target(designator) == nullptr ? std::string{} : designator;
    }

    PrgValue aggregate_function_value(
        const std::string& function,
        const std::vector<std::string>& raw_arguments,
        const Frame& frame) {
        std::string value_expression;
        std::string condition_expression;
        std::string designator;

        if (function == "count") {
            if (raw_arguments.size() == 1U) {
                designator = try_parse_designator_argument(raw_arguments[0], frame);
                if (designator.empty()) {
                    condition_expression = raw_arguments[0];
                }
            } else if (raw_arguments.size() >= 2U) {
                condition_expression = raw_arguments[0];
                designator = try_parse_designator_argument(raw_arguments[1], frame);
            }
        } else {
            if (!raw_arguments.empty()) {
                value_expression = raw_arguments[0];
            }
            if (raw_arguments.size() == 2U) {
                designator = try_parse_designator_argument(raw_arguments[1], frame);
                if (designator.empty()) {
                    condition_expression = raw_arguments[1];
                }
            } else if (raw_arguments.size() >= 3U) {
                condition_expression = raw_arguments[1];
                designator = try_parse_designator_argument(raw_arguments[2], frame);
            }
        }

        CursorState* cursor = resolve_cursor_target(designator);
        if (cursor == nullptr) {
            return make_number_value(0.0);
        }

        if (cursor->record_count == 0U || (!cursor->remote && cursor->source_path.empty())) {
            return make_number_value(0.0);
        }

        const CursorPositionSnapshot original = capture_cursor_snapshot(*cursor);
        double sum = 0.0;
        double min_value = 0.0;
        double max_value = 0.0;
        std::size_t matched_count = 0U;

        for (std::size_t recno = 1U; recno <= cursor->record_count; ++recno) {
            move_cursor_to(*cursor, static_cast<long long>(recno));
            if (!current_record_matches_visibility(*cursor, frame, condition_expression)) {
                continue;
            }

            if (function == "count") {
                ++matched_count;
                continue;
            }

            const PrgValue value = evaluate_expression(value_expression, frame, cursor);
            if (value.kind == PrgValueKind::empty) {
                continue;
            }
            if (value.kind == PrgValueKind::string && trim_copy(value.string_value).empty()) {
                continue;
            }

            const double numeric_value = value_as_number(value);
            if (matched_count == 0U) {
                min_value = numeric_value;
                max_value = numeric_value;
            } else {
                min_value = std::min(min_value, numeric_value);
                max_value = std::max(max_value, numeric_value);
            }
            sum += numeric_value;
            ++matched_count;
        }

        restore_cursor_snapshot(*cursor, original);

        if (function == "count") {
            return make_number_value(static_cast<double>(matched_count));
        }
        if (matched_count == 0U) {
            return make_number_value(0.0);
        }
        if (function == "sum") {
            return make_number_value(sum);
        }
        if (function == "avg" || function == "average") {
            return make_number_value(sum / static_cast<double>(matched_count));
        }
        if (function == "min") {
            return make_number_value(min_value);
        }
        if (function == "max") {
            return make_number_value(max_value);
        }
        return make_number_value(0.0);
    }

    std::vector<std::size_t> collect_aggregate_scope_records(
        CursorState& cursor,
        const Frame& frame,
        const AggregateScopeClause& scope,
        const std::string& for_expression,
        const std::string& while_expression) {
        std::vector<std::size_t> records;
        if (cursor.record_count == 0U) {
            return records;
        }

        std::size_t start_recno = 1U;
        std::size_t end_recno = cursor.record_count;
        switch (scope.kind) {
            case AggregateScopeKind::all_records:
                break;
            case AggregateScopeKind::rest_records:
                if (cursor.eof || cursor.recno > cursor.record_count) {
                    return records;
                }
                start_recno = cursor.recno == 0U ? 1U : cursor.recno;
                break;
            case AggregateScopeKind::next_records: {
                const long long requested = static_cast<long long>(std::llround(value_as_number(evaluate_expression(scope.raw_value, frame, &cursor))));
                if (requested <= 0) {
                    return records;
                }
                if (cursor.eof || cursor.recno > cursor.record_count) {
                    return records;
                }
                start_recno = cursor.recno == 0U ? 1U : cursor.recno;
                end_recno = std::min(cursor.record_count, start_recno + static_cast<std::size_t>(requested - 1LL));
                break;
            }
            case AggregateScopeKind::record: {
                const long long requested = static_cast<long long>(std::llround(value_as_number(evaluate_expression(scope.raw_value, frame, &cursor))));
                if (requested < 1LL || requested > static_cast<long long>(cursor.record_count)) {
                    return records;
                }
                start_recno = static_cast<std::size_t>(requested);
                end_recno = start_recno;
                break;
            }
        }

        const CursorPositionSnapshot original = capture_cursor_snapshot(cursor);
        for (std::size_t recno = start_recno; recno <= end_recno; ++recno) {
            move_cursor_to(cursor, static_cast<long long>(recno));
            if (!while_expression.empty() && !value_as_bool(evaluate_expression(while_expression, frame, &cursor))) {
                break;
            }
            if (current_record_matches_visibility(cursor, frame, for_expression)) {
                records.push_back(recno);
            }
        }
        restore_cursor_snapshot(cursor, original);

        return records;
    }

    PrgValue aggregate_record_values(
        CursorState& cursor,
        const std::string& function,
        const std::string& value_expression,
        const std::vector<std::size_t>& records,
        const Frame& frame) {
        if (function == "count") {
            return make_number_value(static_cast<double>(records.size()));
        }
        if (records.empty()) {
            return make_number_value(0.0);
        }

        const CursorPositionSnapshot original = capture_cursor_snapshot(cursor);
        double sum = 0.0;
        double min_value = 0.0;
        double max_value = 0.0;
        std::size_t matched_count = 0U;

        for (const std::size_t recno : records) {
            move_cursor_to(cursor, static_cast<long long>(recno));
            const PrgValue value = evaluate_expression(value_expression, frame, &cursor);
            if (value.kind == PrgValueKind::empty) {
                continue;
            }
            if (value.kind == PrgValueKind::string && trim_copy(value.string_value).empty()) {
                continue;
            }

            const double numeric_value = value_as_number(value);
            if (matched_count == 0U) {
                min_value = numeric_value;
                max_value = numeric_value;
            } else {
                min_value = std::min(min_value, numeric_value);
                max_value = std::max(max_value, numeric_value);
            }
            sum += numeric_value;
            ++matched_count;
        }

        restore_cursor_snapshot(cursor, original);

        if (matched_count == 0U) {
            return make_number_value(0.0);
        }
        if (function == "sum") {
            return make_number_value(sum);
        }
        if (function == "avg" || function == "average") {
            return make_number_value(sum / static_cast<double>(matched_count));
        }
        if (function == "min") {
            return make_number_value(min_value);
        }
        if (function == "max") {
            return make_number_value(max_value);
        }
        return make_number_value(0.0);
    }

    bool execute_total_command(
        const Statement& statement,
        Frame& frame,
        std::string& error_message) {
        const auto parsed = parse_total_command_plan(statement.expression, error_message);
        if (!parsed.has_value()) {
            return false;
        }

        const TotalCommandPlan& plan = *parsed;
        CursorState* cursor = resolve_cursor_target(plan.in_expression);
        if (cursor == nullptr) {
            error_message = plan.in_expression.empty()
                ? "TOTAL requires a selected work area"
                : "TOTAL target work area not found";
            return false;
        }
        if (cursor->remote) {
            error_message = "TOTAL is not implemented for remote SQL cursors yet";
            return false;
        }
        if (cursor->source_path.empty()) {
            error_message = "TOTAL requires a local table-backed cursor";
            return false;
        }

        const auto table_result = vfp::parse_dbf_table_from_file(cursor->source_path, cursor->record_count);
        if (!table_result.ok) {
            error_message = table_result.error;
            return false;
        }

        const auto field_by_name = [&](const std::string& field_name) -> const vfp::DbfFieldDescriptor* {
            const auto found = std::find_if(
                table_result.table.fields.begin(),
                table_result.table.fields.end(),
                [&](const vfp::DbfFieldDescriptor& field) {
                    return collapse_identifier(field.name) == collapse_identifier(field_name);
                });
            return found == table_result.table.fields.end() ? nullptr : &*found;
        };

        const vfp::DbfFieldDescriptor* on_field = field_by_name(plan.on_field_name);
        if (on_field == nullptr) {
            error_message = "TOTAL ON field was not found";
            return false;
        }

        std::vector<const vfp::DbfFieldDescriptor*> total_fields;
        if (plan.field_names.empty()) {
            for (const auto& field : table_result.table.fields) {
                if ((field.type == 'N' || field.type == 'F') &&
                    collapse_identifier(field.name) != collapse_identifier(on_field->name)) {
                    total_fields.push_back(&field);
                }
            }
        } else {
            for (const std::string& field_name : plan.field_names) {
                const vfp::DbfFieldDescriptor* field = field_by_name(field_name);
                if (field == nullptr) {
                    error_message = "TOTAL field was not found: " + field_name;
                    return false;
                }
                if (field->type != 'N' && field->type != 'F') {
                    error_message = "TOTAL only supports numeric FIELDS in the first pass";
                    return false;
                }
                total_fields.push_back(field);
            }
        }
        if (total_fields.empty()) {
            error_message = "TOTAL requires at least one numeric field to total";
            return false;
        }

        std::vector<std::size_t> records = collect_aggregate_scope_records(
            *cursor,
            frame,
            plan.scope,
            plan.for_expression,
            plan.while_expression);
        if (records.empty()) {
            const std::string target_path = value_as_string(evaluate_expression(plan.target_expression, frame));
            std::vector<vfp::DbfFieldDescriptor> output_fields;
            output_fields.push_back(*on_field);
            for (const auto* field : total_fields) {
                vfp::DbfFieldDescriptor output_field = *field;
                output_field.length = static_cast<std::uint8_t>(std::max<int>(output_field.length, output_field.decimal_count == 0U ? 18 : 20));
                output_fields.push_back(output_field);
            }
            const auto create_result = vfp::create_dbf_table_file(target_path, output_fields, {});
            if (!create_result.ok) {
                error_message = create_result.error;
                return false;
            }
            return true;
        }

        struct TotalGroup {
            std::string group_value;
            std::vector<double> sums;
        };

        std::vector<TotalGroup> groups;
        const auto append_record_to_group = [&](const vfp::DbfRecord& record) {
            const std::string group_value = record_field_value(record, on_field->name).value_or(std::string{});
            if (groups.empty() || groups.back().group_value != group_value) {
                groups.push_back({.group_value = group_value, .sums = std::vector<double>(total_fields.size(), 0.0)});
            }

            for (std::size_t index = 0; index < total_fields.size(); ++index) {
                const std::string value_text = trim_copy(record_field_value(record, total_fields[index]->name).value_or(std::string{}));
                if (!value_text.empty()) {
                    groups.back().sums[index] += std::stod(value_text);
                }
            }
        };

        for (const std::size_t recno : records) {
            if (recno == 0U || recno > table_result.table.records.size()) {
                continue;
            }
            append_record_to_group(table_result.table.records[recno - 1U]);
        }

        std::vector<vfp::DbfFieldDescriptor> output_fields;
        output_fields.push_back(*on_field);
        for (const auto* field : total_fields) {
            vfp::DbfFieldDescriptor output_field = *field;
            output_field.length = static_cast<std::uint8_t>(std::max<int>(output_field.length, output_field.decimal_count == 0U ? 18 : 20));
            output_fields.push_back(output_field);
        }

        std::vector<std::vector<std::string>> output_records;
        output_records.reserve(groups.size());
        for (const auto& group : groups) {
            std::vector<std::string> record;
            record.push_back(group.group_value);
            for (std::size_t index = 0; index < total_fields.size(); ++index) {
                record.push_back(format_total_numeric_value(group.sums[index], total_fields[index]->decimal_count));
            }
            output_records.push_back(std::move(record));
        }

        const std::string target_path = value_as_string(evaluate_expression(plan.target_expression, frame));
        const auto create_result = vfp::create_dbf_table_file(target_path, output_fields, output_records);
        if (!create_result.ok) {
            error_message = create_result.error;
            return false;
        }

        return true;
    }

    bool execute_calculate_command(
        const Statement& statement,
        Frame& frame,
        std::string& error_message) {
        const std::vector<CalculateAssignment> assignments = parse_calculate_assignments(statement.expression);
        if (assignments.empty()) {
            error_message = "CALCULATE requires one or more aggregate TO/INTO assignments";
            return false;
        }

        for (const auto& assignment : assignments) {
            const std::size_t open_paren = assignment.aggregate_expression.find('(');
            const std::size_t close_paren = assignment.aggregate_expression.rfind(')');
            if (open_paren == std::string::npos || close_paren == std::string::npos || close_paren <= open_paren) {
                error_message = "CALCULATE requires aggregate expressions like COUNT() or SUM(field)";
                return false;
            }

            const std::string function = normalize_identifier(assignment.aggregate_expression.substr(0U, open_paren));
            const std::string inner = trim_copy(assignment.aggregate_expression.substr(open_paren + 1U, close_paren - open_paren - 1U));
            std::vector<std::string> raw_arguments;
            if (!inner.empty()) {
                raw_arguments = split_csv_like(inner);
            }
            if (!statement.secondary_expression.empty()) {
                if (function == "count") {
                    if (raw_arguments.empty()) {
                        raw_arguments.push_back(statement.secondary_expression);
                    } else {
                        raw_arguments[0] = "(" + raw_arguments[0] + ") AND (" + statement.secondary_expression + ")";
                    }
                } else if (raw_arguments.size() < 2U) {
                    raw_arguments.push_back(statement.secondary_expression);
                } else {
                    raw_arguments[1] = "(" + raw_arguments[1] + ") AND (" + statement.secondary_expression + ")";
                }
            }
            if (!statement.tertiary_expression.empty()) {
                raw_arguments.push_back(statement.tertiary_expression);
            }

            assign_variable(frame, assignment.variable_name, aggregate_function_value(function, raw_arguments, frame));
        }

        return true;
    }

    bool execute_command_aggregate(
        const Statement& statement,
        Frame& frame,
        const std::string& function,
        std::string& error_message) {
        if (starts_with_insensitive(statement.identifier, "ARRAY ")) {
            error_message = uppercase_copy(function) + " TO ARRAY is not implemented yet";
            return false;
        }

        CursorState* cursor = resolve_cursor_target(statement.quaternary_expression);
        if (cursor == nullptr) {
            error_message = statement.quaternary_expression.empty()
                ? uppercase_copy(function) + " requires a selected work area"
                : uppercase_copy(function) + " target work area not found";
            return false;
        }
        std::vector<std::string> targets;
        if (!statement.identifier.empty()) {
            targets = split_csv_like(statement.identifier);
        }
        for (std::string& target : targets) {
            target = trim_copy(std::move(target));
        }

        std::string expression_text;
        const AggregateScopeClause scope = parse_aggregate_scope_clause(statement.expression, expression_text);

        if (function == "count") {
            const std::string normalized_expression = normalize_identifier(expression_text);
            if (!expression_text.empty() && normalized_expression != "all") {
                error_message = "COUNT only supports the first-pass ALL/FOR/TO forms right now";
                return false;
            }
            if (targets.size() > 1U) {
                error_message = "COUNT TO only accepts a single variable target";
                return false;
            }

            const std::vector<std::size_t> records = collect_aggregate_scope_records(
                *cursor,
                frame,
                scope,
                statement.secondary_expression,
                statement.tertiary_expression);
            const PrgValue result = aggregate_record_values(*cursor, function, {}, records, frame);
            if (!targets.empty()) {
                assign_variable(frame, targets.front(), result);
            }
            return true;
        }

        if (normalize_identifier(expression_text) == "all") {
            error_message = uppercase_copy(function) + " without explicit expressions is not implemented yet";
            return false;
        }
        if (expression_text.empty()) {
            error_message = uppercase_copy(function) + " requires one or more expressions";
            return false;
        }

        std::vector<std::string> expressions = split_csv_like(expression_text);
        for (std::string& expression : expressions) {
            expression = trim_copy(std::move(expression));
        }
        expressions.erase(
            std::remove_if(expressions.begin(), expressions.end(), [](const std::string& expression) {
                return expression.empty();
            }),
            expressions.end());
        if (expressions.empty()) {
            error_message = uppercase_copy(function) + " requires one or more expressions";
            return false;
        }
        if (!targets.empty() && targets.size() != expressions.size()) {
            error_message = uppercase_copy(function) + " TO requires one variable per aggregate expression";
            return false;
        }

        const std::vector<std::size_t> records = collect_aggregate_scope_records(
            *cursor,
            frame,
            scope,
            statement.secondary_expression,
            statement.tertiary_expression);
        for (std::size_t index = 0; index < expressions.size(); ++index) {
            const PrgValue result = aggregate_record_values(*cursor, function, expressions[index], records, frame);
            if (!targets.empty()) {
                assign_variable(frame, targets[index], result);
            }
        }

        return true;
    }

    bool execute_seek(
        CursorState& cursor,
        const std::string& search_key,
        bool move_pointer,
        bool preserve_pointer_on_miss,
        const std::string& order_designator,
        std::string* error_message = nullptr) {
        const CursorPositionSnapshot original = capture_cursor_snapshot(cursor);
        if (!trim_copy(order_designator).empty() && !activate_order(cursor, order_designator)) {
            if (error_message != nullptr) {
                *error_message = last_error_message;
            }
            restore_cursor_snapshot(cursor, original);
            return false;
        }

        const bool found = seek_in_cursor(cursor, search_key);
        const std::string runtime_error = last_error_message;
        if (!move_pointer || (!found && preserve_pointer_on_miss)) {
            cursor.recno = original.recno;
            cursor.bof = original.bof;
            cursor.eof = original.eof;
            if (!move_pointer) {
                cursor.found = original.found;
            }
        }
        cursor.active_order_name = original.active_order_name;
        cursor.active_order_expression = original.active_order_expression;
        cursor.active_order_path = original.active_order_path;

        if (!found && error_message != nullptr && !runtime_error.empty()) {
            *error_message = runtime_error;
        }

        return found;
    }

    std::string order_function_value(const std::string& designator, bool include_path) const {
        const CursorState* cursor = resolve_cursor_target(designator);
        if (cursor == nullptr || cursor->active_order_name.empty()) {
            return {};
        }

        if (!include_path) {
            return uppercase_copy(cursor->active_order_name);
        }

        if (!cursor->active_order_path.empty()) {
            return uppercase_copy(cursor->active_order_path);
        }

        return uppercase_copy(cursor->active_order_name);
    }

    std::string tag_function_value(const std::string& index_file_name, std::size_t tag_number, const std::string& designator) const {
        const CursorState* cursor = resolve_cursor_target(designator);
        if (cursor == nullptr || cursor->orders.empty()) {
            return {};
        }

        std::size_t resolved_index = tag_number == 0U ? 0U : tag_number - 1U;
        if (!trim_copy(index_file_name).empty()) {
            const std::string normalized_target_path = normalize_path(unquote_string(index_file_name));
            const std::string normalized_target_name =
                collapse_identifier(std::filesystem::path(normalized_target_path.empty() ? index_file_name : normalized_target_path).filename().string());
            std::vector<const CursorState::OrderState*> matching_orders;
            for (const CursorState::OrderState& order : cursor->orders) {
                const std::string normalized_order_path = normalize_path(order.index_path);
                if ((!normalized_target_path.empty() && normalized_order_path == normalized_target_path) ||
                    collapse_identifier(std::filesystem::path(normalized_order_path).filename().string()) == normalized_target_name) {
                    matching_orders.push_back(&order);
                }
            }
            if (resolved_index < matching_orders.size()) {
                return uppercase_copy(matching_orders[resolved_index]->name);
            }
            return {};
        }

        if (resolved_index >= cursor->orders.size()) {
            return {};
        }

        return uppercase_copy(cursor->orders[resolved_index].name);
    }

    bool is_library_loaded(const std::string& library_name) const {
        return loaded_libraries.contains(normalize_identifier(library_name));
    }

    int register_api_function(
        const std::string& variant,
        const std::string& function_name,
        const std::string& argument_types,
        const std::string& return_type,
        const std::string& dll_name) {
        if (!is_library_loaded("foxtools")) {
            last_error_message = "FOXTOOLS is not loaded";
            return -1;
        }

        const int handle = current_api_handle_counter()++;
        current_registered_api_functions().emplace(handle, RegisteredApiFunction{
            .handle = handle,
            .variant = variant,
            .function_name = function_name,
            .argument_types = argument_types,
            .return_type = return_type,
            .dll_name = dll_name
        });
        events.push_back({
            .category = "interop.regfn",
            .detail = variant + ":" + function_name + "@" + dll_name + " -> " + std::to_string(handle),
            .location = current_statement() == nullptr ? SourceLocation{} : current_statement()->location
        });
        return handle;
    }

    PrgValue call_registered_api_function(int handle, const std::vector<PrgValue>& arguments) {
        const auto& registered_functions = current_registered_api_functions();
        const auto found = registered_functions.find(handle);
        if (found == registered_functions.end()) {
            last_error_message = "Registered API handle not found: " + std::to_string(handle);
            return make_number_value(-1.0);
        }

        const RegisteredApiFunction& function = found->second;
        events.push_back({
            .category = "interop.callfn",
            .detail = function.function_name + " (" + std::to_string(arguments.size()) + " args)",
            .location = current_statement() == nullptr ? SourceLocation{} : current_statement()->location
        });

        const std::string normalized_name = normalize_identifier(function.function_name);
        if (normalized_name == "getcurrentprocessid") {
            return make_number_value(static_cast<double>(_getpid()));
        }
        if ((normalized_name == "lstrlena" || normalized_name == "lstrlenw") && !arguments.empty()) {
            return make_number_value(static_cast<double>(value_as_string(arguments.front()).size()));
        }
        if ((normalized_name == "messageboxa" || normalized_name == "messageboxw")) {
            return make_number_value(1.0);
        }
        if ((normalized_name == "getmodulehandlea" || normalized_name == "getmodulehandlew")) {
            return make_number_value(1.0);
        }

        const std::string normalized_return = normalize_identifier(function.return_type);
        if (normalized_return == "c") {
            return make_string_value({});
        }
        if (normalized_return == "f" || normalized_return == "d") {
            return make_number_value(0.0);
        }
        return make_number_value(0.0);
    }

    bool open_table_cursor(
        const std::string& raw_path,
        const std::string& requested_alias,
        const std::string& in_expression,
        bool allow_again,
        bool remote,
        int sql_handle,
        const std::string& sql_command,
        std::size_t synthetic_record_count) {
        (void)sql_command;
        std::string alias = requested_alias;
        std::string resolved_path = raw_path;
        std::string dbf_identity;
        std::size_t field_count = 0;
        std::size_t record_count = synthetic_record_count;

        if (!remote) {
            std::filesystem::path table_path(unquote_string(trim_copy(raw_path)));
            if (table_path.extension().empty()) {
                table_path += ".dbf";
            }
            if (table_path.is_relative()) {
                table_path = std::filesystem::path(default_directory) / table_path;
            }
            table_path = table_path.lexically_normal();
            if (!std::filesystem::exists(table_path)) {
                last_error_message = "Unable to resolve USE target: " + table_path.string();
                return false;
            }

            const auto table_result = vfp::parse_dbf_table_from_file(table_path.string(), 1U);
            if (!table_result.ok) {
                last_error_message = table_result.error;
                return false;
            }

            resolved_path = table_path.string();
            dbf_identity = resolved_path;
            field_count = table_result.table.fields.size();
            record_count = table_result.table.header.record_count;
            std::vector<CursorState::OrderState> orders = load_cursor_orders(resolved_path);
            if (alias.empty()) {
                alias = table_path.stem().string();
            }

            const std::optional<int> requested_target_area = resolve_use_target_work_area(in_expression);
            if (!requested_target_area.has_value()) {
                return false;
            }
            int target_area = *requested_target_area;
            const bool preserve_selected_work_area =
                !trim_copy(in_expression).empty() &&
                target_area > 0 &&
                target_area != current_selected_work_area();
            target_area = preserve_selected_work_area
                ? reserve_work_area(target_area)
                : select_work_area(target_area);

            if (!can_open_table_cursor(resolved_path, alias, false, allow_again, target_area)) {
                return false;
            }

            DataSessionState& session = current_session_state();
            session.aliases[target_area] = alias;
            session.cursors[target_area] = CursorState{
                .work_area = target_area,
                .alias = alias,
                .source_path = resolved_path,
                .dbf_identity = dbf_identity,
                .source_kind = "table",
                .remote = false,
                .field_count = field_count,
                .record_count = record_count,
                .recno = record_count == 0U ? 0U : 1U,
                .found = false,
                .bof = record_count == 0U,
                .eof = record_count == 0U,
                .orders = std::move(orders)
            };
            return true;
        } else if (alias.empty()) {
            alias = "sqlresult" + std::to_string(next_available_work_area());
        }
        if (remote) {
            dbf_identity = alias;
            field_count = synthetic_record_count == 0U ? 0U : 3U;
        }

        const std::optional<int> requested_target_area = resolve_use_target_work_area(in_expression);
        if (!requested_target_area.has_value()) {
            return false;
        }
        int target_area = *requested_target_area;
        const bool preserve_selected_work_area =
            !trim_copy(in_expression).empty() &&
            target_area > 0 &&
            target_area != current_selected_work_area();
        target_area = preserve_selected_work_area
            ? reserve_work_area(target_area)
            : select_work_area(target_area);

        if (!can_open_table_cursor(resolved_path, alias, remote, allow_again, target_area)) {
            return false;
        }

        DataSessionState& session = current_session_state();
        session.aliases[target_area] = alias;
        session.cursors[target_area] = CursorState{
            .work_area = target_area,
            .alias = alias,
            .source_path = resolved_path,
            .dbf_identity = dbf_identity,
            .source_kind = remote ? "sql-cursor" : "table",
            .remote = remote,
            .field_count = field_count,
            .record_count = record_count,
            .recno = record_count == 0U ? 0U : 1U,
            .found = false,
            .bof = record_count == 0U,
            .eof = record_count == 0U
        };
        if (remote && sql_handle > 0) {
            auto& connections = current_sql_connections();
            auto found = connections.find(sql_handle);
            if (found != connections.end()) {
                found->second.last_cursor_alias = alias;
                found->second.last_result_count = record_count;
            }
        }
        return true;
    }

    int sql_connect(const std::string& target, const std::string& provider) {
        int& next_handle = current_sql_handle_counter();
        const int handle = next_handle++;
        current_sql_connections().emplace(handle, RuntimeSqlConnectionState{
            .handle = handle,
            .target = target,
            .provider = provider,
            .last_cursor_alias = {},
            .last_result_count = 0U
        });
        return handle;
    }

    bool sql_disconnect(int handle) {
        return current_sql_connections().erase(handle) > 0;
    }

    int sql_exec(int handle, const std::string& command, const std::string& cursor_alias) {
        auto& connections = current_sql_connections();
        const auto found = connections.find(handle);
        if (found == connections.end()) {
            last_error_message = "SQL handle not found: " + std::to_string(handle);
            return -1;
        }

        std::size_t result_count = 0;
        const std::string normalized_command = lowercase_copy(trim_copy(command));
        if (normalized_command.rfind("select", 0) == 0) {
            result_count = 3U;
            const std::string alias = trim_copy(cursor_alias).empty()
                ? "sqlresult" + std::to_string(handle)
                : trim_copy(cursor_alias);
            if (!open_table_cursor({}, alias, resolve_sql_cursor_auto_target(), true, true, handle, command, result_count)) {
                return -1;
            }
        }
        events.push_back({
            .category = "sql.exec",
            .detail = "handle " + std::to_string(handle) + ": " + command,
            .location = current_statement() == nullptr ? SourceLocation{} : current_statement()->location
        });
        if (result_count > 0U) {
            events.push_back({
                .category = "sql.cursor",
                .detail = found->second.last_cursor_alias + " (" + std::to_string(result_count) + " rows)",
                .location = current_statement() == nullptr ? SourceLocation{} : current_statement()->location
            });
        }
        return 1;
    }

    int register_ole_object(const std::string& prog_id, const std::string& source) {
        const int handle = next_ole_handle++;
        ole_objects.emplace(handle, RuntimeOleObjectState{
            .handle = handle,
            .prog_id = prog_id,
            .source = source,
            .last_action = source,
            .action_count = 1
        });
        return handle;
    }

    std::optional<RuntimeOleObjectState*> resolve_ole_object(const PrgValue& value) {
        int handle = 0;
        std::string prog_id;
        if (!parse_object_handle_reference(value, handle, prog_id)) {
            return std::nullopt;
        }

        auto found = ole_objects.find(handle);
        if (found == ole_objects.end()) {
            return std::nullopt;
        }
        return &found->second;
    }

    PrgValue evaluate_expression(const std::string& expression, const Frame& frame);
    PrgValue evaluate_expression(const std::string& expression, const Frame& frame, const CursorState* preferred_cursor);
    std::optional<std::string> materialize_xasset_bootstrap(const std::string& asset_path, bool include_read_events);

    void assign_variable(Frame& frame, const std::string& name, const PrgValue& value) {
        const std::string normalized = normalize_identifier(name);
        if (frame.local_names.contains(normalized) || frame.locals.contains(normalized)) {
            frame.locals[normalized] = value;
            return;
        }
        globals[normalized] = value;
    }

    PrgValue lookup_variable(const Frame& frame, const std::string& name) const {
        const std::string normalized = normalize_identifier(name);
        if (const auto local = frame.locals.find(normalized); local != frame.locals.end()) {
            return local->second;
        }
        if (const auto global = globals.find(normalized); global != globals.end()) {
            return global->second;
        }
        return {};
    }

    bool breakpoint_matches(const SourceLocation& location) const {
        const std::string normalized = normalize_path(location.file_path);
        return std::any_of(breakpoints.begin(), breakpoints.end(), [&](const RuntimeBreakpoint& breakpoint) {
            return normalize_path(breakpoint.file_path) == normalized && breakpoint.line == location.line;
        });
    }

    std::optional<std::size_t> find_matching_branch(const Frame& frame, std::size_t pc, bool seek_else) const {
        if (frame.routine == nullptr) {
            return std::nullopt;
        }
        int depth = 0;
        for (std::size_t index = pc + 1U; index < frame.routine->statements.size(); ++index) {
            const auto kind = frame.routine->statements[index].kind;
            if (kind == StatementKind::if_statement) {
                ++depth;
            } else if (kind == StatementKind::endif_statement) {
                if (depth == 0) {
                    return index;
                }
                --depth;
            } else if (seek_else && kind == StatementKind::else_statement && depth == 0) {
                return index;
            }
        }
        return std::nullopt;
    }

    std::optional<std::size_t> find_matching_endfor(const Frame& frame, std::size_t pc) const {
        if (frame.routine == nullptr) {
            return std::nullopt;
        }
        int depth = 0;
        for (std::size_t index = pc + 1U; index < frame.routine->statements.size(); ++index) {
            const auto kind = frame.routine->statements[index].kind;
            if (kind == StatementKind::for_statement) {
                ++depth;
            } else if (kind == StatementKind::endfor_statement) {
                if (depth == 0) {
                    return index;
                }
                --depth;
            }
        }
        return std::nullopt;
    }

    std::optional<std::size_t> find_matching_enddo(const Frame& frame, std::size_t pc) const {
        if (frame.routine == nullptr) {
            return std::nullopt;
        }
        int depth = 0;
        for (std::size_t index = pc + 1U; index < frame.routine->statements.size(); ++index) {
            const auto kind = frame.routine->statements[index].kind;
            if (kind == StatementKind::do_while_statement) {
                ++depth;
            } else if (kind == StatementKind::enddo_statement) {
                if (depth == 0) {
                    return index;
                }
                --depth;
            }
        }
        return std::nullopt;
    }

    std::optional<std::size_t> find_matching_endcase(const Frame& frame, std::size_t pc) const {
        if (frame.routine == nullptr) {
            return std::nullopt;
        }
        int depth = 0;
        for (std::size_t index = pc + 1U; index < frame.routine->statements.size(); ++index) {
            const auto kind = frame.routine->statements[index].kind;
            if (kind == StatementKind::do_case_statement) {
                ++depth;
            } else if (kind == StatementKind::endcase_statement) {
                if (depth == 0) {
                    return index;
                }
                --depth;
            }
        }
        return std::nullopt;
    }

    std::optional<std::size_t> find_next_case_clause(const Frame& frame, std::size_t pc) const {
        if (frame.routine == nullptr) {
            return std::nullopt;
        }
        int depth = 0;
        for (std::size_t index = pc + 1U; index < frame.routine->statements.size(); ++index) {
            const auto kind = frame.routine->statements[index].kind;
            if (kind == StatementKind::do_case_statement) {
                ++depth;
            } else if (kind == StatementKind::endcase_statement) {
                if (depth == 0) {
                    return index;
                }
                --depth;
            } else if (depth == 0 && (kind == StatementKind::case_statement || kind == StatementKind::otherwise_statement)) {
                return index;
            }
        }
        return std::nullopt;
    }

    enum class ActiveLoopKind {
        for_loop,
        scan_loop,
        while_loop
    };

    struct ActiveLoop {
        ActiveLoopKind kind = ActiveLoopKind::for_loop;
        std::size_t start_statement_index = 0;
        std::size_t end_statement_index = 0;
    };

    std::optional<ActiveLoop> find_innermost_active_loop(const Frame& frame) const {
        std::optional<ActiveLoop> active;
        const auto consider = [&](ActiveLoop candidate) {
            if (!active.has_value() || candidate.start_statement_index > active->start_statement_index) {
                active = candidate;
            }
        };

        if (!frame.loops.empty()) {
            const LoopState& loop = frame.loops.back();
            consider({
                .kind = ActiveLoopKind::for_loop,
                .start_statement_index = loop.for_statement_index,
                .end_statement_index = loop.endfor_statement_index
            });
        }
        if (!frame.scans.empty()) {
            const ScanState& scan = frame.scans.back();
            consider({
                .kind = ActiveLoopKind::scan_loop,
                .start_statement_index = scan.scan_statement_index,
                .end_statement_index = scan.endscan_statement_index
            });
        }
        if (!frame.whiles.empty()) {
            const WhileState& loop = frame.whiles.back();
            consider({
                .kind = ActiveLoopKind::while_loop,
                .start_statement_index = loop.do_while_statement_index,
                .end_statement_index = loop.enddo_statement_index
            });
        }

        return active;
    }

    ExecutionOutcome continue_for_loop(Frame& frame, const Statement&, bool jump_after_completion) {
        if (frame.loops.empty()) {
            return {};
        }

        LoopState& loop = frame.loops.back();
        const double next_value = value_as_number(lookup_variable(frame, loop.variable_name)) + loop.step_value;
        assign_variable(frame, loop.variable_name, make_number_value(next_value));
        const bool should_continue = loop.step_value >= 0.0
            ? next_value <= loop.end_value
            : next_value >= loop.end_value;
        if (should_continue) {
            frame.pc = loop.for_statement_index + 1U;
        } else {
            const std::size_t completion_pc = loop.endfor_statement_index + 1U;
            frame.loops.pop_back();
            if (jump_after_completion) {
                frame.pc = completion_pc;
            }
        }
        return {};
    }

    ExecutionOutcome continue_scan_loop(Frame& frame, const Statement& statement, bool jump_after_completion) {
        if (frame.scans.empty()) {
            return {};
        }

        ScanState scan = frame.scans.back();
        CursorState* cursor = find_cursor_by_area(scan.work_area);
        if (cursor == nullptr) {
            frame.scans.pop_back();
            return {};
        }

        if (!locate_next_matching_record(*cursor, scan.for_expression, frame, cursor->recno + 1U)) {
            last_fault_location = statement.location;
            last_fault_statement = statement.text;
            return {.ok = false, .message = last_error_message};
        }

        if (cursor->found) {
            frame.pc = scan.scan_statement_index + 1U;
        } else {
            frame.scans.pop_back();
            if (jump_after_completion) {
                frame.pc = scan.endscan_statement_index + 1U;
            }
        }
        return {};
    }

    std::filesystem::path resolve_asset_path(const std::string& raw_path, const char* extension) const {
        std::filesystem::path asset_path(unquote_string(take_first_token(raw_path)));
        if (asset_path.extension().empty()) {
            asset_path += extension;
        }
        if (asset_path.is_relative()) {
            asset_path = std::filesystem::path(default_directory) / asset_path;
        }
        return asset_path.lexically_normal();
    }

    ExecutionOutcome open_report_surface(const Statement& statement, const char* extension, const char* category) {
        const std::filesystem::path asset_path = resolve_asset_path(statement.identifier, extension);
        if (!std::filesystem::exists(asset_path)) {
            last_error_message = std::string("Unable to resolve report asset: ") + asset_path.string();
            last_fault_location = statement.location;
            last_fault_statement = statement.text;
            return {.ok = false, .message = last_error_message};
        }

        const auto open_result = studio::open_document({
            .path = asset_path.string(),
            .read_only = true,
            .load_full_table = true
        });
        if (!open_result.ok) {
            last_error_message = open_result.error;
            last_fault_location = statement.location;
            last_fault_statement = statement.text;
            return {.ok = false, .message = last_error_message};
        }

        const auto layout = studio::build_report_layout(open_result.document);
        waiting_for_events = true;
        events.push_back({
            .category = category,
            .detail = asset_path.string(),
            .location = statement.location
        });
        if (layout.available) {
            events.push_back({
                .category = std::string(category) + ".layout",
                .detail = std::to_string(layout.sections.size()) + " sections",
                .location = statement.location
            });
        }
        return {.waiting_for_events = true};
    }

    bool dispatch_event_handler(const std::string& routine_name);
    ExecutionOutcome execute_current_statement();
    RuntimePauseState run(DebugResumeAction action);
};

namespace {

class ExpressionParser {
public:
    ExpressionParser(
        const std::string& text,
        const Frame& frame,
        const std::map<std::string, PrgValue>& globals,
        const std::string& default_directory,
        const std::string& last_error_message,
        const std::string& error_handler,
        bool exact_string_compare,
        int current_work_area,
        std::function<int()> next_free_work_area_callback,
        std::function<int(const std::string&)> resolve_work_area_callback,
        std::function<std::string(const std::string&)> alias_lookup_callback,
        std::function<bool(const std::string&)> used_callback,
        std::function<std::string(const std::string&)> dbf_lookup_callback,
        std::function<std::size_t(const std::string&)> field_count_callback,
        std::function<std::size_t(const std::string&)> record_count_callback,
        std::function<std::size_t(const std::string&)> recno_callback,
        std::function<bool(const std::string&)> found_callback,
        std::function<bool(const std::string&)> eof_callback,
        std::function<bool(const std::string&)> bof_callback,
        std::function<std::optional<PrgValue>(const std::string&)> field_lookup_callback,
        std::function<PrgValue(const std::string&, const std::vector<std::string>&)> aggregate_callback,
        std::function<std::string(const std::string&, bool)> order_callback,
        std::function<std::string(const std::string&, std::size_t, const std::string&)> tag_callback,
        std::function<bool(const std::string&, bool, const std::string&, const std::string&)> seek_callback,
        std::function<bool(const std::string&, bool, const std::string&, const std::string&)> indexseek_callback,
        std::function<std::string()> foxtoolver_callback,
        std::function<int()> mainhwnd_callback,
        std::function<int(const std::string&, const std::string&, const std::string&, const std::string&, const std::string&)> regfn_callback,
        std::function<PrgValue(int, const std::vector<PrgValue>&)> callfn_callback,
        std::function<int(const std::string&, const std::string&)> sql_connect_callback,
        std::function<int(int, const std::string&, const std::string&)> sql_exec_callback,
        std::function<bool(int)> sql_disconnect_callback,
        std::function<int(const std::string&, const std::string&)> register_ole_callback,
        std::function<PrgValue(const std::string&, const std::string&, const std::vector<PrgValue>&)> ole_invoke_callback,
        std::function<PrgValue(const std::string&)> ole_property_callback,
        std::function<PrgValue(const std::string&)> eval_expression_callback,
        std::function<std::string(const std::string&)> set_callback,
        std::function<void(const std::string&, const std::string&)> record_event_callback)
        : current_work_area_(current_work_area),
          next_free_work_area_callback_(std::move(next_free_work_area_callback)),
          resolve_work_area_callback_(std::move(resolve_work_area_callback)),
          alias_lookup_callback_(std::move(alias_lookup_callback)),
          used_callback_(std::move(used_callback)),
          dbf_lookup_callback_(std::move(dbf_lookup_callback)),
          field_count_callback_(std::move(field_count_callback)),
          record_count_callback_(std::move(record_count_callback)),
          recno_callback_(std::move(recno_callback)),
          found_callback_(std::move(found_callback)),
          eof_callback_(std::move(eof_callback)),
          bof_callback_(std::move(bof_callback)),
          field_lookup_callback_(std::move(field_lookup_callback)),
          aggregate_callback_(std::move(aggregate_callback)),
          order_callback_(std::move(order_callback)),
          tag_callback_(std::move(tag_callback)),
          seek_callback_(std::move(seek_callback)),
          indexseek_callback_(std::move(indexseek_callback)),
          foxtoolver_callback_(std::move(foxtoolver_callback)),
          mainhwnd_callback_(std::move(mainhwnd_callback)),
          regfn_callback_(std::move(regfn_callback)),
          callfn_callback_(std::move(callfn_callback)),
          sql_connect_callback_(std::move(sql_connect_callback)),
          sql_exec_callback_(std::move(sql_exec_callback)),
          sql_disconnect_callback_(std::move(sql_disconnect_callback)),
          register_ole_callback_(std::move(register_ole_callback)),
          ole_invoke_callback_(std::move(ole_invoke_callback)),
          ole_property_callback_(std::move(ole_property_callback)),
          eval_expression_callback_(std::move(eval_expression_callback)),
          set_callback_(std::move(set_callback)),
          record_event_callback_(std::move(record_event_callback)),
          text_(text),
          frame_(frame),
          globals_(globals),
          default_directory_(default_directory),
          last_error_message_(last_error_message),
          error_handler_(error_handler),
          exact_string_compare_(exact_string_compare) {
    }

    PrgValue parse() {
        position_ = 0;
        PrgValue value = parse_comparison();
        skip_whitespace();
        return value;
    }

private:
    PrgValue parse_comparison() {
        PrgValue left = parse_additive();
        while (true) {
            skip_whitespace();
            if (match("<>")) {
                left = make_boolean_value(!values_equal(left, parse_additive()));
            } else if (match("<=")) {
                left = make_boolean_value(value_as_number(left) <= value_as_number(parse_additive()));
            } else if (match(">=")) {
                left = make_boolean_value(value_as_number(left) >= value_as_number(parse_additive()));
            } else if (match("==") || match("=")) {
                left = make_boolean_value(values_equal(left, parse_additive()));
            } else if (match("<")) {
                left = make_boolean_value(value_as_number(left) < value_as_number(parse_additive()));
            } else if (match(">")) {
                left = make_boolean_value(value_as_number(left) > value_as_number(parse_additive()));
            } else {
                return left;
            }
        }
    }

    PrgValue parse_additive() {
        PrgValue left = parse_multiplicative();
        while (true) {
            skip_whitespace();
            if (match("+")) {
                PrgValue right = parse_multiplicative();
                if (left.kind == PrgValueKind::string || right.kind == PrgValueKind::string) {
                    left = make_string_value(value_as_string(left) + value_as_string(right));
                } else {
                    left = make_number_value(value_as_number(left) + value_as_number(right));
                }
            } else if (match("-")) {
                left = make_number_value(value_as_number(left) - value_as_number(parse_multiplicative()));
            } else {
                return left;
            }
        }
    }

    PrgValue parse_multiplicative() {
        PrgValue left = parse_unary();
        while (true) {
            skip_whitespace();
            if (match("*")) {
                left = make_number_value(value_as_number(left) * value_as_number(parse_unary()));
            } else if (match("/")) {
                left = make_number_value(value_as_number(left) / value_as_number(parse_unary()));
            } else {
                return left;
            }
        }
    }

    PrgValue parse_unary() {
        skip_whitespace();
        if (match("!")) {
            return make_boolean_value(!value_as_bool(parse_unary()));
        }
        if (match("-")) {
            return make_number_value(-value_as_number(parse_unary()));
        }
        return parse_primary();
    }

    PrgValue parse_primary() {
        skip_whitespace();
        if (match("(")) {
            PrgValue value = parse_comparison();
            match(")");
            return value;
        }
        if (match("&")) {
            return parse_macro_reference();
        }
        if (peek() == '\'') {
            return make_string_value(parse_string());
        }
        if (peek() == '.') {
            if (match(".T.") || match(".t.")) {
                return make_boolean_value(true);
            }
            if (match(".F.") || match(".f.")) {
                return make_boolean_value(false);
            }
        }
        if (std::isdigit(static_cast<unsigned char>(peek())) != 0) {
            return make_number_value(parse_number());
        }

        const std::string identifier = parse_identifier();
        if (identifier.empty()) {
            return {};
        }

        skip_whitespace();
        if (match("(")) {
            std::vector<PrgValue> arguments;
            std::vector<std::string> raw_arguments;
            skip_whitespace();
            if (!match(")")) {
                while (true) {
                    const std::size_t argument_start = position_;
                    arguments.push_back(parse_comparison());
                    raw_arguments.push_back(trim_copy(text_.substr(argument_start, position_ - argument_start)));
                    skip_whitespace();
                    if (match(")")) {
                        break;
                    }
                    match(",");
                }
            }
            return evaluate_function(identifier, arguments, raw_arguments);
        }

        return resolve_identifier(identifier);
    }

    PrgValue evaluate_function(
        const std::string& identifier,
        const std::vector<PrgValue>& arguments,
        const std::vector<std::string>& raw_arguments) {
        const std::string function = normalize_identifier(identifier);
        const auto member_separator = function.find('.');
        if (member_separator != std::string::npos) {
            const std::string base_name = function.substr(0U, member_separator);
            const std::string member_path = function.substr(member_separator + 1U);
            return ole_invoke_callback_(base_name, member_path, arguments);
        }
        if (function == "count" || function == "sum" || function == "avg" || function == "average" || function == "min" || function == "max") {
            return aggregate_callback_(function, raw_arguments);
        }
        if (function == "select") {
            if (arguments.empty()) {
                return make_number_value(static_cast<double>(current_work_area_));
            }
            if (arguments[0].kind == PrgValueKind::string) {
                return make_number_value(static_cast<double>(resolve_work_area_callback_(value_as_string(arguments[0]))));
            }
            const int requested = static_cast<int>(std::llround(value_as_number(arguments[0])));
            return make_number_value(static_cast<double>(requested == 0 ? next_free_work_area_callback_() : resolve_work_area_callback_(std::to_string(requested))));
        }
        if (function == "alias") {
            const std::string designator = arguments.empty() ? std::string{} : value_as_string(arguments[0]);
            return make_string_value(alias_lookup_callback_(designator));
        }
        if (function == "used") {
            const std::string designator = arguments.empty() ? std::string{} : value_as_string(arguments[0]);
            return make_boolean_value(used_callback_(designator));
        }
        if (function == "dbf") {
            const std::string designator = arguments.empty() ? std::string{} : value_as_string(arguments[0]);
            return make_string_value(dbf_lookup_callback_(designator));
        }
        if (function == "fcount") {
            const std::string designator = arguments.empty() ? std::string{} : value_as_string(arguments[0]);
            return make_number_value(static_cast<double>(field_count_callback_(designator)));
        }
        if (function == "reccount") {
            const std::string designator = arguments.empty() ? std::string{} : value_as_string(arguments[0]);
            return make_number_value(static_cast<double>(record_count_callback_(designator)));
        }
        if (function == "recno") {
            const std::string designator = arguments.empty() ? std::string{} : value_as_string(arguments[0]);
            return make_number_value(static_cast<double>(recno_callback_(designator)));
        }
        if (function == "found") {
            const std::string designator = arguments.empty() ? std::string{} : value_as_string(arguments[0]);
            return make_boolean_value(found_callback_(designator));
        }
        if (function == "eof") {
            const std::string designator = arguments.empty() ? std::string{} : value_as_string(arguments[0]);
            return make_boolean_value(eof_callback_(designator));
        }
        if (function == "bof") {
            const std::string designator = arguments.empty() ? std::string{} : value_as_string(arguments[0]);
            return make_boolean_value(bof_callback_(designator));
        }
        if (function == "deleted") {
            const auto deleted_value = field_lookup_callback_(arguments.empty() ? std::string{"deleted"} : value_as_string(arguments[0]) + ".deleted");
            return deleted_value.has_value() ? *deleted_value : make_boolean_value(false);
        }
        if (function == "order") {
            const std::string designator = arguments.empty() ? std::string{} : value_as_string(arguments[0]);
            const bool include_path = arguments.size() >= 2U && std::abs(value_as_number(arguments[1])) > 0.000001;
            return make_string_value(order_callback_(designator, include_path));
        }
        if (function == "tag") {
            const std::string first = arguments.empty() ? std::string{} : value_as_string(arguments[0]);
            std::size_t tag_number = 1U;
            std::string designator;
            std::string index_file_name;

            if (!first.empty() && is_index_file_path(first)) {
                index_file_name = first;
                if (arguments.size() >= 2U) {
                    tag_number = static_cast<std::size_t>(std::max(1.0, value_as_number(arguments[1])));
                }
                if (arguments.size() >= 3U) {
                    designator = value_as_string(arguments[2]);
                }
            } else {
                if (!first.empty()) {
                    tag_number = static_cast<std::size_t>(std::max(1.0, value_as_number(arguments[0])));
                }
                if (arguments.size() >= 2U) {
                    designator = value_as_string(arguments[1]);
                }
            }

            return make_string_value(tag_callback_(index_file_name, tag_number, designator));
        }
        if (function == "seek" && !arguments.empty()) {
            const std::string search_key = value_as_string(arguments[0]);
            const std::string designator = arguments.size() >= 2U ? value_as_string(arguments[1]) : std::string{};
            const std::string order_designator = arguments.size() >= 3U ? value_as_string(arguments[2]) : std::string{};
            return make_boolean_value(seek_callback_(search_key, true, designator, order_designator));
        }
        if (function == "indexseek" && !arguments.empty()) {
            const std::string search_key = value_as_string(arguments[0]);
            const bool move_pointer = arguments.size() >= 2U && value_as_bool(arguments[1]);
            const std::string designator = arguments.size() >= 3U ? value_as_string(arguments[2]) : std::string{};
            const std::string order_designator = arguments.size() >= 4U ? value_as_string(arguments[3]) : std::string{};
            return make_boolean_value(indexseek_callback_(search_key, move_pointer, designator, order_designator));
        }
        if (function == "foxtoolver") {
            return make_string_value(foxtoolver_callback_());
        }
        if (function == "mainhwnd") {
            return make_number_value(static_cast<double>(mainhwnd_callback_()));
        }
        if ((function == "regfn" || function == "regfn32") && arguments.size() >= 3U) {
            const std::string function_name = value_as_string(arguments[0]);
            const std::string argument_types = arguments.size() >= 2U ? value_as_string(arguments[1]) : std::string{};
            const std::string return_type = arguments.size() >= 3U ? value_as_string(arguments[2]) : std::string{};
            const std::string dll_name = arguments.size() >= 4U ? value_as_string(arguments[3]) : std::string{};
            return make_number_value(static_cast<double>(
                regfn_callback_(function, function_name, argument_types, return_type, dll_name)));
        }
        if (function == "callfn" && !arguments.empty()) {
            const int handle = static_cast<int>(std::llround(value_as_number(arguments[0])));
            std::vector<PrgValue> call_arguments;
            call_arguments.reserve(arguments.size() > 0U ? arguments.size() - 1U : 0U);
            for (std::size_t index = 1U; index < arguments.size(); ++index) {
                call_arguments.push_back(arguments[index]);
            }
            return callfn_callback_(handle, call_arguments);
        }
        if (function == "file" && !arguments.empty()) {
            std::filesystem::path path(value_as_string(arguments[0]));
            if (path.is_relative()) {
                path = std::filesystem::path(default_directory_) / path;
            }
            return make_boolean_value(std::filesystem::exists(path));
        }
        if (function == "sys") {
            if (!arguments.empty() && std::llround(value_as_number(arguments[0])) == 16) {
                return make_string_value(frame_.file_path);
            }
            return make_string_value("0");
        }
        if (function == "at" && arguments.size() >= 2U) {
            const auto found = value_as_string(arguments[1]).find(value_as_string(arguments[0]));
            return make_number_value(found == std::string::npos ? 0.0 : static_cast<double>(found + 1U));
        }
        if (function == "rat" && arguments.size() >= 2U) {
            const auto found = value_as_string(arguments[1]).rfind(value_as_string(arguments[0]));
            return make_number_value(found == std::string::npos ? 0.0 : static_cast<double>(found + 1U));
        }
        if (function == "substr" && arguments.size() >= 2U) {
            const std::string source = value_as_string(arguments[0]);
            const std::size_t start = static_cast<std::size_t>(std::max(0.0, value_as_number(arguments[1]) - 1.0));
            const std::size_t length = arguments.size() >= 3U
                ? static_cast<std::size_t>(std::max(0.0, value_as_number(arguments[2])))
                : std::string::npos;
            return make_string_value(start >= source.size() ? std::string{} : source.substr(start, length));
        }
        if (function == "justpath" && !arguments.empty()) {
            return make_string_value(std::filesystem::path(value_as_string(arguments[0])).parent_path().string());
        }
        if (function == "str" && !arguments.empty()) {
            std::ostringstream stream;
            stream << std::llround(value_as_number(arguments[0]));
            return make_string_value(stream.str());
        }
        if (function == "alltrim" && !arguments.empty()) {
            return make_string_value(trim_copy(value_as_string(arguments[0])));
        }
        if (function == "chr" && !arguments.empty()) {
            return make_string_value(std::string(1U, static_cast<char>(std::llround(value_as_number(arguments[0])))));
        }
        if (function == "message") {
            return make_string_value(last_error_message_);
        }
        if (function == "eval" && !arguments.empty()) {
            return eval_expression_callback_(value_as_string(arguments[0]));
        }
        if (function == "set" && !arguments.empty()) {
            return make_string_value(set_callback_(value_as_string(arguments[0])));
        }
        if (function == "error") {
            return make_number_value(0.0);
        }
        if (function == "version") {
            return make_number_value(arguments.empty() ? 9.0 : 0.0);
        }
        if (function == "on" && !arguments.empty()) {
            return make_string_value(uppercase_copy(value_as_string(arguments[0])) == "ERROR" ? error_handler_ : std::string{});
        }
        if (function == "messagebox" && !arguments.empty()) {
            return make_number_value(1.0);
        }
        if (function == "createobject" && !arguments.empty()) {
            const std::string prog_id = value_as_string(arguments[0]);
            const int handle = register_ole_callback_(prog_id, "createobject");
            record_event_callback_("ole.createobject", prog_id);
            return make_string_value("object:" + prog_id + "#" + std::to_string(handle));
        }
        if (function == "getobject" && !arguments.empty()) {
            const std::string source = value_as_string(arguments[0]);
            const int handle = register_ole_callback_(source, "getobject");
            record_event_callback_("ole.getobject", source);
            return make_string_value("object:" + source + "#" + std::to_string(handle));
        }
        if ((function == "sqlconnect" || function == "sqlstringconnect") && !arguments.empty()) {
            const std::string target = value_as_string(arguments[0]);
            const int handle = sql_connect_callback_(target, function);
            record_event_callback_("sql.connect", function + ":" + target + " -> " + std::to_string(handle));
            return make_number_value(static_cast<double>(handle));
        }
        if (function == "sqlexec" && arguments.size() >= 2U) {
            const int handle = static_cast<int>(std::llround(value_as_number(arguments[0])));
            const std::string command = value_as_string(arguments[1]);
            const std::string cursor_alias = arguments.size() >= 3U ? value_as_string(arguments[2]) : std::string{};
            return make_number_value(static_cast<double>(sql_exec_callback_(handle, command, cursor_alias)));
        }
        if (function == "sqldisconnect" && !arguments.empty()) {
            const int handle = static_cast<int>(std::llround(value_as_number(arguments[0])));
            const bool ok = sql_disconnect_callback_(handle);
            if (ok) {
                record_event_callback_("sql.disconnect", std::to_string(handle));
            }
            return make_number_value(ok ? 1.0 : -1.0);
        }
        return make_string_value(function);
    }

    PrgValue resolve_identifier(const std::string& identifier) const {
        const std::string normalized = normalize_identifier(identifier);
        const auto local = frame_.locals.find(normalized);
        if (local != frame_.locals.end()) {
            return local->second;
        }
        const auto global = globals_.find(normalized);
        if (global != globals_.end()) {
            return global->second;
        }
        if (const auto field = field_lookup_callback_(identifier)) {
            return *field;
        }
        if (normalized.find('.') != std::string::npos) {
            return ole_property_callback_(normalized);
        }
        return {};
    }

    std::string parse_identifier() {
        skip_whitespace();
        const std::size_t start = position_;
        while (position_ < text_.size()) {
            const char ch = text_[position_];
            if (std::isalnum(static_cast<unsigned char>(ch)) != 0 || ch == '_' || ch == '.') {
                ++position_;
                continue;
            }
            break;
        }
        return text_.substr(start, position_ - start);
    }

    PrgValue parse_macro_reference() {
        skip_whitespace();
        const std::size_t start = position_;
        while (position_ < text_.size()) {
            const char ch = text_[position_];
            if (std::isalnum(static_cast<unsigned char>(ch)) != 0 || ch == '_') {
                ++position_;
                continue;
            }
            break;
        }

        const std::string macro_name = text_.substr(start, position_ - start);
        if (macro_name.empty()) {
            return make_empty_value();
        }

        if (peek() == '.') {
            ++position_;
        }

        const std::string expanded = trim_copy(value_as_string(resolve_identifier(macro_name)));
        if (expanded.empty()) {
            return make_empty_value();
        }

        const PrgValue expanded_value = eval_expression_callback_(expanded);
        if (expanded_value.kind != PrgValueKind::empty) {
            return expanded_value;
        }

        return make_string_value(expanded);
    }

    std::string parse_string() {
        std::string result;
        if (!match("'")) {
            return result;
        }
        while (position_ < text_.size()) {
            const char ch = text_[position_++];
            if (ch == '\'') {
                break;
            }
            result.push_back(ch);
        }
        return result;
    }

    double parse_number() {
        const std::size_t start = position_;
        while (position_ < text_.size()) {
            const char ch = text_[position_];
            if (std::isdigit(static_cast<unsigned char>(ch)) != 0 || ch == '.') {
                ++position_;
                continue;
            }
            break;
        }
        return std::stod(text_.substr(start, position_ - start));
    }

    bool match(const std::string& value) {
        skip_whitespace();
        if (text_.compare(position_, value.size(), value) == 0) {
            position_ += value.size();
            return true;
        }
        return false;
    }

    char peek() const {
        return position_ < text_.size() ? text_[position_] : '\0';
    }

    void skip_whitespace() {
        while (position_ < text_.size() && std::isspace(static_cast<unsigned char>(text_[position_])) != 0) {
            ++position_;
        }
    }

    bool values_equal(const PrgValue& left, const PrgValue& right) const {
        if (left.kind == PrgValueKind::string || right.kind == PrgValueKind::string) {
            const std::string left_value = value_as_string(left);
            const std::string right_value = value_as_string(right);
            if (exact_string_compare_) {
                return trim_copy(left_value) == trim_copy(right_value);
            }
            return left_value.rfind(right_value, 0U) == 0U;
        }
        if (left.kind == PrgValueKind::boolean || right.kind == PrgValueKind::boolean) {
            return value_as_bool(left) == value_as_bool(right);
        }
        return std::abs(value_as_number(left) - value_as_number(right)) < 0.000001;
    }

    int current_work_area_ = 1;
    std::function<int()> next_free_work_area_callback_;
    std::function<int(const std::string&)> resolve_work_area_callback_;
    std::function<std::string(const std::string&)> alias_lookup_callback_;
    std::function<bool(const std::string&)> used_callback_;
    std::function<std::string(const std::string&)> dbf_lookup_callback_;
    std::function<std::size_t(const std::string&)> field_count_callback_;
    std::function<std::size_t(const std::string&)> record_count_callback_;
    std::function<std::size_t(const std::string&)> recno_callback_;
    std::function<bool(const std::string&)> found_callback_;
    std::function<bool(const std::string&)> eof_callback_;
    std::function<bool(const std::string&)> bof_callback_;
    std::function<std::optional<PrgValue>(const std::string&)> field_lookup_callback_;
    std::function<PrgValue(const std::string&, const std::vector<std::string>&)> aggregate_callback_;
    std::function<std::string(const std::string&, bool)> order_callback_;
    std::function<std::string(const std::string&, std::size_t, const std::string&)> tag_callback_;
    std::function<bool(const std::string&, bool, const std::string&, const std::string&)> seek_callback_;
    std::function<bool(const std::string&, bool, const std::string&, const std::string&)> indexseek_callback_;
    std::function<std::string()> foxtoolver_callback_;
    std::function<int()> mainhwnd_callback_;
    std::function<int(const std::string&, const std::string&, const std::string&, const std::string&, const std::string&)> regfn_callback_;
    std::function<PrgValue(int, const std::vector<PrgValue>&)> callfn_callback_;
    std::function<int(const std::string&, const std::string&)> sql_connect_callback_;
    std::function<int(int, const std::string&, const std::string&)> sql_exec_callback_;
    std::function<bool(int)> sql_disconnect_callback_;
    std::function<int(const std::string&, const std::string&)> register_ole_callback_;
    std::function<PrgValue(const std::string&, const std::string&, const std::vector<PrgValue>&)> ole_invoke_callback_;
    std::function<PrgValue(const std::string&)> ole_property_callback_;
    std::function<PrgValue(const std::string&)> eval_expression_callback_;
    std::function<std::string(const std::string&)> set_callback_;
    std::function<void(const std::string&, const std::string&)> record_event_callback_;
    const std::string& text_;
    const Frame& frame_;
    const std::map<std::string, PrgValue>& globals_;
    const std::string& default_directory_;
    const std::string& last_error_message_;
    const std::string& error_handler_;
    bool exact_string_compare_ = false;
    std::size_t position_ = 0;
};

}  // namespace

PrgValue PrgRuntimeSession::Impl::evaluate_expression(const std::string& expression, const Frame& frame) {
    return evaluate_expression(expression, frame, resolve_cursor_target({}));
}

PrgValue PrgRuntimeSession::Impl::evaluate_expression(
    const std::string& expression,
    const Frame& frame,
    const CursorState* preferred_cursor) {
    ExpressionParser parser(
        expression,
        frame,
        globals,
        default_directory,
        last_error_message,
        error_handler,
        is_set_enabled("exact"),
        current_selected_work_area(),
        [this]() {
            return next_available_work_area();
        },
        [this](const std::string& designator) {
            if (designator.empty()) {
                return current_selected_work_area();
            }
            const CursorState* cursor = resolve_cursor_target(designator);
            return cursor == nullptr ? 0 : cursor->work_area;
        },
        [this](const std::string& designator) {
            const CursorState* cursor = resolve_cursor_target(designator);
            return cursor == nullptr ? std::string{} : cursor->alias;
        },
        [this](const std::string& designator) {
            return resolve_cursor_target(designator) != nullptr;
        },
        [this](const std::string& designator) {
            const CursorState* cursor = resolve_cursor_target(designator);
            return cursor == nullptr ? std::string{} : cursor->dbf_identity;
        },
        [this](const std::string& designator) {
            const CursorState* cursor = resolve_cursor_target(designator);
            return cursor == nullptr ? 0U : cursor->field_count;
        },
        [this](const std::string& designator) {
            const CursorState* cursor = resolve_cursor_target(designator);
            return cursor == nullptr ? 0U : cursor->record_count;
        },
        [this](const std::string& designator) {
            const CursorState* cursor = resolve_cursor_target(designator);
            return cursor == nullptr ? 0U : cursor->recno;
        },
        [this](const std::string& designator) {
            const CursorState* cursor = resolve_cursor_target(designator);
            return cursor == nullptr ? false : cursor->found;
        },
        [this](const std::string& designator) {
            const CursorState* cursor = resolve_cursor_target(designator);
            return cursor == nullptr ? true : cursor->eof;
        },
        [this](const std::string& designator) {
            const CursorState* cursor = resolve_cursor_target(designator);
            return cursor == nullptr ? true : cursor->bof;
        },
        [this, preferred_cursor](const std::string& identifier) {
            const CursorState* current_cursor = preferred_cursor == nullptr ? resolve_cursor_target({}) : preferred_cursor;
            return resolve_field_value(identifier, current_cursor);
        },
        [this, &frame](const std::string& function_name, const std::vector<std::string>& raw_arguments) {
            return aggregate_function_value(function_name, raw_arguments, frame);
        },
        [this](const std::string& designator, bool include_path) {
            return order_function_value(designator, include_path);
        },
        [this](const std::string& index_file_name, std::size_t tag_number, const std::string& designator) {
            return tag_function_value(index_file_name, tag_number, designator);
        },
        [this](const std::string& search_key, bool move_pointer, const std::string& designator, const std::string& order_designator) {
            CursorState* cursor = resolve_cursor_target(designator);
            if (cursor == nullptr) {
                return false;
            }
            return execute_seek(*cursor, search_key, move_pointer, false, order_designator);
        },
        [this](const std::string& search_key, bool move_pointer, const std::string& designator, const std::string& order_designator) {
            CursorState* cursor = resolve_cursor_target(designator);
            if (cursor == nullptr) {
                return false;
            }
            return execute_seek(*cursor, search_key, move_pointer, true, order_designator);
        },
        [this]() {
            return std::string("FOXTOOLS:9.0");
        },
        []() {
            return 1001;
        },
        [this](const std::string& variant,
               const std::string& function_name,
               const std::string& argument_types,
               const std::string& return_type,
               const std::string& dll_name) {
            return register_api_function(variant, function_name, argument_types, return_type, dll_name);
        },
        [this](int handle, const std::vector<PrgValue>& arguments) {
            return call_registered_api_function(handle, arguments);
        },
        [this](const std::string& target, const std::string& provider) {
            return sql_connect(target, provider);
        },
        [this](int handle, const std::string& command, const std::string& cursor_alias) {
            return sql_exec(handle, command, cursor_alias);
        },
        [this](int handle) {
            return sql_disconnect(handle);
        },
        [this](const std::string& prog_id, const std::string& source) {
            return register_ole_object(prog_id, source);
        },
        [this, &frame](const std::string& base_name, const std::string& member_path, const std::vector<PrgValue>& arguments) {
            const PrgValue object_value = lookup_variable(frame, base_name);
            auto object = resolve_ole_object(object_value);
            if (!object.has_value()) {
                return make_empty_value();
            }

            RuntimeOleObjectState* runtime_object = *object;
            runtime_object->last_action = member_path + "()";
            ++runtime_object->action_count;
            events.push_back({
                .category = "ole.invoke",
                .detail = runtime_object->prog_id + "." + member_path,
                .location = current_statement() == nullptr ? SourceLocation{} : current_statement()->location
            });

            const std::string leaf = member_path.substr(member_path.rfind('.') == std::string::npos ? 0U : member_path.rfind('.') + 1U);
            if (leaf == "add" || leaf == "create" || leaf == "open" || leaf == "item") {
                return make_string_value("object:" + runtime_object->prog_id + "." + member_path + "#" + std::to_string(runtime_object->handle));
            }
            if (arguments.empty()) {
                return make_string_value("ole:" + runtime_object->prog_id + "." + member_path);
            }
            return arguments.front();
        },
        [this, &frame](const std::string& property_path) {
            const auto separator = property_path.find('.');
            if (separator == std::string::npos) {
                return make_empty_value();
            }

            const PrgValue object_value = lookup_variable(frame, property_path.substr(0U, separator));
            auto object = resolve_ole_object(object_value);
            if (!object.has_value()) {
                return make_empty_value();
            }

            RuntimeOleObjectState* runtime_object = *object;
            runtime_object->last_action = property_path.substr(separator + 1U);
            ++runtime_object->action_count;
            events.push_back({
                .category = "ole.get",
                .detail = runtime_object->prog_id + "." + property_path.substr(separator + 1U),
                .location = current_statement() == nullptr ? SourceLocation{} : current_statement()->location
            });
            return make_string_value("ole:" + runtime_object->prog_id + "." + property_path.substr(separator + 1U));
        },
        [this, &frame, preferred_cursor](const std::string& nested_expression) {
            return evaluate_expression(nested_expression, frame, preferred_cursor);
        },
        [this](const std::string& option_name) {
            const std::string normalized_name = normalize_identifier(option_name);
            if (normalized_name == "default") {
                return default_directory;
            }

            const auto found = current_set_state().find(normalized_name);
            if (found == current_set_state().end()) {
                return std::string("OFF");
            }

            const std::string normalized_value = normalize_identifier(found->second);
            if (normalized_value.empty() || normalized_value == "on" || normalized_value == "true" || normalized_value == "1") {
                return std::string("ON");
            }
            if (normalized_value == "off" || normalized_value == "false" || normalized_value == "0") {
                return std::string("OFF");
            }
            return uppercase_copy(found->second);
        },
        [this](const std::string& category, const std::string& detail) {
            events.push_back({
                .category = category,
                .detail = detail,
                .location = current_statement() == nullptr ? SourceLocation{} : current_statement()->location
            });
        });
    return parser.parse();
}

std::optional<std::string> PrgRuntimeSession::Impl::materialize_xasset_bootstrap(
    const std::string& asset_path,
    bool include_read_events) {
    const auto open_result = studio::open_document({
        .path = asset_path,
        .read_only = true,
        .load_full_table = true
    });
    if (!open_result.ok) {
        last_error_message = open_result.error;
        return std::nullopt;
    }

    const XAssetExecutableModel model = build_xasset_executable_model(open_result.document);
    if (!model.ok || !model.runnable_startup) {
        last_error_message = model.error.empty()
            ? "No runnable startup methods were found in asset: " + asset_path
            : model.error;
        return std::nullopt;
    }

    const std::filesystem::path asset_file(asset_path);
    const std::filesystem::path bootstrap_path =
        std::filesystem::temp_directory_path() /
        (asset_file.stem().string() + "_copperfin_bootstrap.prg");

    std::ofstream output(bootstrap_path, std::ios::binary);
    output << build_xasset_bootstrap_source(model, include_read_events);
    output.close();
    if (!output.good()) {
        last_error_message = "Unable to materialize xAsset bootstrap for: " + asset_path;
        return std::nullopt;
    }

    return bootstrap_path.string();
}

ExecutionOutcome PrgRuntimeSession::Impl::execute_current_statement() {
    if (stack.empty()) {
        return {};
    }

    Frame& frame = stack.back();
    if (frame.routine == nullptr || frame.pc >= frame.routine->statements.size()) {
        stack.pop_back();
        return {};
    }

    const Statement statement = frame.routine->statements[frame.pc];
    ++frame.pc;
    ++executed_statement_count;

    events.push_back({
        .category = "execute",
        .detail = statement.text,
        .location = statement.location
    });

    try {
    switch (statement.kind) {
        case StatementKind::assignment:
            if (statement.identifier.find('.') != std::string::npos) {
                const auto separator = statement.identifier.find('.');
                const PrgValue object_value = lookup_variable(frame, statement.identifier.substr(0U, separator));
                auto object = resolve_ole_object(object_value);
                if (!object.has_value()) {
                    last_error_message = "OLE object not found for property assignment: " + statement.identifier;
                    last_fault_location = statement.location;
                    last_fault_statement = statement.text;
                    return {.ok = false, .message = last_error_message};
                }

                RuntimeOleObjectState* runtime_object = *object;
                runtime_object->last_action = statement.identifier.substr(separator + 1U) + " = " + value_as_string(evaluate_expression(statement.expression, frame));
                ++runtime_object->action_count;
                events.push_back({
                    .category = "ole.set",
                    .detail = runtime_object->prog_id + "." + runtime_object->last_action,
                    .location = statement.location
                });
            } else {
                assign_variable(frame, statement.identifier, evaluate_expression(statement.expression, frame));
            }
            return {};
        case StatementKind::expression:
            if (!statement.expression.empty()) {
                if (starts_with_insensitive(statement.expression, "WAIT WINDOW ")) {
                    events.push_back({
                        .category = "ui.wait_window",
                        .detail = value_as_string(evaluate_expression(statement.expression.substr(12U), frame)),
                        .location = statement.location
                    });
                } else {
                    (void)evaluate_expression(statement.expression, frame);
                }
            }
            return {};
        case StatementKind::do_command: {
            const std::string target = trim_copy(statement.identifier);
            Program& program = load_program(frame.file_path);
            if (const auto routine = program.routines.find(normalize_identifier(target)); routine != program.routines.end()) {
                push_routine_frame(program.path, routine->second);
                return {};
            }

            std::filesystem::path target_path(target);
            if (target_path.extension().empty()) {
                target_path += ".prg";
            }
            if (target_path.is_relative()) {
                target_path = std::filesystem::path(default_directory) / target_path;
            }
            if (!std::filesystem::exists(target_path)) {
                last_error_message = "Unable to resolve DO target: " + target;
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            push_main_frame(target_path.string());
            return {};
        }
        case StatementKind::do_form: {
            const std::filesystem::path form_path = resolve_asset_path(statement.identifier, ".scx");
            events.push_back({
                .category = "form.open",
                .detail = form_path.lexically_normal().string(),
                .location = statement.location
            });
            if (std::filesystem::exists(form_path)) {
                if (const auto bootstrap_path = materialize_xasset_bootstrap(form_path.string(), true)) {
                    push_main_frame(*bootstrap_path);
                }
            }
            return {};
        }
        case StatementKind::calculate_command: {
            std::string error_message;
            if (!execute_calculate_command(statement, frame, error_message)) {
                last_error_message = error_message;
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }
            events.push_back({
                .category = "runtime.calculate",
                .detail = statement.expression,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::count_command:
        case StatementKind::sum_command:
        case StatementKind::average_command: {
            std::string function = "count";
            std::string category = "runtime.count";
            if (statement.kind == StatementKind::sum_command) {
                function = "sum";
                category = "runtime.sum";
            } else if (statement.kind == StatementKind::average_command) {
                function = "average";
                category = "runtime.average";
            }

            std::string error_message;
            if (!execute_command_aggregate(statement, frame, function, error_message)) {
                last_error_message = error_message;
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }
            events.push_back({
                .category = category,
                .detail = statement.text,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::text_command: {
            if (statement.identifier.empty()) {
                last_error_message = "TEXT requires TO <variable> in the current runtime slice";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }
            if (normalize_identifier(statement.tertiary_expression) == "textmerge") {
                last_error_message = "TEXT TEXTMERGE is not yet supported";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            std::string text_value = statement.expression;
            if (normalize_identifier(statement.secondary_expression) == "additive") {
                text_value = value_as_string(lookup_variable(frame, statement.identifier)) + text_value;
            }

            assign_variable(frame, statement.identifier, make_string_value(std::move(text_value)));
            events.push_back({
                .category = "runtime.text",
                .detail = statement.identifier,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::total_command: {
            std::string error_message;
            if (!execute_total_command(statement, frame, error_message)) {
                last_error_message = error_message;
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }
            events.push_back({
                .category = "runtime.total",
                .detail = statement.text,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::report_form:
            return open_report_surface(statement, ".frx", "report.preview");
        case StatementKind::label_form:
            return open_report_surface(statement, ".lbx", "label.preview");
        case StatementKind::activate_surface:
            waiting_for_events = true;
            events.push_back({
                .category = statement.identifier + ".activate",
                .detail = statement.expression,
                .location = statement.location
            });
            return {.waiting_for_events = true};
        case StatementKind::release_surface:
            waiting_for_events = false;
            events.push_back({
                .category = statement.identifier + ".release",
                .detail = statement.expression,
                .location = statement.location
            });
            return {};
        case StatementKind::return_statement:
            stack.pop_back();
            return {.frame_returned = true};
        case StatementKind::do_case_statement:
            frame.cases.push_back({
                .do_case_statement_index = frame.pc - 1U,
                .endcase_statement_index = find_matching_endcase(frame, frame.pc - 1U).value_or(frame.pc - 1U),
                .matched = false
            });
            return {};
        case StatementKind::case_statement: {
            if (frame.cases.empty()) {
                return {};
            }

            CaseState& active_case = frame.cases.back();
            if (active_case.matched) {
                const std::size_t next_pc = active_case.endcase_statement_index + 1U;
                frame.cases.pop_back();
                frame.pc = next_pc;
                return {};
            }

            if (value_as_bool(evaluate_expression(statement.expression, frame))) {
                active_case.matched = true;
                return {};
            }

            if (const auto destination = find_next_case_clause(frame, frame.pc - 1U)) {
                frame.pc = *destination;
            }
            return {};
        }
        case StatementKind::otherwise_statement:
            if (frame.cases.empty()) {
                return {};
            }
            if (frame.cases.back().matched) {
                const std::size_t next_pc = frame.cases.back().endcase_statement_index + 1U;
                frame.cases.pop_back();
                frame.pc = next_pc;
                return {};
            }
            frame.cases.back().matched = true;
            return {};
        case StatementKind::if_statement:
            if (!value_as_bool(evaluate_expression(statement.expression, frame))) {
                if (const auto destination = find_matching_branch(frame, frame.pc - 1U, true)) {
                    frame.pc = *destination + 1U;
                }
            }
            return {};
        case StatementKind::else_statement:
            if (const auto destination = find_matching_branch(frame, frame.pc - 1U, false)) {
                frame.pc = *destination + 1U;
            }
            return {};
        case StatementKind::endif_statement:
            return {};
        case StatementKind::for_statement: {
            const double start_value = value_as_number(evaluate_expression(statement.expression, frame));
            const double end_value = value_as_number(evaluate_expression(statement.secondary_expression, frame));
            const double step_value = statement.tertiary_expression.empty()
                ? 1.0
                : value_as_number(evaluate_expression(statement.tertiary_expression, frame));
            assign_variable(frame, statement.identifier, make_number_value(start_value));
            const bool should_enter = step_value >= 0.0 ? start_value <= end_value : start_value >= end_value;
            if (!should_enter) {
                if (const auto destination = find_matching_endfor(frame, frame.pc - 1U)) {
                    frame.pc = *destination + 1U;
                }
                return {};
            }
            const auto existing = std::find_if(frame.loops.rbegin(), frame.loops.rend(), [&](const LoopState& loop) {
                return loop.for_statement_index == (frame.pc - 1U);
            });
            if (existing != frame.loops.rend()) {
                return {};
            }
            frame.loops.push_back({
                .for_statement_index = frame.pc - 1U,
                .endfor_statement_index = find_matching_endfor(frame, frame.pc - 1U).value_or(frame.pc - 1U),
                .variable_name = normalize_identifier(statement.identifier),
                .end_value = end_value,
                .step_value = step_value
            });
            return {};
        }
        case StatementKind::do_while_statement: {
            const bool should_continue = value_as_bool(evaluate_expression(statement.expression, frame));
            const auto existing = std::find_if(frame.whiles.rbegin(), frame.whiles.rend(), [&](const WhileState& loop) {
                return loop.do_while_statement_index == (frame.pc - 1U);
            });
            if (should_continue) {
                if (existing == frame.whiles.rend()) {
                    frame.whiles.push_back({
                        .do_while_statement_index = frame.pc - 1U,
                        .enddo_statement_index = find_matching_enddo(frame, frame.pc - 1U).value_or(frame.pc - 1U)
                    });
                }
            } else {
                if (existing != frame.whiles.rend()) {
                    frame.whiles.erase(std::next(existing).base());
                }
                if (const auto destination = find_matching_enddo(frame, frame.pc - 1U)) {
                    frame.pc = *destination + 1U;
                }
            }
            return {};
        }
        case StatementKind::endfor_statement:
            return continue_for_loop(frame, statement, false);
        case StatementKind::loop_statement: {
            const auto active_loop = find_innermost_active_loop(frame);
            if (!active_loop.has_value()) {
                return {};
            }

            switch (active_loop->kind) {
                case ActiveLoopKind::for_loop:
                    return continue_for_loop(frame, statement, true);
                case ActiveLoopKind::scan_loop:
                    return continue_scan_loop(frame, statement, true);
                case ActiveLoopKind::while_loop:
                    frame.pc = active_loop->start_statement_index;
                    return {};
            }
            return {};
        }
        case StatementKind::exit_statement: {
            const auto active_loop = find_innermost_active_loop(frame);
            if (!active_loop.has_value()) {
                return {};
            }

            switch (active_loop->kind) {
                case ActiveLoopKind::for_loop:
                    frame.loops.pop_back();
                    frame.pc = active_loop->end_statement_index + 1U;
                    return {};
                case ActiveLoopKind::scan_loop:
                    frame.scans.pop_back();
                    frame.pc = active_loop->end_statement_index + 1U;
                    return {};
                case ActiveLoopKind::while_loop:
                    frame.whiles.pop_back();
                    frame.pc = active_loop->end_statement_index + 1U;
                    return {};
            }
            return {};
        }
        case StatementKind::enddo_statement:
            if (!frame.whiles.empty()) {
                frame.pc = frame.whiles.back().do_while_statement_index;
            }
            return {};
        case StatementKind::endcase_statement:
            if (!frame.cases.empty()) {
                frame.cases.pop_back();
            }
            return {};
        case StatementKind::read_events:
            waiting_for_events = true;
            events.push_back({
                .category = "runtime.event_loop",
                .detail = "READ EVENTS entered",
                .location = statement.location
            });
            return {.waiting_for_events = true};
        case StatementKind::clear_events:
            waiting_for_events = false;
            restore_event_loop_after_dispatch = false;
            events.push_back({
                .category = "runtime.event_loop",
                .detail = "CLEAR EVENTS",
                .location = statement.location
            });
            return {};
        case StatementKind::seek_command: {
            CursorState* cursor = resolve_cursor_target(statement.secondary_expression);
            if (cursor == nullptr) {
                last_error_message = "SEEK target work area not found";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            const std::string search_key = value_as_string(evaluate_expression(statement.expression, frame));
            const bool found = execute_seek(*cursor, search_key, true, false, statement.tertiary_expression);
            events.push_back({
                .category = "runtime.seek",
                .detail = (cursor->active_order_name.empty() ? std::string{"<default>"} : cursor->active_order_name) +
                    ": " + search_key + (found ? " -> found" : " -> not found"),
                .location = statement.location
            });
            return {};
        }
        case StatementKind::locate_command: {
            CursorState* cursor = resolve_cursor_target(statement.secondary_expression);
            if (cursor == nullptr) {
                last_error_message = "LOCATE target work area not found";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            if (!locate_next_matching_record(*cursor, statement.expression, frame, 1U)) {
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            events.push_back({
                .category = "runtime.locate",
                .detail = statement.expression.empty() ? "ALL" : statement.expression,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::scan_statement: {
            CursorState* cursor = resolve_cursor_target(statement.secondary_expression);
            if (cursor == nullptr) {
                last_error_message = "SCAN target work area not found";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            const std::size_t start_recno = cursor->recno == 0U ? 1U : cursor->recno;
            if (!locate_next_matching_record(*cursor, statement.expression, frame, start_recno)) {
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            if (!cursor->found) {
                if (const auto destination = find_matching_endscan(frame, frame.pc - 1U)) {
                    frame.pc = *destination + 1U;
                }
                return {};
            }

            frame.scans.push_back({
                .scan_statement_index = frame.pc - 1U,
                .endscan_statement_index = find_matching_endscan(frame, frame.pc - 1U).value_or(frame.pc - 1U),
                .work_area = cursor->work_area,
                .for_expression = statement.expression
            });
            events.push_back({
                .category = "runtime.scan",
                .detail = statement.expression.empty() ? "ALL" : statement.expression,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::endscan_statement:
            return continue_scan_loop(frame, statement, false);
        case StatementKind::replace_command: {
            CursorState* cursor = resolve_cursor_target(statement.secondary_expression);
            if (cursor == nullptr) {
                last_error_message = "REPLACE target work area not found";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            const std::vector<ReplaceAssignment> assignments = parse_replace_assignments(statement.expression);
            if (assignments.empty()) {
                last_error_message = "REPLACE requires at least one FIELD WITH expression assignment";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }
            if (!replace_current_record_fields(*cursor, assignments, frame)) {
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            events.push_back({
                .category = "runtime.replace",
                .detail = statement.expression,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::append_blank_command: {
            CursorState* cursor = resolve_cursor_target({});
            if (cursor == nullptr) {
                last_error_message = "APPEND BLANK requires a selected work area";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }
            if (!append_blank_record(*cursor)) {
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            events.push_back({
                .category = "runtime.append_blank",
                .detail = cursor->alias,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::delete_command: {
            CursorState* cursor = resolve_cursor_target(statement.secondary_expression);
            if (cursor == nullptr) {
                last_error_message = "DELETE target work area not found";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }
            if (!set_deleted_flag(*cursor, frame, statement.expression, true)) {
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            events.push_back({
                .category = "runtime.delete",
                .detail = statement.expression.empty() ? cursor->alias : statement.expression,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::recall_command: {
            CursorState* cursor = resolve_cursor_target(statement.secondary_expression);
            if (cursor == nullptr) {
                last_error_message = "RECALL target work area not found";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }
            if (!set_deleted_flag(*cursor, frame, statement.expression, false)) {
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            events.push_back({
                .category = "runtime.recall",
                .detail = statement.expression.empty() ? cursor->alias : statement.expression,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::go_command: {
            CursorState* cursor = resolve_cursor_target(statement.secondary_expression);
            if (cursor == nullptr) {
                last_error_message = "GO target work area not found";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            const std::string destination = uppercase_copy(trim_copy(statement.expression));
            if (destination == "TOP") {
                if (!seek_visible_record(*cursor, frame, 1, 1, {}, false) && cursor->record_count == 0U) {
                    move_cursor_to(*cursor, 0);
                }
            } else if (destination == "BOTTOM") {
                if (!seek_visible_record(*cursor, frame, static_cast<long long>(cursor->record_count), -1, {}, false) && cursor->record_count == 0U) {
                    move_cursor_to(*cursor, 0);
                }
            } else {
                const long long requested = std::llround(value_as_number(evaluate_expression(statement.expression, frame)));
                move_cursor_to(*cursor, requested);
            }

            events.push_back({
                .category = "runtime.go",
                .detail = destination.empty() ? statement.expression : destination,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::skip_command: {
            CursorState* cursor = resolve_cursor_target(statement.secondary_expression);
            if (cursor == nullptr) {
                last_error_message = "SKIP target work area not found";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            const long long delta = std::llround(value_as_number(evaluate_expression(statement.expression, frame)));
            if (!move_by_visible_records(*cursor, frame, delta)) {
                cursor->found = false;
            }
            events.push_back({
                .category = "runtime.skip",
                .detail = statement.expression,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::set_order: {
            CursorState* cursor = resolve_cursor_target(statement.secondary_expression);
            if (cursor == nullptr) {
                last_error_message = "SET ORDER target work area not found";
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            if (!activate_order(*cursor, statement.expression)) {
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }

            events.push_back({
                .category = "runtime.order",
                .detail = cursor->active_order_name.empty() ? "0" : cursor->active_order_name,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::select_command: {
            std::string selection = trim_copy(value_as_string(evaluate_expression(statement.expression, frame)));
            if (selection.empty()) {
                selection = trim_copy(statement.expression);
            }
            if (selection.empty()) {
                return {};
            }

            int target_area = 0;
            const bool numeric_selection = std::all_of(selection.begin(), selection.end(), [](unsigned char ch) {
                return std::isdigit(ch) != 0;
            });
            if (numeric_selection) {
                target_area = std::stoi(selection);
            } else {
                const CursorState* existing = find_cursor_by_alias(selection);
                if (existing == nullptr) {
                    last_error_message = "SELECT target work area not found: " + selection;
                    last_fault_location = statement.location;
                    last_fault_statement = statement.text;
                    return {.ok = false, .message = last_error_message};
                }
                target_area = existing->work_area;
            }

            const int selected = select_work_area(target_area);
            events.push_back({
                .category = "runtime.select",
                .detail = "work area " + std::to_string(selected),
                .location = statement.location
            });
            return {};
        }
        case StatementKind::use_command: {
            if (statement.expression.empty() && statement.secondary_expression.empty()) {
                close_cursor(std::to_string(current_selected_work_area()));
                events.push_back({
                    .category = "runtime.use.close",
                    .detail = "current work area",
                    .location = statement.location
                });
                return {};
            }
            if (statement.expression.empty()) {
                close_cursor(evaluate_cursor_designator_expression(statement.secondary_expression, frame));
                events.push_back({
                    .category = "runtime.use.close",
                    .detail = trim_copy(statement.secondary_expression),
                    .location = statement.location
                });
                return {};
            }

            const std::string target = value_as_string(evaluate_expression(statement.expression, frame));
            std::string alias = statement.identifier.empty()
                ? std::filesystem::path(unquote_string(target)).stem().string()
                : value_as_string(evaluate_expression(statement.identifier, frame));
            if (alias.empty() && !statement.identifier.empty()) {
                alias = unquote_string(statement.identifier);
            }
            const bool allow_again = normalize_identifier(statement.tertiary_expression) == "again";
            if (!open_table_cursor(target, alias, statement.secondary_expression, allow_again, false, 0, {}, 0U)) {
                last_fault_location = statement.location;
                last_fault_statement = statement.text;
                return {.ok = false, .message = last_error_message};
            }
            events.push_back({
                .category = "runtime.use.open",
                .detail = alias.empty() ? target : alias + " <- " + target,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::set_command:
        {
            const auto [option_name, option_value] = split_first_word(statement.expression);
            const std::string normalized_name = normalize_identifier(option_name);
            if (normalized_name == "filter") {
                CursorState* cursor = resolve_cursor_target({});
                if (cursor == nullptr) {
                    last_error_message = "SET FILTER requires a selected work area";
                    last_fault_location = statement.location;
                    last_fault_statement = statement.text;
                    return {.ok = false, .message = last_error_message};
                }

                std::string filter_value = trim_copy(option_value);
                if (starts_with_insensitive(filter_value, "TO ")) {
                    filter_value = trim_copy(filter_value.substr(3U));
                }
                if (normalize_identifier(filter_value) == "off") {
                    filter_value.clear();
                }

                cursor->filter_expression = filter_value;
                if (!cursor->filter_expression.empty() && cursor->record_count > 0U &&
                    !current_record_matches_visibility(*cursor, frame, {})) {
                    (void)seek_visible_record(*cursor, frame, static_cast<long long>(cursor->recno), 1, {}, false);
                }

                events.push_back({
                    .category = "runtime.filter",
                    .detail = cursor->filter_expression.empty() ? "OFF" : cursor->filter_expression,
                    .location = statement.location
                });
                return {};
            }
            if (!normalized_name.empty()) {
                current_set_state()[normalized_name] = option_value.empty() ? "on" : option_value;
            } else {
                current_set_state()[normalize_identifier(statement.expression)] = "true";
            }
            events.push_back({
                .category = "runtime.set",
                .detail = statement.expression,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::set_library: {
            const std::string library_name = normalize_identifier(value_as_string(evaluate_expression(statement.expression, frame)));
            if (!library_name.empty()) {
                loaded_libraries.insert(library_name);
            }
            events.push_back({
                .category = "runtime.library",
                .detail = statement.expression,
                .location = statement.location
            });
            return {};
        }
        case StatementKind::set_datasession: {
            const int session_id = static_cast<int>(std::llround(value_as_number(evaluate_expression(statement.expression, frame))));
            current_data_session = std::max(1, session_id);
            (void)current_session_state();
            events.push_back({
                .category = "runtime.datasession",
                .detail = "SET DATASESSION TO " + std::to_string(current_data_session),
                .location = statement.location
            });
            return {};
        }
        case StatementKind::set_default: {
            const std::string evaluated = value_as_string(evaluate_expression(statement.expression, frame));
            if (!evaluated.empty()) {
                default_directory = normalize_path(evaluated);
            }
            return {};
        }
        case StatementKind::on_error:
            error_handler = statement.expression;
            return {};
        case StatementKind::public_declaration:
            for (const auto& name : statement.names) {
                globals.try_emplace(normalize_identifier(name), make_empty_value());
            }
            return {};
        case StatementKind::local_declaration:
            for (const auto& name : statement.names) {
                const std::string normalized = normalize_identifier(name);
                frame.local_names.insert(normalized);
                frame.locals.try_emplace(normalized, make_empty_value());
            }
            return {};
        case StatementKind::no_op:
            return {};
    }
    } catch (const std::exception& error) {
        last_error_message = std::string("Runtime fault: ") + error.what();
        last_fault_location = statement.location;
        last_fault_statement = statement.text;
        events.push_back({
            .category = "runtime.error",
            .detail = last_error_message,
            .location = statement.location
        });
        return {.ok = false, .message = last_error_message};
    } catch (...) {
        last_error_message = "Runtime fault: unknown exception";
        last_fault_location = statement.location;
        last_fault_statement = statement.text;
        events.push_back({
            .category = "runtime.error",
            .detail = last_error_message,
            .location = statement.location
        });
        return {.ok = false, .message = last_error_message};
    }

    return {};
}

bool PrgRuntimeSession::Impl::dispatch_event_handler(const std::string& routine_name) {
    if (!waiting_for_events || stack.empty()) {
        return false;
    }

    const std::string normalized_target = normalize_identifier(routine_name);
    for (auto iterator = stack.rbegin(); iterator != stack.rend(); ++iterator) {
        Program& program = load_program(iterator->file_path);
        const auto found = program.routines.find(normalized_target);
        if (found == program.routines.end()) {
            continue;
        }

        waiting_for_events = false;
        event_dispatch_return_depth = stack.size();
        restore_event_loop_after_dispatch = true;
        push_routine_frame(program.path, found->second);
        events.push_back({
            .category = "runtime.dispatch",
            .detail = found->second.name,
            .location = {}
        });
        return true;
    }

    return false;
}

RuntimePauseState PrgRuntimeSession::Impl::run(DebugResumeAction action) {
    if (entry_pause_pending) {
        entry_pause_pending = false;
        return build_pause_state(DebugPauseReason::entry, "Stopped on entry.");
    }

    if (waiting_for_events) {
        return build_pause_state(DebugPauseReason::event_loop, "The runtime is waiting in READ EVENTS.");
    }

    const std::size_t base_depth = stack.size();
    bool first_statement = true;

    while (true) {
        while (!stack.empty() &&
               (stack.back().routine == nullptr || stack.back().pc >= stack.back().routine->statements.size())) {
            stack.pop_back();
        }
        if (event_dispatch_return_depth.has_value() && stack.size() <= *event_dispatch_return_depth) {
            event_dispatch_return_depth.reset();
            if (restore_event_loop_after_dispatch) {
                restore_event_loop_after_dispatch = false;
                waiting_for_events = true;
                return build_pause_state(DebugPauseReason::event_loop, "The runtime is waiting in READ EVENTS.");
            }
            restore_event_loop_after_dispatch = false;
        }
        if (stack.empty()) {
            return build_pause_state(DebugPauseReason::completed, "Execution completed.");
        }

        const Statement* next = current_statement();
        if (next == nullptr) {
            stack.pop_back();
            continue;
        }

        if (!first_statement && breakpoint_matches(next->location)) {
            return build_pause_state(DebugPauseReason::breakpoint, "Breakpoint hit.");
        }

        const ExecutionOutcome outcome = execute_current_statement();
        if (!outcome.ok) {
            return build_pause_state(DebugPauseReason::error, outcome.message);
        }
        if (outcome.waiting_for_events) {
            return build_pause_state(DebugPauseReason::event_loop, "The runtime is waiting in READ EVENTS.");
        }

        if (stack.empty()) {
            return build_pause_state(DebugPauseReason::completed, "Execution completed.");
        }

        switch (action) {
            case DebugResumeAction::continue_run:
                break;
            case DebugResumeAction::step_into:
                return build_pause_state(DebugPauseReason::step, "Step completed.");
            case DebugResumeAction::step_over:
                if (stack.size() <= base_depth) {
                    return build_pause_state(DebugPauseReason::step, "Step-over completed.");
                }
                break;
            case DebugResumeAction::step_out:
                if (stack.size() < base_depth) {
                    return build_pause_state(DebugPauseReason::step, "Step-out completed.");
                }
                break;
        }

        first_statement = false;
    }
}

PrgRuntimeSession PrgRuntimeSession::create(const RuntimeSessionOptions& options) {
    auto impl = std::make_unique<Impl>(options);
    impl->default_directory = options.working_directory.empty()
        ? std::filesystem::path(options.startup_path).parent_path().string()
        : normalize_path(options.working_directory);
    impl->data_sessions.try_emplace(1);
    impl->push_main_frame(options.startup_path);
    impl->entry_pause_pending = options.stop_on_entry;
    return PrgRuntimeSession(std::move(impl));
}

void PrgRuntimeSession::add_breakpoint(const RuntimeBreakpoint& breakpoint) {
    impl_->breakpoints.push_back({
        .file_path = normalize_path(breakpoint.file_path),
        .line = breakpoint.line
    });
}

void PrgRuntimeSession::clear_breakpoints() {
    impl_->breakpoints.clear();
}

bool PrgRuntimeSession::dispatch_event_handler(const std::string& routine_name) {
    return impl_->dispatch_event_handler(routine_name);
}

RuntimePauseState PrgRuntimeSession::run(DebugResumeAction action) {
    return impl_->run(action);
}

const RuntimePauseState& PrgRuntimeSession::state() const noexcept {
    return impl_->last_state;
}

PrgRuntimeSession::PrgRuntimeSession(std::unique_ptr<Impl> impl)
    : impl_(std::move(impl)) {
}

PrgRuntimeSession::PrgRuntimeSession(PrgRuntimeSession&&) noexcept = default;

PrgRuntimeSession& PrgRuntimeSession::operator=(PrgRuntimeSession&&) noexcept = default;

PrgRuntimeSession::~PrgRuntimeSession() = default;

const char* debug_pause_reason_name(DebugPauseReason reason) {
    switch (reason) {
        case DebugPauseReason::none:
            return "none";
        case DebugPauseReason::entry:
            return "entry";
        case DebugPauseReason::breakpoint:
            return "breakpoint";
        case DebugPauseReason::step:
            return "step";
        case DebugPauseReason::event_loop:
            return "event_loop";
        case DebugPauseReason::completed:
            return "completed";
        case DebugPauseReason::error:
            return "error";
    }
    return "none";
}

std::string format_value(const PrgValue& value) {
    return value_as_string(value);
}

}  // namespace copperfin::runtime
