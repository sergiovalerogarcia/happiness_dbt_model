{% macro create_world_happiness_2017_dataset(columns, list_values) %}
    {{ dbt_testing.create_dataset(
        default_columns_and_types=[
            { 'column': '"Country"',                         'type': 'varchar' },
            { 'column': '"Happiness.Rank"',                  'type': 'int' },
            { 'column': '"Happiness.Score"',                 'type': 'float' },
            { 'column': '"Whisker.high"',                    'type': 'float' },
            { 'column': '"Whisker.low"',                     'type': 'float' },
            { 'column': '"Economy..GDP.per.Capita."',        'type': 'float' },
            { 'column': '"Family"',                          'type': 'float' },
            { 'column': '"Health..Life.Expectancy."',        'type': 'float' },
            { 'column': '"Freedom"',                         'type': 'float' },
            { 'column': '"Generosity"',                      'type': 'float' },
            { 'column': '"Trust..Government.Corruption."',   'type': 'float' },
            { 'column': '"Dystopia.Residual"',               'type': 'float' },
        ],
        list_values=list_values,
        columns=columns,
    )}}
{% endmacro %}
