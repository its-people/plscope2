select object_name  
     , object_type  
     , name  
     , line
  from user_identifiers u 
 where usage = 'DECLARATION'  
   and type = 'VARIABLE' 
   and not exists (select * 
                     from user_identifiers i 
                    where i.signature = u.signature 
                      and i.usage not in
                          ('DECLARATION','ASSIGNMENT'))
