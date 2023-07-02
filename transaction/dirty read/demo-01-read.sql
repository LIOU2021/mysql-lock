use wallet;

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
begin;
    select * from accounts where username = 'A';
commit;