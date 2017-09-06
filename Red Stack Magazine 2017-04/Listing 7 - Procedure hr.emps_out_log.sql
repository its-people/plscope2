create or replace procedure hr.emps_out_log 
  authid definer
is 
  v_string varchar2(2000);
  v_int integer;
begin
  pit.enter('emps_out');
  for rec in (select last_name, salary from employees)
  loop
    v_string := rec.last_name;
    v_int := rec.salary;
    sys.dbms_output.put_line(v_string || ' ' || sys.standard.to_char(v_int,99999));
  end loop;
  pit.leave;
exception
  when others then
    pit.stop;
end;
/

