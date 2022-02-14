{{
  config(
    alias='failures_' ~ dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

with
-- given
happiness_facts as (
    select *
    from {{ ref('happiness_facts') }}
),

--when
happiness_facts_with_score_explained as (
    select
        *,
        abs(
            score
            - gdp_per_capita
            - social_support
            - healthy_life_expectancy
            - freedom_to_make_life_choices
            - generosity
            - perceptions_of_corruption
            - dystopia_plus_residual
        ) as score_explained
    from happiness_facts
)

-- then
select
    *
from happiness_facts_with_score_explained
where score_explained > 0.01
