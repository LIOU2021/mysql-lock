use wallet;

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
begin;
    SELECT * FROM accounts WHERE balance BETWEEN 100 AND 500; 
commit;