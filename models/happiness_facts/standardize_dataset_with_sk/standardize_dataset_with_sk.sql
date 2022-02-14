with
{% set table_ref = var('world_happiness_dataset', 'happiness.world_happiness_dataset_2020') %}

{% if dbt_testing.integration_tests_run_mode() %}
    {% set table_ref = 'mock_world_happiness_dataset' %}
    {{ table_ref }} as (
      {{ mock_world_happiness_dataset(year_like=var('year_like','2020_2021')) }}
    ),
{% endif %}

standardize_dataset_with_sk as (
    {{ standardize_dataset_with_sk(
        year_like=var('year_like','2020_2021'),
        year=var('year', '2020'),
        table_ref=table_ref,
    ) }}
)

select *
from standardize_dataset_with_sk
