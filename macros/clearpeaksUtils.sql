{% macro cp_generate_surrogate_key(columns) %}
    md5(
      concat_ws(
        '||',
        {% for col in columns %}
          coalesce(cast({{ col }} as string), '')
          {%- if not loop.last %}, {% endif -%}
        {% endfor %}
      )
    )
{% endmacro %}

