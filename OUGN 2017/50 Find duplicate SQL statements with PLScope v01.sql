-- create p1 and p2 first

  select object_name, signature, sql_id, text
    from user_statements 
   where object_name IN ('P1', 'P2') 
   order by sql_id;
