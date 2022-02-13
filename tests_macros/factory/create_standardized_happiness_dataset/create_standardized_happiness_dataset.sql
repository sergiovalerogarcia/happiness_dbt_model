{% macro create_standardized_happiness_dataset(columns, list_values) %}
    {{ dbt_testing.create_dataset(
        default_columns_and_types=[
            { 'column': 'year',                         'type': 'int' },
            { 'column': 'country_name',                 'type': 'varchar' },
            { 'column': 'country_name_sk',              'type': 'varchar' },
            { 'column': 'score',                        'type': 'float' },
            { 'column': 'gdp_per_capita',               'type': 'float' },
            { 'column': 'social_support',               'type': 'float' },
            { 'column': 'healthy_life_expectancy',      'type': 'float' },
            { 'column': 'freedom_to_make_life_choices', 'type': 'float' },
            { 'column': 'generosity',                   'type': 'float' },
            { 'column': 'perceptions_of_corruption',    'type': 'float' },
            { 'column': 'dystopia_plus_residual',       'type': 'float' },
        ],
        list_values=list_values,
        columns=columns,
    )}}
{% endmacro %}
