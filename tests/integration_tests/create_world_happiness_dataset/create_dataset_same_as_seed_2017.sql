{{
  config(
    alias='failures_' ~ dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

with
-- given
{% set columns = [
    '"Country"','"Happiness.Score"','"Economy..GDP.per.Capita."','"Family"','"Health..Life.Expectancy."','"Freedom"','"Generosity"','"Trust..Government.Corruption."','"Dystopia.Residual"',
] %}
{% set list_values = [
    ['Norway',     7.53700017929077,   1.61646318435669,   1.53352355957031,   0.796666502952576,   0.635422587394714,   0.36201223731041,  0.315963834524155,          2.27702665328979,],
    ['Denmark',    7.52199983596802,   1.48238301277161,   1.55112159252167,   0.792565524578094,   0.626006722450256,   0.355280488729477, 0.40077006816864,           2.31370735168457,],
    ['Iceland',    7.50400018692017,   1.480633020401,     1.6105740070343,    0.833552122116089,   0.627162635326385,   0.475540220737457, 0.153526559472084,          2.32271528244019,],
] %}

-- when
world_happiness_dataset as (
    {{ create_world_happiness_dataset(
        year_like='2017',
        columns=columns,
        list_values=list_values,
    ) }}
),

-- then
assert as (
    {{ dbt_testing.assert_equal(
        expected=ref('world_happiness_dataset_example_2017'),
        actual='world_happiness_dataset',
        columns=columns,
    ) }}
)

select
    *
from assert
