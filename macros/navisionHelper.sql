{% macro get_company_tables(entity) %}
    {% set companies = run_query("select entity_prefix, company_name from " ~ ref('navisionCompanies')) %}

    {% if execute %}
        {% set tables = [] %}

        {% for row in companies %}
            {% set table_name = (row['ENTITY_PREFIX'] ~ '_' ~ entity) | upper %}

            {# ✅ Check if table exists in BRONZE schema #}
            {% set exists_query %}
                select count(*) as cnt
                from {{ target.database }}.information_schema.tables
                where table_schema = 'BRONZE'
                  and table_name = '{{ table_name }}'
            {% endset %}

            {% set exists_result = run_query(exists_query) %}

            {% if exists_result.columns[0].values()[0] > 0 %}
                {# ✅ Add relation + company_name as a tuple (dict) #}
                {% do tables.append({
                    'relation': adapter.get_relation(
                        database=target.database,
                        schema='BRONZE',
                        identifier=table_name
                    ),
                    'company_name': row['COMPANY_NAME']
                }) %}
            {% endif %}
        {% endfor %}

        {{ return(tables) }}
    {% else %}
        {{ return([]) }}
    {% endif %}
{% endmacro %}



{% macro union_company_tables(entity) %}
    {% set tables = get_company_tables(entity) %}

    {% if tables | length == 0 %}
        -- Return an empty table if no tables exist
        select null as company_name where 1=0
    {% else %}

        {% for table in tables %}
            {% if not loop.first %} union all {% endif %}
            select
                *,
                '{{ table['company_name'] }}' as company_name
            from {{ table['relation'] }}
        {% endfor %}

    {% endif %}
{% endmacro %}
