# Multiple dilutions in one packaging run

`dilutions` is an optional authoritative list of individually identified dilution
portions. Each has its own calculation (including sugar additions) and measured
ABV. The run retains the product, estimate, transfers, final units, label range,
status and excise reference. Portions are not batches or inventory postings.
`dilutionMode` records whether portions are homogenised or continuously packaged.

Compatibility: missing/null `dilutions` means the legacy `productionDilution` and
`abvReading` form a single portion with ID `legacy`. An explicit empty list means
no portions, even if old legacy fields remain in a MongoDB document. On first
edit the app writes the full list. Existing completed runs need no migration.
New nested calculation dates remain ISO UTC strings; no database date indexing
is required. New clients must be used to edit multi-dilution runs: older clients
cannot display or edit the new portions. The desktop REST service preserves the
nested data without a server schema deployment.
