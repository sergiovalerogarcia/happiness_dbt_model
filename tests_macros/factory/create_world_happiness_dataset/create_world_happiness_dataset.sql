{% macro create_world_happiness_dataset(year_like, columns, list_values) %}
    {% if year_like == '2015'%}
        {{ happiness.create_world_happiness_2015_dataset(columns, list_values) }}
    {% endif %}
    {% if year_like == '2016'%}
        {{ happiness.create_world_happiness_2016_dataset(columns, list_values) }}
    {% endif %}
    {% if year_like == '2017'%}
        {{ happiness.create_world_happiness_2017_dataset(columns, list_values) }}
    {% endif %}
    {% if year_like == '2018_2019'%}
        {{ happiness.create_world_happiness_2018_2019_dataset(columns, list_values) }}
    {% endif %}
    {% if year_like == '2020_2021'%}
        {{ happiness.create_world_happiness_2020_2021_dataset(columns, list_values) }}
    {% endif %}
{% endmacro %}
