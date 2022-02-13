{{
  config(
    materialized='table',
    alias=dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

{{ countries_dim(ref('countries_no_duplicates')) }}
