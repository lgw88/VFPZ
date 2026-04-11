#pragma once

#include <string_view>
#include <vector>

namespace copperfin::studio {

enum class ProductHostKind {
    native_ide,
    visual_studio_shell,
    shared_service
};

struct ProductSubsystemDescriptor {
    std::string_view id;
    std::string_view title;
    std::string_view vfp9_equivalent;
    std::string_view copperfin_component;
    ProductHostKind host_kind = ProductHostKind::native_ide;
    std::string_view current_status;
    std::string_view parity_scope;
    std::string_view modern_editor_direction;
};

[[nodiscard]] const char* product_host_kind_name(ProductHostKind kind);
[[nodiscard]] const std::vector<ProductSubsystemDescriptor>& product_subsystems();

}  // namespace copperfin::studio
