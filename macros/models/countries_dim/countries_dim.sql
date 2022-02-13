{% macro countries_dim(table_ref) %}
    with
    rename_columns_and_trim as (
        select
            "Country" as country_name,
            trim(
                replace("Alpha-3 code", '"', '')
            ) as country_code_3
        from {{ table_ref }}
    )

    select
        country_name,
        country_code_3,
        {{ dbt_utils.surrogate_key(['country_name']) }} as country_name_sk,
        {{ dbt_utils.surrogate_key(['country_code_3']) }} as country_code_3_sk
    from rename_columns_and_trim
{% endmacro %}
