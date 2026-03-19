{%- macro generate_schema_name(custom_schema_name, node) -%}
    {%- if  not node.unique_id.startswith('model.dbt_artifacts') -%}

        {%- set default_schema = target.schema -%}
        {%- set nodelist = node.name.split('__') -%}
        {%- set custom_schema_name = nodelist[1] -%}  
        
            {{ custom_schema_name | trim  }}

    {%- else -%}

        {{ default_schema  }}

    {%- endif -%}
{%- endmacro -%}