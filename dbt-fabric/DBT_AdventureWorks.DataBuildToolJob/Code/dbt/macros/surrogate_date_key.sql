{% macro surrogate_date_key(col) -%}
CONVERT(INT, CONVERT(VARCHAR(4), DATEPART(yyyy, {{col}})) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(mm, {{col}})), 2) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(dd, {{col}})), 2)) 
{%- endmacro %}

