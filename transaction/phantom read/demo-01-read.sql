use wallet;

-- 透過阻塞避免幻讀
-- 如果是使用InnoDB預設的隔離層級REPEATABLE READ，該事務在提交前的多次查詢，會受到其他事務提交後的insert影響，就會多看到一些原本沒有的資料，此為幻讀問題
-- 如果其他thread是 select 查詢則不會有堵塞，此情況就類似讀寫鎖
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
begin;
    SELECT * FROM accounts WHERE balance BETWEEN 100 AND 500; 
commit;