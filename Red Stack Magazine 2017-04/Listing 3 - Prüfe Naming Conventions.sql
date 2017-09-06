-- Hier sollen einigen Namenskonventionen f�r bestimmte
-- Identifier-Arten �berpr�ft werden.
-- Diese Beispiele sind sehr simpel, aber dank REGEXP
-- sind der Phantasie nat�rlich kaum Grenzen gesetzt :-)

-- Zu sehen:
-- 1. Die CHK-Spalte ist NULL f�r Packages und Bodies, da wir hier keine 
-- Regel definiert haben
-- 2. CHK ist 0 f�r das Record-Feld RF1, da dieses den Typ VARIABLE hat und
-- daher mit V_ beginnen sollte. Will man hier eine andere Konvention
-- durchsetzen, muss man �ber die Verkn�pfung von USAGE_ID und 
-- USAGE_CONTEXT_ID pr�fen, ob es sich um ein Record-Element handelt
-- 3. CHK ist 0 f�r P1; dies ist eine Prozedur aus einem anderen Package (PACK1),
-- in dem m�glicherweise andere Namenskonventionen gelten. Will man diese
-- herausfiltern, so muss man ebenfalls �ber USAGE_ID und 
-- USAGE_CONTEXT_ID gehen
select case i.type when 'VARIABLE' 
                  then instr(upper(i.name),'V_')
                  when 'CONSTANT' 
                  then instr(upper(i.name),'C_')
                  when 'FUNCTION'
                  then instr(upper(i.name),'FNC_')
                  when 'PROCEDURE'
                  then instr(upper(i.name),'PRC_')
                  when 'FORMAL IN' -- In-Parameter
                  then instr(upper(i.name),'P_')
            end chk
   , i.name, substr(i.signature,1,7) signature, i.type, i.line
   , u.text user_source_text
from sys.dba_identifiers i 
join user_source u 
  on u.line = i.line and u.name = i.object_name and u.type = i.object_type  
where i.object_name = 'ADD_JOB_HISTORY' and i.owner = 'HR'
and i.usage = 'DECLARATION' 
order by i.object_name, i.object_type, i.line, i.col