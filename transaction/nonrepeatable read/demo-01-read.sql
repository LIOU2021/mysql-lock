use wallet;

-- 在未commit前多次查詢用戶A的資料，會因為其他事務的update提交而導致出現不同的結果，此為不可重複讀問題
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
begin;
    select * from accounts where username = 'A';
commit;