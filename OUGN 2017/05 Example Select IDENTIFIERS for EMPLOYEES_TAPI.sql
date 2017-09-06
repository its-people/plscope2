 select name, type, usage, usage_id
      , line, col
      , usage_context_id
      , object_name, object_type, signature
   from user_identifiers
  where object_name = 'EMPLOYEES_TAPI'
    and object_type = 'PACKAGE BODY'
  order by object_name, object_type, usage_id