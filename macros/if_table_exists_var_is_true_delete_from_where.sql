{% macro if_table_exists_var_is_true_delete_from_where(name, where_clause) %}
    {% if var('table_exists', 'true') == 'true' %}
        delete from {{ env_var("DBNAME") }}.{{ env_var("SCHEMA") }}.{{ name }}
        where {{ where_clause }}
    {% endif %}
{% endmacro %}
