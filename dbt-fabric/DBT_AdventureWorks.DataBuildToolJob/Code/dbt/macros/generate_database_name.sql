{% macro generate_database_name(custom_database_name, node) -%}

    {%- set default_database = target.database -%}


    {% if node.name[:4] == 'Silv' %}
        {{"WH_Silver"}}

    {% elif node.name[:4] == 'Gold' %}
        {{"WH_Gold"}}

    {%- else -%} 
        {{ "LH_Bronze"}}
    {%- endif -%}

{%- endmacro -%}