# de-portfolio

Monorepo for three data-engineering portfolio projects sharing one platform layer.

| Path | Purpose | Status |
|---|---|---|
| `platform/dbt_shared` | Shared dbt project (DuckDB dev, Athena cloud stub) | scaffold |
| `platform/terraform` | AWS skeleton: S3, Glue, Athena, IAM, Budgets | phase 2 |
| `p4_recon` | Reconciliation project | not started |
| `p5_delivery` | Delivery project | not started |
| `p9_abtk` | A/B testing toolkit | not started |

## Quick start

```bash
make setup   # uv sync (Python 3.11) + pre-commit hooks
make lint    # ruff + sqlfluff
make test    # pytest + dbt build on DuckDB
make demo    # local demo, no AWS
make teardown
```

## Honesty

What is real, synthetic, or simulated. This section is updated as each project lands.

- **Real:** the tooling and code in this repo (dbt models, macros, Terraform, CI) all run as written. dbt runs against DuckDB locally and in CI.
- **Synthetic:** all data is generated or taken from public sample sets. No employer, customer, or personal data is used. Each project's README states its data source.
- **Simulated:** the cloud path. Terraform is validated (`terraform validate`) but **not applied** by default, and the Athena target is a stub that CI does not exercise. Any cost or latency figure for AWS is therefore an estimate, not a measurement, unless a project says it deployed.
