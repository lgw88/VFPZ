#include "copperfin/vfp/asset_inspector.h"

#include <iostream>

namespace {

void print_usage() {
    std::cout << "Usage: copperfin_inspect <path-to-vfp-asset>\n";
}

void print_inspection(const copperfin::vfp::AssetInspectionResult& result) {
    using copperfin::vfp::asset_family_name;
    using copperfin::vfp::index_kind_name;

    std::cout << "path: " << result.path << "\n";
    std::cout << "asset_family: " << asset_family_name(result.family) << "\n";

    if (!result.ok) {
        std::cout << "status: error\n";
        std::cout << "error: " << result.error << "\n";
        return;
    }

    std::cout << "status: ok\n";
    if (!result.header_available) {
        std::cout << "header: not_applicable\n";
    } else {
        const auto& header = result.header;
        std::cout << "header.version: 0x" << std::hex << static_cast<unsigned int>(header.version) << std::dec << "\n";
        std::cout << "header.version_description: " << header.version_description() << "\n";
        std::cout << "header.last_update: " << header.last_update_iso8601() << "\n";
        std::cout << "header.record_count: " << header.record_count << "\n";
        std::cout << "header.header_length: " << header.header_length << "\n";
        std::cout << "header.record_length: " << header.record_length << "\n";
        std::cout << "header.table_flags: 0x" << std::hex << static_cast<unsigned int>(header.table_flags) << std::dec << "\n";
        std::cout << "header.code_page_mark: 0x" << std::hex << static_cast<unsigned int>(header.code_page_mark) << std::dec << "\n";
        std::cout << "header.has_memo_file: " << (header.has_memo_file() ? "true" : "false") << "\n";
        std::cout << "header.has_production_index: " << (header.has_production_index() ? "true" : "false") << "\n";
        std::cout << "header.has_structural_cdx: " << (header.has_structural_cdx() ? "true" : "false") << "\n";
        std::cout << "header.has_database_container: " << (header.has_database_container() ? "true" : "false") << "\n";
    }

    if (result.indexes.empty()) {
        std::cout << "indexes: none\n";
        return;
    }

    for (std::size_t index = 0; index < result.indexes.size(); ++index) {
        const auto& item = result.indexes[index];
        const auto& probe = item.probe;

        std::cout << "index[" << index << "].path: " << item.path << "\n";
        std::cout << "index[" << index << "].kind: " << index_kind_name(probe.kind) << "\n";
        std::cout << "index[" << index << "].file_size: " << probe.file_size << "\n";
        std::cout << "index[" << index << "].block_size: " << probe.block_size << "\n";
        std::cout << "index[" << index << "].root_node_offset_hint: " << probe.root_node_offset_hint << "\n";
        std::cout << "index[" << index << "].free_node_offset_hint: " << probe.free_node_offset_hint << "\n";
        std::cout << "index[" << index << "].end_of_file_offset_hint: " << probe.end_of_file_offset_hint << "\n";
        std::cout << "index[" << index << "].key_length_hint: " << probe.key_length_hint << "\n";
        std::cout << "index[" << index << "].max_keys_hint: " << probe.max_keys_hint << "\n";
        std::cout << "index[" << index << "].group_length_hint: " << probe.group_length_hint << "\n";
        std::cout << "index[" << index << "].flags: 0x"
                  << std::hex << static_cast<unsigned int>(probe.flags) << std::dec << "\n";
        std::cout << "index[" << index << "].signature: 0x"
                  << std::hex << static_cast<unsigned int>(probe.signature) << std::dec << "\n";
        std::cout << "index[" << index << "].multi_tag: " << (probe.multi_tag ? "true" : "false") << "\n";
        std::cout << "index[" << index << "].production_candidate: "
                  << (probe.production_candidate ? "true" : "false") << "\n";
        if (!probe.key_expression_hint.empty()) {
            std::cout << "index[" << index << "].key_expression_hint: " << probe.key_expression_hint << "\n";
        }
        if (!probe.for_expression_hint.empty()) {
            std::cout << "index[" << index << "].for_expression_hint: " << probe.for_expression_hint << "\n";
        }
        for (std::size_t tag_index = 0; tag_index < probe.tags.size(); ++tag_index) {
            const auto& tag = probe.tags[tag_index];
            std::cout << "index[" << index << "].tag[" << tag_index << "].name_hint: " << tag.name_hint << "\n";
            std::cout << "index[" << index << "].tag[" << tag_index << "].key_expression_hint: "
                      << tag.key_expression_hint << "\n";
            std::cout << "index[" << index << "].tag[" << tag_index << "].name_offset_hint: "
                      << tag.name_offset_hint << "\n";
            std::cout << "index[" << index << "].tag[" << tag_index << "].key_expression_offset_hint: "
                      << tag.key_expression_offset_hint << "\n";
            std::cout << "index[" << index << "].tag[" << tag_index << "].inferred_name: "
                      << (tag.inferred_name ? "true" : "false") << "\n";
            if (!tag.for_expression_hint.empty()) {
                std::cout << "index[" << index << "].tag[" << tag_index << "].for_expression_hint: "
                          << tag.for_expression_hint << "\n";
            }
            if (tag.for_expression_offset_hint != 0U) {
                std::cout << "index[" << index << "].tag[" << tag_index << "].for_expression_offset_hint: "
                          << tag.for_expression_offset_hint << "\n";
            }
        }
    }
}

}  // namespace

int main(int argc, char** argv) {
    if (argc != 2) {
        print_usage();
        return 1;
    }

    const copperfin::vfp::AssetInspectionResult result = copperfin::vfp::inspect_asset(argv[1]);
    print_inspection(result);
    return result.ok ? 0 : 2;
}
