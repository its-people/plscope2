select object_name, name, line
  from user_identifiers ai  
 where ai.type = 'VARIABLE'  
   and ai.usage = 'DECLARATION'  
   and ai.object_type = 'PACKAGE' 
   -- Hier müssen noch Falsch-Positive ausgeschlossen werden:
   -- Die Felder von Record-Deklarationen
   and not exists 
      (select * from user_identifiers ui 
        where ui.object_type = ai.object_type
          and ui.object_name = ai.object_name
          and ui.usage_id = ai.usage_context_id 
          and ui.type = 'RECORD')
 order by object_name, line
