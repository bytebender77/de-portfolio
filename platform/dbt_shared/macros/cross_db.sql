{#
  Thin wrappers over dbt's built-in cross-database macros (dbt.*).
  Models call these instead of engine-specific functions, so the same SQL
  compiles on DuckDB (dev) and Athena (cloud). Add new wrappers here, never
  raw dialect functions, in models.
#}

{% macro xdb_date_trunc(datepart, column) -%}
    {{ dbt.date_trunc(datepart, column) }}
{%- endmacro %}

{% macro xdb_datediff(first_date, second_date, datepart) -%}
    {{ dbt.datediff(first_date, second_date, datepart) }}
{%- endmacro %}

{% macro xdb_cast(column, type) -%}
    {{ dbt.safe_cast(column, type) }}
{%- endmacro %}

{% macro xdb_concat(fields) -%}
    {{ dbt.concat(fields) }}
{%- endmacro %}
