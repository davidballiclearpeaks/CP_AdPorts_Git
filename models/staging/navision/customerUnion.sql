{% for t in get_company_tables('CUSTOMER') %}
-- depends_on: {{ t['relation'] }}
{% endfor %}

{{ union_company_tables('CUSTOMER') }}
