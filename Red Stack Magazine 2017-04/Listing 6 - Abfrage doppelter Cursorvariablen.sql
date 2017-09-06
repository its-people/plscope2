with explizit as (select ui1.* 
                    from user_identifiers ui1
                    left outer join user_identifiers ui2
                      on ui1.usage_id = ui2.usage_context_id
                     and ui1.object_name = ui2.object_name
                     and ui1.object_type = ui2.object_type 
                   where ui1.type  = 'VARIABLE'
                     and ui1.usage = 'DECLARATION'
                     and ui2.type  = 'CURSOR'
                     and ui2.usage = 'REFERENCE'),
     implizit as (select ui1.*
                    from user_identifiers ui1
                    left outer join user_identifiers ui2
                      on ui1.usage_id = ui2.usage_context_id
                     and ui1.object_name = ui2.object_name
                     and ui1.object_type = ui2.object_type
                   where ui1.type  = 'ITERATOR'
                     and ui1.usage = 'DECLARATION'
                     and ui2.type  = 'CURSOR'
                     and ui2.usage = 'CALL')
select d.name, substr(d.signature,1,7) signature, d.type, d.object_name
     , d.object_type, d.usage_id, d.usage_context_id, d.line, d.col
     , count (distinct d.type) 
        over (partition by d.object_name, d.object_type, d.usage_context_id) anzahl
     , s.text
from (select * from explizit 
      union
      select * from implizit)  d 
join user_source s 
  on s.name = d.object_name 
 and s.type = d.object_type 
 and s.line = d.line
 where object_name not in ('CURSOR_DEMO','PRC_UNUSED')
order by d.object_name, d.object_type, d.usage_id