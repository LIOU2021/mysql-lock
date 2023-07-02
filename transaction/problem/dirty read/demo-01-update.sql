use wallet;

begin;
    update accounts set balance = 998 where username = 'A';
commit;