{{
  config(
    alias='failures_' ~ dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

with
-- given
{% set columns = [
    '"Country or region"','"Score"','"GDP per capita"','"Social support"','"Healthy life expectancy"','"Freedom to make life choices"','"Generosity"','"Perceptions of corruption"',
] %}
{% set list_values = [
    ['Finland',              7.632,  1.305,          1.592,              0.874,                      0.681,                             0.202,          '0.393',],
    ['Norway',               7.594,  1.456,          1.582,              0.861,                      0.686,                             0.286,          '0.340',],
    ['United Arab Emirates', 6.774,  2.096,          0.776,              0.670,                      0.284,                             0.186,          'N/A',],
] %}

world_happiness_dataset as (
    {{ create_world_happiness_dataset(
        year_like='2018_2019',
        columns=columns,
        list_values=list_values,
    ) }}
),

-- when
standardize_dataset as (
    {{ standardize_world_happiness_dataset(
        year_like='2018_2019',
        year=2018,
        table_ref='world_happiness_dataset',
    ) }}
),

-- then
{% set columns = [
    'year','country_name',          'score','gdp_per_capita','social_support','healthy_life_expectancy','freedom_to_make_life_choices','generosity','perceptions_of_corruption','dystopia_plus_residual',
] %}
{% set list_values = [
    [ 2018,'Finland',               7.632,  1.305,              1.592,          0.874,                  0.681,                          0.202,          0.393,                  2.585,],
    [ 2018,'Norway',                7.594,  1.456,              1.582,          0.861,                  0.686,                          0.286,          0.34,                   2.383,],
    [ 2018,'United Arab Emirates',  6.774,  2.096,              0.776,          0.67,                   0.284,                          0.186,          None,                   None,],
] %}

expected as (
    {{ create_standardized_happiness_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
),

assert as (
    {{ dbt_testing.assert_equal(
        expected='expected',
        actual='standardize_dataset',
        columns=columns
    ) }}
)

select
    *
from assert
