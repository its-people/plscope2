create or replace package "PACK1" is
    
    v_username varchar2(30); -- this is a variable declaration in the spec 
    
    type r1 is record (
        rf1 varchar2(10)     -- this is not a 'variable declaration in the spec',
                             -- but it looks a lot like one in PL/Scope
    );
    function f1 (
        fp1   number
    ) return number;
    procedure p1 (
        pp1   varchar2
    );
    procedure p1 (
        pp1   number
    );
end pack1;