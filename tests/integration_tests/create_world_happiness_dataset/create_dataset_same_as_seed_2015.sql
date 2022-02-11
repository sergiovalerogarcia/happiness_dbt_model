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
    ['Switzerland', 7.587,              1.39651,                    1.34951,    0.94143,                   0.66557,     0.29678,    0.41978,                            2.51738,],
    ['Iceland',     7.561,              1.30232,                    1.40223,    0.94784,                   0.62877,     0.4363,     0.14145,                            2.70201,],
    ['Denmark',     7.527,              1.32548,                    1.36058,    0.87464,                   0.64938,     0.34139,    0.48357,                            2.49204,],
] %}

-- when
world_happiness_dataset as (
    {{ create_world_happiness_dataset(
        year_like='2015',
        columns=columns,
        list_values=list_values,
    ) }}
),

-- then
assert as (
    {{ dbt_testing.assert_equal(
        expected=ref('world_happiness_dataset_example_2015'),
        actual='world_happiness_dataset',
        columns=columns,
    ) }}
)

select
    *
from assert
