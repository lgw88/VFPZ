#include "copperfin/vfp/cdx_header.h"

#include <algorithm>
#include <cctype>
#include <filesystem>
#include <fstream>
#include <set>

namespace copperfin::vfp {

namespace {

std::uint16_t read_le_u16(const std::vector<std::uint8_t>& bytes, std::size_t offset) {
    return static_cast<std::uint16_t>(bytes[offset]) |
           (static_cast<std::uint16_t>(bytes[offset + 1]) << 8U);
}

constexpr std::uint16_t cdx_leaf_flag = 0x0001U;
constexpr std::uint16_t cdx_directory_flag = 0x0002U;

struct PrintableRun {
    std::size_t offset = 0;
    std::string text;
};

bool is_identifier_char(char ch) {
    const auto raw = static_cast<unsigned char>(ch);
    return std::isalnum(raw) != 0 || ch == '_';
}

bool is_expression_char(char ch) {
    const auto raw = static_cast<unsigned char>(ch);
    return std::isalnum(raw) != 0 || ch == '_' || ch == '(' || ch == ')' ||
           ch == '.' || ch == ',' || ch == '\'' || ch == '"' || ch == ' ' ||
           ch == '=' || ch == '<' || ch == '>' || ch == '+' || ch == '-' ||
           ch == '*' || ch == '/' || ch == '!';
}

std::string trim_copy(std::string value) {
    const auto first = std::find_if(value.begin(), value.end(), [](unsigned char ch) {
        return std::isspace(ch) == 0;
    });
    value.erase(value.begin(), first);

    const auto last = std::find_if(value.rbegin(), value.rend(), [](unsigned char ch) {
        return std::isspace(ch) == 0;
    });
    value.erase(last.base(), value.end());
    return value;
}

std::string lowercase_copy(std::string value) {
    std::transform(value.begin(), value.end(), value.begin(), [](unsigned char ch) {
        return static_cast<char>(std::tolower(ch));
    });
    return value;
}

std::string uppercase_copy(std::string value) {
    std::transform(value.begin(), value.end(), value.begin(), [](unsigned char ch) {
        return static_cast<char>(std::toupper(ch));
    });
    return value;
}

std::string collapse_identifier(const std::string& value) {
    std::string normalized;
    normalized.reserve(value.size());

    for (char ch : value) {
        if (!is_identifier_char(ch)) {
            continue;
        }

        if (ch == '_') {
            continue;
        }

        normalized.push_back(static_cast<char>(std::toupper(static_cast<unsigned char>(ch))));
    }

    return normalized;
}

std::vector<PrintableRun> collect_printable_runs(const std::vector<std::uint8_t>& bytes) {
    std::vector<PrintableRun> runs;

    for (std::size_t index = 0; index < bytes.size();) {
        const auto raw = static_cast<unsigned char>(bytes[index]);
        if (std::isprint(raw) == 0) {
            ++index;
            continue;
        }

        const std::size_t start = index;
        std::string text;
        while (index < bytes.size()) {
            const auto current = static_cast<unsigned char>(bytes[index]);
            if (std::isprint(current) == 0) {
                break;
            }
            text.push_back(static_cast<char>(current));
            ++index;
        }

        if (text.size() >= 4U) {
            runs.push_back({.offset = start, .text = std::move(text)});
        }
    }

    return runs;
}

bool looks_like_expression_candidate(const std::string& text) {
    if (text.size() < 4U || text.size() > 96U) {
        return false;
    }

    if (!std::all_of(text.begin(), text.end(), [](char ch) { return is_expression_char(ch); })) {
        return false;
    }

    const bool has_lowercase = std::any_of(text.begin(), text.end(), [](unsigned char ch) {
        return std::islower(ch) != 0;
    });
    const bool has_identifier = std::any_of(text.begin(), text.end(), [](char ch) {
        return is_identifier_char(ch);
    });
    const bool has_underscore = text.find('_') != std::string::npos;
    const bool has_parens = text.find('(') != std::string::npos && text.find(')') != std::string::npos;
    const bool has_operator = text.find('=') != std::string::npos ||
                              text.find('<') != std::string::npos ||
                              text.find('>') != std::string::npos;
    const bool has_many_spaces = std::count(text.begin(), text.end(), ' ') > 2;

    if (!has_identifier || has_many_spaces) {
        return false;
    }

    return has_parens || (has_lowercase && (has_underscore || has_operator));
}

bool looks_like_for_expression_candidate(const std::string& text) {
    if (text.empty()) {
        return false;
    }

    const std::string upper = uppercase_copy(text);
    return text.find('=') != std::string::npos ||
           text.find('<') != std::string::npos ||
           text.find('>') != std::string::npos ||
           upper.find(".T.") != std::string::npos ||
           upper.find(".F.") != std::string::npos ||
           upper.starts_with("DELETED(") ||
           upper.find(" AND ") != std::string::npos ||
           upper.find(" OR ") != std::string::npos ||
           upper.starts_with("NOT ");
}

std::string derive_name_from_expression(const std::string& expression) {
    std::string candidate = trim_copy(expression);
    const auto open = candidate.find('(');
    const auto close = candidate.rfind(')');
    if (open != std::string::npos && close != std::string::npos && close > open + 1U) {
        const std::string inner = trim_copy(candidate.substr(open + 1U, close - open - 1U));
        if (!inner.empty() &&
            std::all_of(inner.begin(), inner.end(), [](char ch) { return is_identifier_char(ch); })) {
            candidate = inner;
        }
    }

    std::string sanitized;
    sanitized.reserve(candidate.size());

    bool previous_was_separator = false;
    for (char ch : candidate) {
        const auto raw = static_cast<unsigned char>(ch);
        if (std::isalnum(raw) != 0) {
            sanitized.push_back(static_cast<char>(std::toupper(raw)));
            previous_was_separator = false;
        } else if (ch == '_' && !previous_was_separator) {
            sanitized.push_back('_');
            previous_was_separator = true;
        } else if (!previous_was_separator) {
            sanitized.push_back('_');
            previous_was_separator = true;
        }
    }

    while (!sanitized.empty() && sanitized.front() == '_') {
        sanitized.erase(sanitized.begin());
    }
    while (!sanitized.empty() && sanitized.back() == '_') {
        sanitized.pop_back();
    }

    if (sanitized.size() > 10U) {
        sanitized.resize(10U);
    }

    return sanitized;
}

std::vector<PrintableRun> collect_expression_runs(const std::vector<std::uint8_t>& bytes) {
    std::vector<PrintableRun> expressions;
    std::set<std::string> seen_expressions;

    for (const PrintableRun& run : collect_printable_runs(bytes)) {
        const std::string candidate = trim_copy(run.text);
        if (!looks_like_expression_candidate(candidate)) {
            continue;
        }

        const std::string normalized = lowercase_copy(candidate);
        if (!seen_expressions.insert(normalized).second) {
            continue;
        }

        expressions.push_back({.offset = run.offset, .text = candidate});
    }

    return expressions;
}

bool looks_like_tag_name_candidate(const std::string& text) {
    if (text.size() < 4U || text.size() > 10U) {
        return false;
    }

    bool saw_alpha = false;
    for (unsigned char ch : text) {
        if (!is_identifier_char(static_cast<char>(ch))) {
            return false;
        }
        if (std::isalpha(ch) != 0) {
            saw_alpha = true;
            if (std::toupper(ch) != ch) {
                return false;
            }
        }
    }

    return saw_alpha;
}

std::vector<CdxTagDescriptor> collect_directory_leaf_tags(
    const std::vector<std::uint8_t>& bytes,
    std::size_t page_size,
    std::size_t key_length) {
    std::vector<CdxTagDescriptor> tags;
    std::set<std::string> seen_names;
    if (page_size == 0U || key_length == 0U || key_length > page_size) {
        return tags;
    }

    const std::size_t page_count = bytes.size() / page_size;
    for (std::size_t page_index = 1; page_index < page_count; ++page_index) {
        const std::size_t page_start = page_index * page_size;
        if ((page_start + 4U) > bytes.size()) {
            break;
        }

        const std::uint16_t flags = read_le_u16(bytes, page_start);
        const std::uint16_t entry_count = read_le_u16(bytes, page_start + 2U);
        if ((flags & (cdx_leaf_flag | cdx_directory_flag)) != (cdx_leaf_flag | cdx_directory_flag)) {
            continue;
        }
        if (entry_count == 0U) {
            continue;
        }

        const std::size_t tail_bytes = static_cast<std::size_t>(entry_count) * key_length;
        if (tail_bytes > (page_size - 4U)) {
            continue;
        }

        const std::size_t tail_start = page_start + page_size - tail_bytes;
        for (std::size_t index = 0; index < entry_count; ++index) {
            const std::size_t name_offset = tail_start + (index * key_length);
            std::string chunk;
            chunk.reserve(key_length);
            for (std::size_t char_index = 0; char_index < key_length && (name_offset + char_index) < bytes.size(); ++char_index) {
                const char ch = static_cast<char>(bytes[name_offset + char_index]);
                if (ch == '\0') {
                    break;
                }
                chunk.push_back(ch);
            }

            chunk = trim_copy(chunk);
            if (!looks_like_tag_name_candidate(chunk) || !seen_names.insert(chunk).second) {
                continue;
            }

            tags.push_back({
                .name_hint = chunk,
                .name_offset_hint = static_cast<std::uint32_t>(name_offset),
                .inferred_name = false
            });
        }
    }

    return tags;
}

std::vector<std::string> expression_symbols(const std::string& expression) {
    static const std::set<std::string> ignored_symbols{
        "UPPER", "LOWER", "ALLTRIM", "LTRIM", "RTRIM", "PADR", "PADL", "TRANSFORM"
    };

    std::vector<std::string> symbols;
    std::string current;

    const auto flush = [&]() {
        if (current.empty()) {
            return;
        }

        const std::string upper = uppercase_copy(current);
        if (ignored_symbols.find(upper) == ignored_symbols.end()) {
            symbols.push_back(current);
        }
        current.clear();
    };

    for (char ch : expression) {
        if (is_identifier_char(ch)) {
            current.push_back(ch);
        } else {
            flush();
        }
    }
    flush();
    return symbols;
}

int expression_match_score(const std::string& tag_name, const std::string& expression) {
    const std::string normalized_tag = collapse_identifier(tag_name);
    if (normalized_tag.empty()) {
        return 0;
    }

    int best_score = 0;
    const auto score_candidate = [&](const std::string& candidate) {
        const std::string normalized_candidate = collapse_identifier(candidate);
        if (normalized_candidate.empty()) {
            return;
        }

        if (normalized_candidate == normalized_tag) {
            best_score = std::max(best_score, 100);
        } else if (normalized_candidate.starts_with(normalized_tag) ||
                   normalized_tag.starts_with(normalized_candidate)) {
            best_score = std::max(best_score, 90);
        } else if (normalized_candidate.find(normalized_tag) != std::string::npos ||
                   normalized_tag.find(normalized_candidate) != std::string::npos) {
            best_score = std::max(best_score, 70);
        } else if (normalized_candidate.size() > 1U &&
                   normalized_candidate.substr(1U) == normalized_tag) {
            best_score = std::max(best_score, 65);
        } else if (normalized_tag.size() > 1U &&
                   normalized_tag.substr(1U) == normalized_candidate) {
            best_score = std::max(best_score, 65);
        }
    };

    score_candidate(expression);
    for (const std::string& symbol : expression_symbols(expression)) {
        score_candidate(symbol);
    }

    return best_score;
}

std::vector<CdxTagDescriptor> extract_tag_descriptors(
    const std::vector<std::uint8_t>& bytes,
    std::size_t page_size,
    std::size_t key_length) {
    const std::vector<PrintableRun> expressions = collect_expression_runs(bytes);
    std::vector<CdxTagDescriptor> tags = collect_directory_leaf_tags(bytes, page_size, key_length);
    std::vector<bool> used(expressions.size(), false);

    for (CdxTagDescriptor& tag : tags) {
        int best_score = 0;
        std::size_t best_index = std::numeric_limits<std::size_t>::max();

        for (std::size_t index = 0; index < expressions.size(); ++index) {
            if (used[index]) {
                continue;
            }

            const int score = expression_match_score(tag.name_hint, expressions[index].text);
            if (score > best_score) {
                best_score = score;
                best_index = index;
            }
        }

        if (best_index == std::numeric_limits<std::size_t>::max() || best_score < 60) {
            continue;
        }

        used[best_index] = true;
        tag.key_expression_hint = expressions[best_index].text;
        tag.key_expression_offset_hint = static_cast<std::uint32_t>(expressions[best_index].offset);
    }

    std::vector<std::size_t> keyed_tag_indexes;
    keyed_tag_indexes.reserve(tags.size());
    for (std::size_t index = 0; index < tags.size(); ++index) {
        if (tags[index].key_expression_offset_hint != 0U) {
            keyed_tag_indexes.push_back(index);
        }
    }

    std::sort(keyed_tag_indexes.begin(), keyed_tag_indexes.end(), [&](std::size_t left, std::size_t right) {
        return tags[left].key_expression_offset_hint < tags[right].key_expression_offset_hint;
    });

    const std::size_t max_for_distance = std::max<std::size_t>(page_size * 2U, 512U);
    for (std::size_t tag_order = 0; tag_order < keyed_tag_indexes.size(); ++tag_order) {
        CdxTagDescriptor& tag = tags[keyed_tag_indexes[tag_order]];
        const std::size_t start_offset = tag.key_expression_offset_hint;
        const std::size_t end_offset = (tag_order + 1U) < keyed_tag_indexes.size()
            ? static_cast<std::size_t>(tags[keyed_tag_indexes[tag_order + 1U]].key_expression_offset_hint)
            : bytes.size();

        std::size_t best_index = std::numeric_limits<std::size_t>::max();
        for (std::size_t expression_index = 0; expression_index < expressions.size(); ++expression_index) {
            if (used[expression_index] || !looks_like_for_expression_candidate(expressions[expression_index].text)) {
                continue;
            }

            const std::size_t offset = expressions[expression_index].offset;
            if (offset <= start_offset || offset >= end_offset) {
                continue;
            }
            if ((offset - start_offset) > max_for_distance) {
                continue;
            }

            best_index = expression_index;
            break;
        }

        if (best_index == std::numeric_limits<std::size_t>::max()) {
            continue;
        }

        used[best_index] = true;
        tag.for_expression_hint = expressions[best_index].text;
        tag.for_expression_offset_hint = static_cast<std::uint32_t>(expressions[best_index].offset);
    }

    for (std::size_t index = 0; index < expressions.size(); ++index) {
        if (used[index]) {
            continue;
        }

        CdxTagDescriptor tag;
        tag.key_expression_hint = expressions[index].text;
        tag.key_expression_offset_hint = static_cast<std::uint32_t>(expressions[index].offset);
        tag.name_hint = derive_name_from_expression(expressions[index].text);
        tag.inferred_name = !tag.name_hint.empty();
        tags.push_back(std::move(tag));
    }

    return tags;
}

}  // namespace

bool CdxHeader::looks_like_cdx() const {
    if (file_size < page_size || page_size == 0U) {
        return false;
    }
    if ((file_size % page_size) != 0U) {
        return false;
    }
    if (root_node_offset == 0U || (root_node_offset % page_size) != 0U) {
        return false;
    }
    return root_node_offset < file_size;
}

CdxParseResult parse_cdx_header(const std::vector<std::uint8_t>& bytes, std::uint64_t file_size) {
    if (bytes.size() < 16U) {
        return {.ok = false, .error = "File is smaller than the minimum CDX header probe size (16 bytes)."};
    }

    CdxHeader header;
    header.file_size = file_size;

    for (std::size_t index = 0; index < header.raw_words.size(); ++index) {
        header.raw_words[index] = read_le_u16(bytes, index * 2U);
    }

    header.root_node_offset = header.raw_words[0];
    header.next_free_node_offset = header.raw_words[1];
    header.key_length_hint = header.raw_words[6];
    header.key_pool_length_hint = header.raw_words[7];

    if (!header.looks_like_cdx()) {
        return {.ok = false, .header = header, .error = "Header values do not look like a CDX-family index file."};
    }

    CdxParseResult result{.ok = true, .header = header};
    if (bytes.size() > 16U) {
        result.tags = extract_tag_descriptors(bytes, header.page_size, header.key_length_hint);
    }
    return result;
}

CdxParseResult parse_cdx_header_from_file(const std::string& path) {
    std::ifstream input(path, std::ios::binary);
    if (!input) {
        return {.ok = false, .error = "Unable to open file."};
    }

    const std::uint64_t file_size = static_cast<std::uint64_t>(std::filesystem::file_size(path));
    if (file_size < 16U) {
        return {.ok = false, .error = "Unable to read a complete 16-byte CDX header probe."};
    }

    std::vector<std::uint8_t> bytes(static_cast<std::size_t>(file_size), 0U);
    input.read(reinterpret_cast<char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()));
    bytes.resize(static_cast<std::size_t>(input.gcount()));
    return parse_cdx_header(bytes, file_size);
}

}  // namespace copperfin::vfp
