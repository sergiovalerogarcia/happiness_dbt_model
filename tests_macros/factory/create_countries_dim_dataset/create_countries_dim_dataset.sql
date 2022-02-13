{% macro create_countries_dim_dataset(columns, list_values) %}
    {{ dbt_testing.create_dataset(
        default_columns_and_types=[
            { 'column': 'country_name', 'type': 'varchar' },
            { 'column': 'country_code_3', 'type': 'varchar' },
            { 'column': 'country_name_sk', 'type': 'varchar' },
            { 'column': 'country_code_3_sk', 'type': 'varchar' },
        ],
        list_values=list_values,
        columns=columns,
    )}}
{% endmacro %}
