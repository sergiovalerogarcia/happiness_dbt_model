{{
  config(
    alias='failures_' ~ dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

with
-- given
{% set columns = [
    '"Country"','"Happiness Score"','"Economy (GDP per Capita)"','"Family"','"Health (Life Expectancy)"','"Freedom"','"Generosity"','"Trust (Government Corruption)"','"Dystopia Residual"',
] %}
{% set list_values = [
    ['Denmark',     7.526,              1.44178,                    1.16374,    0.79504,                    0.57941,    0.36171,    0.44453,                            2.73939,],
    ['Switzerland', 7.509,              1.52733,                    1.14524,    0.86303,                    0.58557,    0.28083,    0.41203,                            2.69463,],
    ['Iceland',     7.501,              1.42666,                    1.18326,    0.86733,                    0.56624,    0.47678,    0.14975,                            2.83137,],
] %}

world_happiness_dataset as (
    {{ create_world_happiness_dataset(
        year_like='2016',
        columns=columns,
        list_values=list_values,
    ) }}
),

-- when
standardize_dataset as (
    {{ standardize_world_happiness_dataset(
        year_like='2015_2016',
        year=2016,
        table_ref='world_happiness_dataset',
    ) }}
),

-- then
{% set columns = [
    'year','country_name','score','gdp_per_capita','social_support','healthy_life_expectancy','freedom_to_make_life_choices','generosity','perceptions_of_corruption','dystopia_plus_residual',
] %}
{% set list_values = [
    [2016,  'Denmark',     7.526,              1.44178,                    1.16374,    0.79504,                    0.57941,    0.36171,    0.44453,                            2.73939,],
    [2016,  'Switzerland', 7.509,              1.52733,                    1.14524,    0.86303,                    0.58557,    0.28083,    0.41203,                            2.69463,],
    [2016,  'Iceland',     7.501,              1.42666,                    1.18326,    0.86733,                    0.56624,    0.47678,    0.14975,                            2.83137,],
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
