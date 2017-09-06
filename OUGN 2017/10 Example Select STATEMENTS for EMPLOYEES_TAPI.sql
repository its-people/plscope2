select type, usage_id, line, col
     , usage_context_id, sql_id     
     , has_hint, has_into_bulk, has_into_returning
     , has_into_record, has_current_of, has_for_update
     , has_in_binds
     , text
     , full_text 
     , object_name, object_type
     , signature
from user_statements
  where object_name = 'EMPLOYEES_TAPI'
    and object_type = 'PACKAGE BODY'
  order by object_name, object_type, usage_id