ALTER SESSION SET plscope_settings='identifiers:all, statements:all';

create or replace procedure p1 (p_id number, p_name out varchar2) 
is 
begin 
   select last_name || ' OUGN'           
     into p_name 
     from employees 
    where employee_id = p_id; 

   select last_name || '' 
     into p_name 
     from employees 
    where employee_id = p_id; 

   select last_name || null 
     into p_name 
     from employees 
    where employee_id = p_id; 
end;
/

create or replace procedure p2 (id_in number, name_out out varchar2) 
is 
begin 

   select last_name 
     || ' OUGN'
     into name_out 
     from employees 
    where employee_id = id_in; 

   select last_name 
     || ' OUGN'
     into name_out 
     from employees 
    where id_in = employee_id; 

end;
/
