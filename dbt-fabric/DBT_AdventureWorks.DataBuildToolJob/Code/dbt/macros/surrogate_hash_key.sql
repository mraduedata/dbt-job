{% macro surrogate_hash_key(col) -%}
HASHBYTES('SHA2_256', {{col}})
{%- endmacro %}
