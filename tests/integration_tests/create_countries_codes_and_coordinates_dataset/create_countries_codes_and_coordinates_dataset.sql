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

-- when
create_countries_codes_and_coordinates_dataset as (
    {{ create_countries_codes_and_coordinates_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
),

-- then
assert as (
    {{ dbt_testing.assert_equal(
        expected=ref('countries_codes_and_coordinates_example'),
        actual='create_countries_codes_and_coordinates_dataset',
        columns=columns,
    ) }}
)

select
    *
from assert
