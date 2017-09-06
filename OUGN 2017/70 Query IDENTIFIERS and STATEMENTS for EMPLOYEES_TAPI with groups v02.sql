with one_obj_name as
  ( select 'EMPLOYEES_TAPI' object_name, 'PACKAGE BODY' object_type from dual
  ) ,
  main_query as
  (select plscope_type,
    usage_id,
    usage_context_id,
    lpad (' ', 2 * (level - 1))
    || usage
    || ' '
    || name usages,
    line,
    col ,
    usage ,
    type
     from
    (select 'ID' plscope_type,
      ai.object_name,
      ai.usage usage,
      ai.usage_id,
      ai.usage_context_id,
      ai.type
      || ' '
      || ai.name name,
      ai.line,
      ai.col ,
      ai.type
       from all_identifiers ai,
      one_obj_name
      where ai.object_name = one_obj_name.object_name
    and ai.object_type = one_obj_name.object_type
  union all
     select 'ST',
      st.object_name,
      st.type,
      st.usage_id,
      st.usage_context_id,
      'STATEMENT',
      st.line,
      st.col ,
      st.type
       from all_statements st,
      one_obj_name
      where st.object_name = one_obj_name.object_name
    and st.object_type = one_obj_name.object_type
    )
    start with usage_context_id = 0
    connect by prior usage_id = usage_context_id
  ) ,
  with_ranking as
  (select m.*,
    rank( ) over( partition by usage_context_id, decode(type,'COLUMN', 'COLUMN','TABLE','TABLE','OTHERS') order by usage_id ) order_within_context
     from main_query m
  )
 select r.PLSCOPE_TYPE, r.USAGE_ID, r.USAGE_CONTEXT_ID, r.USAGES, r.LINE, r.COL, r.USAGE, r.TYPE ,
  decode(
  (select count( *) from with_ranking rr where usage in ('REFERENCE')
  and type not in ('TABLE')
  and rr.usage_context_id = r.usage_context_id
  and rr.order_within_context = r.order_within_context
  and r.type not in ('TABLE')
  ) ,2
  /* two make a pair */
  ,usage_context_id
  ||'.'
  || order_within_context,null ) col_value_assignment
   from with_ranking r
order by usage_id