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

-- when
world_happiness_dataset as (
    {{ create_world_happiness_dataset(
        year_like='2016',
        columns=columns,
        list_values=list_values,
    ) }}
),

-- then
assert as (
    {{ dbt_testing.assert_equal(
        expected=ref('world_happiness_dataset_example_2016'),
        actual='world_happiness_dataset',
        columns=columns,
    ) }}
)

select
    *
from assert
