with
{% set table_ref = ref('countries_codes_and_coordinates_raw') %}

{% if dbt_testing.integration_tests_run_mode() %}
    {% set table_ref = 'mock_countries_codes_and_coordinates_raw' %}
    {{ table_ref }} as (
      {{ mock_countries_codes_and_coordinates_raw() }}
    ),
{% endif %}

countries_no_duplicates as (
  {{ countries_no_duplicates(table_ref=table_ref) }}
)

select *
from countries_no_duplicates
