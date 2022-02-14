{{
  config(
    pre_hook=if_table_exists_var_is_true_delete_from_where(
      dbt_testing.generate_name_with_execution_type('happiness_facts'),
      'year = ' ~ var('year', '2020') ~ '::int;'
    ),
    materialized='incremental',
    alias=dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

{{ happiness_facts(ref('standardize_dataset_with_sk')) }}
