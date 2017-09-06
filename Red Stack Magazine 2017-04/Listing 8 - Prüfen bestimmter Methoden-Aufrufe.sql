with methoden as (
    select owner, object_name, object_type, usage_id
         , type, name, usage_context_id
      from dba_identifiers
     where owner = 'HR'
       and type	in ('PROCEDURE','FUNCTION')
       and usage = 'DEFINITION'
)
select m.owner, m.object_name, m.object_type, m.name method_name
     , i.name log_package, j.name log_method
     , count (distinct j.name) 
        over (partition by m.owner, m.object_name, m.object_type, m.name) ok
  from methoden m 
  left outer join dba_identifiers i 
    on i.object_name = m.object_name and i.object_type = m.object_type
   and i.name = 'PIT' and i.type = 'SYNONYM'
   and i.usage_context_id = m.usage_id
  left outer join dba_identifiers j 
    on j.object_name = m.object_name and m.object_type = j.object_type              
   and j.name in ('ENTER','LEAVE')
   and j.usage_context_id = i.usage_id
 order by m.owner, m.object_name, m.object_type, m.name
        , i.usage, i.object_name, j.usage, j.name 