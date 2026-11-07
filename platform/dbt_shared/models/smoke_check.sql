-- Exercises every cross-db wrapper so `dbt build` proves the toolchain end to end.
-- Not a project model; delete once a real model uses these macros.
select
    {{ xdb_cast("'2026-01-15'", dbt.type_timestamp()) }} as ts,
    {{ xdb_date_trunc('month', xdb_cast("'2026-01-15'", dbt.type_timestamp())) }} as month_start,
    {{ xdb_datediff(xdb_cast("'2026-01-01'", dbt.type_timestamp()), xdb_cast("'2026-01-15'", dbt.type_timestamp()), 'day') }} as days_elapsed,
    {{ xdb_concat(["'p'", "'ortfolio'"]) }} as project_name
