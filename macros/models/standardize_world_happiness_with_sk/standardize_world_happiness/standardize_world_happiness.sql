{% macro standardize_world_happiness(year_like, year, table_ref) %}
    {% if year_like == '2015_2016'%}
        {{ happiness.standardize_version_2015_2016(year, table_ref) }}
    {% endif %}
    {% if year_like == '2017'%}
        {{ happiness.standardize_version_2017(year, table_ref) }}
    {% endif %}
    {% if year_like == '2018_2019'%}
        {{ happiness.standardize_version_2018_2019(year, table_ref) }}
    {% endif %}
    {% if year_like == '2020_2021'%}
        {{ happiness.standardize_version_2020_2021(year, table_ref) }}
    {% endif %}
{% endmacro %}
