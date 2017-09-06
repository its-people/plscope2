SELECT object_name, type, name, usage, line  
  FROM user_identifiers ai  
 WHERE     ai.TYPE = 'VARIABLE'  
       AND ai.usage = 'DECLARATION'  
       AND ai.object_type = 'PACKAGE' 
       and ai.object_name = 'PACK1'
       and ai.usage_context_id = 1 -- we have to include this, otherwise we might 
                                   -- receive elements of record types which are also
                                   -- VARIABLEs
 ORDER BY line