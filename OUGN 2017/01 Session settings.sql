alter session set plscope_settings='STATEMENTS:ALL,IDENTIFIERS:ALL';

-- Now recompile the code you are interested in

-- Here you can see which code unit has been compiled with which settings
-- and which identifiers and statements you can expect
select *
from user_plsql_object_settings;

-- Now, see what you've done ;-)
select *
from user_statements;

select *
from user_identifiers;
