#include "copperfin/studio/product_subsystems.h"

#include <cstdlib>
#include <iostream>
#include <string>

namespace {

int failures = 0;

void expect(bool condition, const std::string& message) {
    if (!condition) {
        std::cerr << "FAIL: " << message << "\n";
        ++failures;
    }
}

}  // namespace

int main() {
    const auto& subsystems = copperfin::studio::product_subsystems();
    expect(!subsystems.empty(), "product subsystem registry should not be empty");
    expect(subsystems.size() >= 10U, "product subsystem registry should cover the major VFP 9-equivalent surfaces");

    bool found_report = false;
    bool found_runtime = false;
    bool found_project_manager = false;

    for (const auto& subsystem : subsystems) {
        expect(!std::string(subsystem.id).empty(), "each subsystem should have an id");
        expect(!std::string(subsystem.title).empty(), "each subsystem should have a title");
        expect(!std::string(subsystem.vfp9_equivalent).empty(), "each subsystem should name the VFP 9 equivalent");
        expect(!std::string(subsystem.copperfin_component).empty(), "each subsystem should name the Copperfin component");
        expect(!std::string(subsystem.modern_editor_direction).empty(), "each subsystem should capture the modernized editor direction");

        if (subsystem.id == "report-designer") {
            found_report = true;
        }
        if (subsystem.id == "runtime-engine") {
            found_runtime = true;
        }
        if (subsystem.id == "project-manager") {
            found_project_manager = true;
        }
    }

    expect(found_report, "registry should include the report designer subsystem");
    expect(found_runtime, "registry should include the runtime engine subsystem");
    expect(found_project_manager, "registry should include the project manager subsystem");

    if (failures != 0) {
        std::cerr << failures << " test(s) failed.\n";
        return EXIT_FAILURE;
    }

    std::cout << "All tests passed.\n";
    return EXIT_SUCCESS;
}
