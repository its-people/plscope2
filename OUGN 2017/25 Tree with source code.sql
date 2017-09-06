with param as (select 'EMPLOYEES_TAPI' object_name, 'PACKAGE BODY' object_type from dual),
plscope_hierarchy
        AS (SELECT line
                 , col
                 , name
                 , TYPE
                 , usage
                 , usage_id
                 , usage_context_id
                 , ai.object_name
              FROM user_identifiers ai, param
             WHERE ai.object_name = param.object_name
              and ai.object_Type = param.object_Type
                  ),
connects as (                  
select  h.line,
        h.col,
        lpad (' ', 3 * (level - 1))
       || h.type || ' ' || h.name || ' (' || usage || ')' identifier_hierarchy,
       usage_id,
       usage_context_id,
       name
from plscope_hierarchy h                
start with h.usage_context_id = 0
connect by prior h.usage_id = h.usage_context_id
order siblings by h.line, h.col)
select c.IDENTIFIER_HIERARCHY, 
       c.USAGE_ID, 
       c.USAGE_CONTEXT_ID, 
       c.col,
       s.line,
       s.text
 from user_source s
 join param p on s.name = p.object_name 
  and s.type = p.object_type
 left outer join connects c on c.line = s.line  
order by s.line, col;