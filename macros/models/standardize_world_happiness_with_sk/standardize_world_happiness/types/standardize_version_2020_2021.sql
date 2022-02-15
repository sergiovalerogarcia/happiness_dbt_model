{% macro standardize_version_2020_2021(year, table_ref) %}
    select
        {{ year }}::int as year,
        "Country name" as country_name,
        "Ladder score" as score,
        "Explained by: Log GDP per capita" as gdp_per_capita,
        "Explained by: Social support" as social_support,
        "Explained by: Healthy life expectancy" as healthy_life_expectancy,
        "Explained by: Freedom to make life choices" as freedom_to_make_life_choices,
        "Explained by: Generosity" as generosity,
        "Explained by: Perceptions of corruption" as perceptions_of_corruption,
        "Dystopia + residual" as dystopia_plus_residual
    from {{ table_ref }}

{% endmacro %}
