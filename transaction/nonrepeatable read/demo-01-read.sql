use wallet;

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
begin;
    select * from accounts where username = 'A';
commit;