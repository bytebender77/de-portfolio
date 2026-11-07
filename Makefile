.PHONY: setup lint test demo teardown
DBT = cd platform/dbt_shared && uv run dbt
DBT_FLAGS = --profiles-dir . --project-dir .

setup:  ## Install Python 3.11 deps and git hooks
	uv sync
	uv run pre-commit install
	$(DBT) deps $(DBT_FLAGS) || true

lint:  ## ruff + sqlfluff
	uv run ruff check .
	uv run ruff format --check .
	uv run sqlfluff lint platform/dbt_shared/models platform/dbt_shared/macros

test:  ## pytest + dbt tests on DuckDB
	uv run pytest
	$(DBT) build $(DBT_FLAGS) --target dev

demo:  ## Local-only demo on DuckDB (no AWS). Projects hook in here later.
	$(DBT) build $(DBT_FLAGS) --target dev
	@echo "Demo: dbt smoke build OK. Project demos are added as p4/p5/p9 land."

teardown:  ## Remove local artifacts. Never touches AWS (see platform/terraform).
	rm -rf platform/dbt_shared/target platform/dbt_shared/logs platform/dbt_shared/*.duckdb* .pytest_cache .ruff_cache
