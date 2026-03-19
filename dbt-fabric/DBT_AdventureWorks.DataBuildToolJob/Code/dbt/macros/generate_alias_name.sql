{% macro generate_alias_name(custom_alias_name, node) -%}
    {%- if not node.unique_id.startswith('model.dbt_artifacts') -%}
        
        {%- set nodelist = node.name.split('__') -%}
        {%- set custom_alias_name = nodelist [2] -%}
        {%- if custom_alias_name is none -%}
            {{ node.name }}
        {%- else -%}
            {{ custom_alias_name | trim }}
        {%- endif -%}

    {%- else -%}
        {%- if custom_alias_name -%}
            {{ custom_alias_name | trim }}
        {%- else -%}
            {{ node.name }}
        {%- endif -%}
    {%- endif -%}
{%- endmacro %}
