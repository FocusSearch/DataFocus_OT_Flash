# DataFocus OT Flash

![DataFocus OT Flash](assets/ot-flash-hero.svg)

**An agent knowledge backend for structured data, documents, and business semantics.**

[中文介绍](README.md) · [Download r53](https://github.com/FocusSearch/DataFocus_OT_Flash/releases/tag/v0.1.0-test-r53) · [Installation](docs/INSTALL.md) · [Release notes](docs/RELEASE-r53.md)

## What it does

OT Flash is a focused DataFocus distribution for agent knowledge services. Apache Doris stores imported business data in internal tables. Document workers parse, chunk, embed, and index documents. Ontology tools organize business objects, field mappings, relationships, and analysis rules. Authorized agents use the original query, search, knowledge, and MCP tools to work with these resources.

The distribution keeps the original BI workspace, permissions, and installation workflows. Full ETL product capabilities and AutoML are outside this release line. “Lightweight” describes the focused product scope; the complete offline installer includes runtime dependencies and is approximately **6.70 GiB**.

## Capabilities

- **Structured data:** CSV import and JDBC database connectors, physical Doris internal tables, and the original FocusSearch → BI → query engine path.
- **Database integration:** MySQL, PostgreSQL, SQL Server, Oracle, DB2, ClickHouse, SAP HANA, and OceanBase, plus compatible TiDB, Doris, and Greenplum connections. Every database has not been independently tested in this release.
- **Document knowledge:** batch upload, chunk and full-file checksums, preflight validation, resumable uploads, parsing, embedding, and indexing.
- **Ontology authoring:** source reads, candidate creation, preview, draft continuation, and a governed publication and maintenance toolchain. Publication requires the original authorization, budget, and trust configuration.
- **Agent access:** native ontology chat and authorized MCP/tool interfaces. Common greetings are handled locally. Model endpoints and credentials are configured per deployment.
- **BI and languages:** the original BI workspace, search, Q&A, and dashboards; 24 UI languages and 21 search languages, with release-specific validation coverage.
- **Operations:** self-hosted offline deployment, upgrades, and Doris online snapshots with S3-compatible storage. Restore interrupts service.

## Current release

**r53 / 0.1.0-test — CentOS 7 x86_64 — Pre-release**

The 7,191,482,492-byte archive is distributed as four GitHub Release assets because each asset must be smaller than 2 GiB. The [download script](scripts/download-r53.sh) downloads directly, verifies each part, assembles the original archive, and verifies its complete SHA-256. See [manual download instructions](docs/DOWNLOAD.md).

Validated: complete upgrade, matching installed files, successful database migrations, original login and Doris reads, a 2,505-row structured source, two fully processed document assets, and ontology candidate creation/preview/continuation.

Not yet validated end to end in this package: formal ontology publication, post-publication queries and pagination, mixed-source citations, conflict handling, and partial automatic updates. The test instance lacks the original validation budget accounts; exact publication trust also requires administrative configuration. These conditions have not been bypassed.

## Deployment and licensing

Use the original deployment wizard on a dedicated CentOS 7 x86_64 server. The bundled guide's reference node is 8 vCPU / 32 GB RAM, with 50 GB root and 300 GB data space; actual sizing depends on workload. This is not a newly measured minimum for r53.

New installations require instance-specific product authorization and model configuration. The initial administrator is `admin` with password `2020@Datafocus`; complete the original account setup and password change workflow.

This repository distributes release assets and documentation. Product and third-party licenses remain governed by their accompanying terms. Report reproducible issues without credentials, licenses, or private business data.
