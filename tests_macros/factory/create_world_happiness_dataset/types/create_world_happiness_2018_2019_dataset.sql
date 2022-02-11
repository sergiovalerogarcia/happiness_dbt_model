{% macro create_world_happiness_2018_2019_dataset(columns, list_values) %}
    {{ dbt_testing.create_dataset(
        default_columns_and_types=[
            { 'column': '"Overall rank"',                    'type' : 'int' },
            { 'column': '"Country or region"',               'type' : 'varchar' },
            { 'column': '"Score"',                           'type' : 'float' },
            { 'column': '"GDP per capita"',                  'type' : 'float' },
            { 'column': '"Social support"',                  'type' : 'float' },
            { 'column': '"Healthy life expectancy"',         'type' : 'float' },
            { 'column': '"Freedom to make life choices"',    'type' : 'float' },
            { 'column': '"Generosity"',                      'type' : 'float' },
            { 'column': '"Perceptions of corruption"',       'type' : 'varchar' },
        ],
        list_values=list_values,
        columns=columns,
    )}}
{% endmacro %}
