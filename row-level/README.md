分為 shared locks(共享鎖)和exclusive locks(排他鎖)
# ref
- http://fanndy-wang.blogspot.com/2016/05/mysql-innodb.html
- https://blog.csdn.net/cug_jiang126com/article/details/50544728

# tip
- demo-share.sql

        SELECT balance FROM accounts WHERE username = 'A' LOCK IN SHARE MODE;
        這個指令使用了 LOCK IN SHARE MODE，它是一個行級鎖，也稱為共享鎖（shared lock）。當一個事務使用 LOCK IN SHARE MODE 鎖定一行時，其他事務可以讀取該行的資料，但不能對其進行修改。

        SELECT balance FROM accounts WHERE username = 'A' FOR SHARE;
        這個指令使用了 FOR SHARE，同樣是一個行級鎖，也是一種共享鎖（shared lock）。它的行為與 LOCK IN SHARE MODE 相同，允許其他事務讀取被鎖定行的資料，但不能修改。

        這兩個指令的區別在於使用的語法不同，但在這個情境中，它們的效果是相同的：鎖定用戶 A 的資料以防止其他事務對其進行修改。您可以根據自己的喜好和需求選擇其中之一。

        需要注意的是，LOCK IN SHARE MODE 和 FOR SHARE 只在事務隔離級別為 REPEATABLE READ 或更高級別時生效。在 READ COMMITTED 級別下，每個 SELECT 查詢都會在執行期間鎖定所選行，而不需要使用這兩個語法。
- 當事務中使用排他鎖去lock row時，其他thread訪問該`row`時就會堵塞，但換了其他`row`就不會堵塞了
- 當事務中使用共享鎖去lock row時，其他thread讀取同一列也不會堵塞，但如果要進行更新、新增、刪除就會堵塞