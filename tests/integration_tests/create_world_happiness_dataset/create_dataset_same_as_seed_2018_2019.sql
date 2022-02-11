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

-- when
world_happiness_dataset as (
    {{ create_world_happiness_dataset(
        year_like='2018_2019',
        columns=columns,
        list_values=list_values,
    ) }}
),

-- then
assert as (
    {{ dbt_testing.assert_equal(
        expected=ref('world_happiness_dataset_example_2018_2019'),
        actual='world_happiness_dataset',
        columns=columns,
    ) }}
)

select
    *
from assert
