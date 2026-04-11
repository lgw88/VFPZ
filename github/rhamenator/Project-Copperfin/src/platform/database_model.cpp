#include "copperfin/platform/database_model.h"

namespace copperfin::platform {

DatabaseFederationProfile default_database_federation_profile() {
    DatabaseFederationProfile profile;
    profile.available = true;

    profile.connectors = {
        {"dbf", "DBF/CDX/FPT Native Storage", "xbase", "embedded file engine", "tabular", "Copperfin should treat legacy xBase storage as a first-class runtime and design-time store.", true, true, false},
        {"sqlite", "SQLite", "relational", "embedded SQL engine", "tabular", "FoxPro-style SQL can be translated through a deterministic SQL dialect mapper for straightforward relational workloads.", true, true, false},
        {"postgresql", "PostgreSQL", "relational", "network SQL engine", "tabular", "FoxPro-style SQL can map to PostgreSQL with a deterministic relational translator and optional extensions such as pgvector.", true, true, false},
        {"sqlserver", "SQL Server", "relational", "network SQL engine", "tabular", "FoxPro-style SQL can map to SQL Server through a deterministic relational translator with stored procedure and security-policy support.", true, true, false},
        {"oracle", "Oracle", "relational", "network SQL engine", "tabular", "Oracle stays in the first-class relational path even when syntax normalization is required.", true, true, false},
        {"mongodb", "MongoDB/JSON Document Stores", "document", "network document engine", "document", "Document stores need projection and predicate translation from FoxPro-style queries into dynamic document pipelines.", false, false, true},
        {"json-api", "HTTP/JSON Data APIs", "document", "remote service", "document", "JSON-backed services need schema discovery and dynamic projection to feel browseable through xBase-style commands.", false, false, true},
        {"vector", "Vector/Embedding Stores", "vector", "service or extension", "vector", "Vector stores need semantic-search operators, embedding pipelines, and optional AI-assisted query planning around deterministic connector rules.", false, false, true}
    };

    profile.query_paths = {
        {"foxsql-relational", "Fox SQL To Relational SQL", "FoxPro-style SQL", "relational SQL dialect", "low-to-medium", "Build a canonical Copperfin query AST and lower it deterministically into each relational backend dialect.", true, false},
        {"xbase-browse-document", "xBase Browse To Document Projection", "xBase browse/filter commands", "JSON projection and pipeline query", "medium", "Translate browse/filter intent into field projection, path navigation, and document predicates.", true, true},
        {"foxsql-document", "Fox SQL To Document Query Plan", "FoxPro-style SQL", "document database pipeline", "medium-to-high", "Lower simple selects and filters deterministically, then allow optional AI assistance for ambiguous nested-document reshaping.", true, true},
        {"foxsql-vector", "Fox SQL To Vector Retrieval Plan", "FoxPro-style SQL plus semantic operators", "vector search request", "high", "Use deterministic retrieval templates first, then optionally ask an approved AI model to help synthesize semantic ranking or hybrid-search plans.", true, true},
        {"xbase-polyglot", "xBase Commands Across Polyglot Stores", "SEEK/BROWSE/SCAN/REPORT intent", "connector-specific execution plan", "medium-to-high", "Normalize xBase intent into Copperfin commands that each connector can execute or reject with an explainable compatibility result.", true, true}
    };

    profile.guardrails = {
        "Deterministic translators come first for relational backends and other straightforward mappings.",
        "AI-assisted query planning stays optional, policy-controlled, and outside the trusted execution core.",
        "Document and vector backends should expose browseable schema hints even when the source is dynamic or sparse.",
        "Connector failures must be explainable so developers know when Copperfin translated a query directly and when it needed a planner."
    };

    return profile;
}

}  // namespace copperfin::platform
