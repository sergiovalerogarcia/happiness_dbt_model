{% macro standardize_dataset_with_sk(year_like, year, table_ref) %}
    with
    standardize_world_happiness_dataset as (
        {{ happiness.standardize_world_happiness_dataset(year_like, year, table_ref) }}
    )

    select
        *,
        {{ dbt_utils.surrogate_key(['country_name']) }} as country_name_sk
    from standardize_world_happiness_dataset
{% endmacro %}
