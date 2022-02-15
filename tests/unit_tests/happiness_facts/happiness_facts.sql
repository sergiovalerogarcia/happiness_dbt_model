{{
  config(
    alias='failures_' ~ dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

with
-- given
{% set columns = [
    '"Country name"','"Ladder score"','"Explained by: Log GDP per capita"','"Explained by: Social support"','"Explained by: Healthy life expectancy"','"Explained by: Freedom to make life choices"','"Explained by: Generosity"','"Explained by: Perceptions of corruption"','"Dystopia + residual"',
] %}
{% set list_values = [
    ['Finland',         7.808700085,    1.285189509,                        1.499525905,                        0.961271405,                            0.66231674,                                     0.159670442,                0.477857262,                                2.762835026,],
    ['Denmark',         7.645599842,    1.326948524,                        1.503449202,                        0.979332566,                            0.665039897,                                    0.242793396,                0.495260328,                                2.432740688,],
    ['Switzerland',     7.559899807,    1.39077425,                         1.472403407,                        1.040533185,                            0.62895447,                                     0.269055754,                0.407945901,                                2.35026741,],
] %}


world_happiness_dataset as (
    {{ create_world_happiness_dataset(
        year_like='2020_2021',
        columns=columns,
        list_values=list_values,
    ) }}
),

-- when
standardize_world_happiness_with_sk as (
    {{ standardize_world_happiness_with_sk(
        year_like='2020_2021',
        year=2020,
        table_ref='world_happiness_dataset',
    ) }}
),

happiness_facts as (
    {{ happiness_facts(table_ref='standardize_world_happiness_with_sk',) }}
),

-- then
{% set columns = [
    'year','country_name_sk',               'score','gdp_per_capita','social_support','healthy_life_expectancy','freedom_to_make_life_choices','generosity','perceptions_of_corruption','dystopia_plus_residual',
] %}
{% set list_values = [
    [2020,'6f781c6559a0c605da918096bdb69edf', 7.808700085,1.285189509, 1.499525905, 0.961271405,               0.66231674,                     0.159670442, 0.477857262,               2.762835026,],
    [2020,'424214945ba5615eca039bfe5d731c09', 7.645599842,1.326948524, 1.503449202, 0.979332566,               0.665039897,                    0.242793396, 0.495260328,               2.432740688,],
    [2020,'3ad08396dc5afa78f34f548eea3c1d64', 7.559899807,1.39077425,  1.472403407, 1.040533185,               0.62895447,                     0.269055754, 0.407945901,               2.35026741,],
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
        actual='happiness_facts',
        columns=columns
    ) }}
)

select
    *
from assert
