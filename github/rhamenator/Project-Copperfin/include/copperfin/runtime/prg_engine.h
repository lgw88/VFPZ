#pragma once

#include <cstddef>
#include <map>
#include <memory>
#include <optional>
#include <string>
#include <vector>

namespace copperfin::runtime {

enum class PrgValueKind {
    empty,
    boolean,
    number,
    string
};

struct PrgValue {
    PrgValueKind kind = PrgValueKind::empty;
    bool boolean_value = false;
    double number_value = 0.0;
    std::string string_value;
};

struct SourceLocation {
    std::string file_path;
    std::size_t line = 0;
};

struct RuntimeBreakpoint {
    std::string file_path;
    std::size_t line = 0;
};

enum class DebugResumeAction {
    continue_run,
    step_into,
    step_over,
    step_out
};

enum class DebugPauseReason {
    none,
    entry,
    breakpoint,
    step,
    event_loop,
    completed,
    error
};

struct RuntimeStackFrame {
    std::string file_path;
    std::string routine_name;
    std::size_t line = 0;
    std::map<std::string, PrgValue> locals;
};

struct RuntimeEvent {
    std::string category;
    std::string detail;
    SourceLocation location{};
};

struct RuntimeWorkAreaState {
    int selected = 1;
    int data_session = 1;
    std::map<int, std::string> aliases;
};

struct RuntimeCursorState {
    int work_area = 0;
    std::string alias;
    std::string source_path;
    std::string source_kind;
    std::string filter_expression;
    bool remote = false;
    std::size_t record_count = 0;
    std::size_t recno = 0;
    bool bof = true;
    bool eof = true;
};

struct RuntimeSqlConnectionState {
    int handle = 0;
    std::string target;
    std::string provider;
    std::string last_cursor_alias;
    std::size_t last_result_count = 0;
};

struct RuntimeOleObjectState {
    int handle = 0;
    std::string prog_id;
    std::string source;
    std::string last_action;
    int action_count = 0;
};

struct RuntimePauseState {
    bool paused = false;
    bool completed = false;
    bool waiting_for_events = false;
    DebugPauseReason reason = DebugPauseReason::none;
    SourceLocation location{};
    std::string statement_text;
    std::string message;
    std::vector<RuntimeStackFrame> call_stack;
    std::map<std::string, PrgValue> globals;
    std::vector<RuntimeEvent> events;
    RuntimeWorkAreaState work_area{};
    std::vector<RuntimeCursorState> cursors;
    std::vector<RuntimeSqlConnectionState> sql_connections;
    std::vector<RuntimeOleObjectState> ole_objects;
    std::size_t executed_statement_count = 0;
};

struct RuntimeSessionOptions {
    std::string startup_path;
    std::string working_directory;
    bool stop_on_entry = false;
};

class PrgRuntimeSession {
public:
    static PrgRuntimeSession create(const RuntimeSessionOptions& options);

    PrgRuntimeSession(PrgRuntimeSession&&) noexcept;
    PrgRuntimeSession& operator=(PrgRuntimeSession&&) noexcept;
    ~PrgRuntimeSession();

    void add_breakpoint(const RuntimeBreakpoint& breakpoint);
    void clear_breakpoints();
    [[nodiscard]] bool dispatch_event_handler(const std::string& routine_name);

    [[nodiscard]] RuntimePauseState run(DebugResumeAction action);
    [[nodiscard]] const RuntimePauseState& state() const noexcept;

private:
    struct Impl;

    explicit PrgRuntimeSession(std::unique_ptr<Impl> impl);

    std::unique_ptr<Impl> impl_;
};

[[nodiscard]] const char* debug_pause_reason_name(DebugPauseReason reason);
[[nodiscard]] std::string format_value(const PrgValue& value);

}  // namespace copperfin::runtime
