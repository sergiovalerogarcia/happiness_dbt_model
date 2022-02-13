{% macro mock_countries_codes_and_coordinates_raw() %}
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

    {{ create_countries_codes_and_coordinates_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
{% endmacro %}
