alter session set plscope_settings = 'IDENTIFIERS:ALL,STATEMENTS:ALL';

create or replace procedure prc_unused as
  cursor cur is select last_name, salary from employees;
  v_string varchar2(2000) := 'Hurz!';
  v_int integer;
begin 
  for r in cur 
  loop 
    v_int := r.salary;
    sys.dbms_output.put_line(r.last_name || ' ' || v_int);
  end loop; 
end prc_unused;
/
