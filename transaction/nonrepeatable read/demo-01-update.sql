use wallet;

begin;
    update accounts set balance = 999 where username = 'A';
commit;