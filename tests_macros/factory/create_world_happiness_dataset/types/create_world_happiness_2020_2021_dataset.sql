{% macro create_world_happiness_2020_2021_dataset(columns, list_values) %}
    {{ dbt_testing.create_dataset(
        default_columns_and_types=[
            { 'column': '"Country name"',                                   'type': 'varchar' },
            { 'column': '"Regional indicator"',                             'type': 'varchar' },
            { 'column': '"Ladder score"',                                   'type': 'float' },
            { 'column': '"Standard error of ladder score"',                 'type': 'float' },
            { 'column': '"upperwhisker"',                                   'type': 'float' },
            { 'column': '"lowerwhisker"',                                   'type': 'float' },
            { 'column': '"Logged GDP per capita"',                          'type': 'float' },
            { 'column': '"Social support"',                                 'type': 'float' },
            { 'column': '"Healthy life expectancy"',                        'type': 'float' },
            { 'column': '"Freedom to make life choices"',                   'type': 'float' },
            { 'column': '"Generosity"',                                     'type': 'float' },
            { 'column': '"Perceptions of corruption"',                      'type': 'float' },
            { 'column': '"Ladder score in Dystopia"',                       'type': 'float' },
            { 'column': '"Explained by: Log GDP per capita"',               'type': 'float' },
            { 'column': '"Explained by: Social support"',                   'type': 'float' },
            { 'column': '"Explained by: Healthy life expectancy"',          'type': 'float' },
            { 'column': '"Explained by: Freedom to make life choices"',     'type': 'float' },
            { 'column': '"Explained by: Generosity"',                       'type': 'float' },
            { 'column': '"Explained by: Perceptions of corruption"',        'type': 'float' },
            { 'column': '"Dystopia + residual"',                            'type': 'float' },
        ],
        list_values=list_values,
        columns=columns,
    )}}
{% endmacro %}
