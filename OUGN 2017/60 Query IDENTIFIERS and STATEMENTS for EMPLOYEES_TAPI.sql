with param as (select 'EMPLOYEES_TAPI' object_name, 'PACKAGE BODY' object_type from dual)
    select plscope_type, usage_id,
           usage_context_id,
           lpad (' ', 2 * (level - 1)) || usage || ' ' || name usages,
           line,
           col
      from (select 'ID' plscope_type,
                   ai.object_name,
                   ai.usage usage,
                   ai.usage_id,
                   ai.usage_context_id,
                   ai.type || ' ' || ai.name name,
                   ai.line,
                   ai.col
              from all_identifiers ai, param
             where ai.object_name = param.object_name and ai.object_type = param.object_type
            union all
            select 'ST',
                   st.object_name,
                   st.type,
                   st.usage_id,
                   st.usage_context_id,
                   'STATEMENT',
                   st.line,
                   st.col
              from all_statements st, param
             where st.object_name = param.object_name and st.object_type = param.object_type)
start with usage_context_id = 0
connect by prior usage_id = usage_context_id










