with plscope_hierarchy
        as (select line , col, name, type, usage, usage_id, usage_context_id,object_name
              from all_identifiers
             where owner = 'OUGN'
                  and object_name = 'EMPLOYEES_TAPI'
                  and object_type = 'PACKAGE BODY'
                  )
select    lpad (' ', 3 * (level - 1))
       || type || ' ' || name || ' (' || usage || ')' identifier_hierarchy, line
  from plscope_hierarchy
start with usage_context_id = 0
connect by prior usage_id = usage_context_id
order siblings by line, col