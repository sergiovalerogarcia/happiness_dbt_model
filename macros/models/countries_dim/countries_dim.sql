{% macro countries_dim(table_ref) %}
    select
        country_name,
        country_code_3,
        {{ dbt_utils.surrogate_key(['country_name']) }} as country_name_sk,
        {{ dbt_utils.surrogate_key(['country_code_3']) }} as country_code_3_sk
    from {{ table_ref }}
{% endmacro %}
