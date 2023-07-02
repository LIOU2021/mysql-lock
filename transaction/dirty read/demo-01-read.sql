use wallet;

-- 查詢結果會受其他事務未commit提交前的影響，此為髒讀問題
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
begin;
    select * from accounts where username = 'A';
commit;