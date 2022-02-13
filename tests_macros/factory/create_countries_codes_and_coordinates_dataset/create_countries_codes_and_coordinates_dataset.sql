{% macro create_countries_codes_and_coordinates_dataset(columns, list_values) %}
    {{ dbt_testing.create_dataset(
        default_columns_and_types=[
            { 'column': '"Country"',            'type': 'varchar' },
            { 'column': '"Alpha-2 code"',       'type': 'varchar' },
            { 'column': '"Alpha-3 code"',       'type': 'varchar' },
            { 'column': '"Numeric code"',       'type': 'varchar' },
            { 'column': '"Latitude (average)"', 'type': 'varchar' },
            { 'column': '"Longitude (average)"','type': 'varchar' },
        ],
        list_values=list_values,
        columns=columns,
    )}}
{% endmacro %}
