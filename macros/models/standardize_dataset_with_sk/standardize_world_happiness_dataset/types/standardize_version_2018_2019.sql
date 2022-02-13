{% macro standardize_version_2018_2019(year, table_ref) %}
    with
    add_default_columns as (
        select
            {{ year }}::int as year,
            "Country or region" as country_name,
            "Score" as score,
            "GDP per capita" as gdp_per_capita,
            "Social support" as social_support,
            "Healthy life expectancy" as healthy_life_expectancy,
            "Freedom to make life choices" as freedom_to_make_life_choices,
            "Generosity" as generosity,
            "Perceptions of corruption" as perceptions_of_corruption
        from {{ table_ref }}
    ),

    perceptions_of_corruption_to_float_NA_to_null as (
        select
            year,
            country_name,
            score,
            gdp_per_capita,
            social_support,
            healthy_life_expectancy,
            freedom_to_make_life_choices,
            generosity,
            case
                when perceptions_of_corruption = 'N/A'
                then null
                else perceptions_of_corruption
            end::float as perceptions_of_corruption
        from add_default_columns
    ),

    add_dystopia_plus_residual as (
        select
            *,
            round(
                (
                    score
                    - gdp_per_capita
                    - social_support
                    - healthy_life_expectancy
                    - freedom_to_make_life_choices
                    - generosity
                    - perceptions_of_corruption
                )::numeric,
                3
            ) as dystopia_plus_residual
        from perceptions_of_corruption_to_float_NA_to_null
    )

    select *
    from add_dystopia_plus_residual
{% endmacro %}
