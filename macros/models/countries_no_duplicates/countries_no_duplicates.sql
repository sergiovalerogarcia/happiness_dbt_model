{% macro countries_no_duplicates(table_ref) %}
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
        max(country_name) as country_name,
        country_code_3,
        count(*)
    from rename_columns_and_trim
    group by
        country_code_3
    having count(*) = 1
{% endmacro %}
