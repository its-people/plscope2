select s.type, s.object_name, s.object_type, s.line
  from user_statements s
 where s.type in ('UPDATE','INSERT','MERGE')
   and exists (select * 
                 from user_identifiers i 
                where s.usage_id = i.usage_context_id 
                  and s.object_name = i.object_name
                  and s.object_type = i.object_type
                  and i.name = 'FIRST_NAME' 
                  and i.type = 'COLUMN')
   and exists (select *
                from user_identifiers j
               where s.usage_id = j.usage_context_id
                 and s.object_name = j.object_name
                 and s.object_type = j.object_type
                 and j.name = 'EMPLOYEES' 
                 and j.type = 'TABLE')
