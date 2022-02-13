{% macro happiness_facts(table_ref) %}
select
    year,
    country_name_sk,
    score,
    gdp_per_capita,
    social_support,
    healthy_life_expectancy,
    freedom_to_make_life_choices,
    perceptions_of_corruption,
    generosity,
    dystopia_plus_residual
from {{ table_ref }}
{% endmacro %}
