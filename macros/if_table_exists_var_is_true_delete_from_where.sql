{% macro if_table_exists_var_is_true_delete_from_where(name, schema, where_clause) %}
    {% if var('table_exists', 'true') == 'true' %}
        delete from {{ target.dbname }}.{{ schema }}.{{ name }}
        where {{ where_clause }}
    {% endif %}
{% endmacro %}
