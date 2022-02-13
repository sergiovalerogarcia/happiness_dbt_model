{% macro standardize_version_2015_2016(year, table_ref) %}
    select
        {{ year }}::int as year,
        "Country" as country_name,
        "Happiness Score" as score,
        "Economy (GDP per Capita)" as gdp_per_capita,
        "Family" as social_support,
        "Health (Life Expectancy)" as healthy_life_expectancy,
        "Freedom" as freedom_to_make_life_choices,
        "Trust (Government Corruption)" as perceptions_of_corruption,
        "Generosity" as generosity,
        "Dystopia Residual" as dystopia_plus_residual
    from {{ table_ref }}
{% endmacro %}