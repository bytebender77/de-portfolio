## Phase 2: CI and Terraform skeleton

Nothing here is applied to AWS; `terraform validate` passes and CI runs it with `-backend=false`.

### Non-obvious choices
**Scaffold (phase 1)**
- Own nested git repo: `~/Desktop` is already a large unrelated repo.
- `dbt-athena` is an optional `cloud` extra so `make setup` and CI stay fast and DuckDB-only.
- Models call `xdb_*` wrapper macros over `dbt.*` built-ins so one SQL file compiles on DuckDB and Athena.
- sqlfluff uses the `dbt` templater because plain Jinja cannot resolve dbt macros (it skips `macros/` files).
- The DuckDB file lives in `.local/` via `DUCKDB_PATH` so `make teardown` can remove it cleanly.

**CI**
- `uv sync --frozen`: CI fails if `uv.lock` is stale instead of silently re-resolving.
- dbt job uses `fetch-depth: 0` so it can diff against the PR base.
- Changed models build with a trailing `+` (selector `name+`) to also rebuild their downstream models.
- Changes to macros, `dbt_project.yml`, `profiles.yml` or seeds build everything, since they can affect any model.
- No model changes means the dbt job exits early rather than building nothing and reporting green.
- `permissions: contents read` and a `concurrency` group limit token scope and wasted runs.
- Terraform job pins 1.9.8 and runs `fmt -check` plus `validate`, with no credentials needed.

**Terraform**
- Provider `skip_credentials_validation` / `skip_requesting_account_id` let `validate` run offline.
- Bucket name includes the account id because S3 names are global.
- `force_destroy` on the bucket and workgroup: data is disposable and `terraform destroy` must finish.
- 7-day expiry on `athena-results/` and a 1 GiB per-query scan cutoff keep costs bounded.
- `enforce_workgroup_configuration` stops clients from overriding the result location or scan limit.
- IAM role trusts only this account's root and is scoped to the one bucket, workgroup and Glue database.
- Budget alerts at 80% actual and 100% forecast of a $5 default; `alert_email` has no default so it is never committed.
- `terraform.tfvars` and state are gitignored; only `terraform.tfvars.example` is tracked.
