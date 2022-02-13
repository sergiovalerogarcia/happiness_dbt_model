{{
  config(
    alias='failures_' ~ dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

with
-- given
{% set columns = [
    '"Country"','"Alpha-3 code"',
] %}
{% set list_values = [
    ['Afghanistan', ' "AFG"',],
    ['Albania', ' "ALB"',],
    ['Algeria', ' "DZA"',],
    ['Libyan Arab Jamahiriya', ' "LBY"',],
    ['Libya', ' "LBY"',],
] %}

create_countries_codes_and_coordinates_dataset as (
    {{ create_countries_codes_and_coordinates_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
),

-- when
countries_no_duplicates as (
    {{ countries_no_duplicates(
        table_ref='create_countries_codes_and_coordinates_dataset',
    ) }}
),

countries_dim as (
    {{ countries_dim(
        table_ref='countries_no_duplicates',
    ) }}
),

-- then

{% set columns = [
    'country_name','country_code_3','country_name_sk',                  'country_code_3_sk',
] %}
{% set list_values = [
    ['Afghanistan', 'AFG',          '6e9767f4f15357401b148b9a8ced14ef','c902514ac30b6e23dbb0c3dc80ec7d4a',],
    ['Albania',     'ALB',          'c420ddff824a5c0eec70dd23d62496bc','e3252e1a8c33a30ae3fac99574706989',],
    ['Algeria',     'DZA',          '575b9408b6daa2ddcefbcf6d81c9b4c9','dbc2e375dac704e6b5fc039c519cc1b4',],
] %}

expected as (
    {{ create_countries_dim_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
),

assert as (
    {{ dbt_testing.assert_equal(
        expected='expected',
        actual='countries_dim',
        columns=columns
    ) }}
)

select
    *
from assert
