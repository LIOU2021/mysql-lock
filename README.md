當談到MySQL中的鎖（lock）和事務（transaction）技術時，這些是非常重要的概念，尤其在並發環境下，用於確保數據的完整性和一致性。

# 鎖（Lock） 
是用於控制對數據庫資源的訪問權限。當多個用戶同時訪問數據庫時，鎖的使用可以確保數據的一致性。MySQL提供了多種類型的鎖，包括共享鎖（shared lock）和排他鎖（exclusive lock）。

- 共享鎖（Shared Lock）：允許多個用戶同時讀取一個資源，但不允許對資源進行修改。多個共享鎖可以同時存在，互相不干擾。
- 排他鎖（Exclusive Lock）：阻止其他用戶對資源進行讀取或修改，只有持有排他鎖的用戶可以訪問資源。排他鎖一次只能由一個用戶持有。

# 事務（Transaction） 
是指一系列數據庫操作（例如插入、更新、刪除），它們作為一個單獨的工作單元一起執行，要麼全部執行成功，要麼全部失敗回滾。事務通常用於確保數據的完整性和一致性，並且提供了ACID（原子性、一致性、隔離性、持久性）特性。
- [四種事務等級](https://dev.mysql.com/doc/refman/8.0/en/innodb-transaction-isolation-levels.html)
    1. READ UNCOMMITTED
        - 其他事務未提交的數據，也會被當前事務讀取到
        - 會發生髒讀，數據可能隨時會被修改、commit、rollback，是不可靠的
    2. READ COMMITTED
        - 只讀取到提交後的變動
        - 因為沒使用快照，所以會發生不可重複讀。當其他事務提交後，當前事務不同時間點的同一查詢語句將會有不同的結果
    3. REPEATABLE READ
        - InnoDB默認
        - 避免了髒讀、不可重複讀，但有幻讀問題
        - 只讀取到commit後的訊息，所以避免了髒讀
        - 使用了快照(snapshot)，避免了不可重複讀        
    4. SERIALIZABLE
        - 隔離最高層級，可以避免幻讀
        - 其他事務的update、insert、delete語句將會被堵塞
- 查看當前事務預設等級
    ```mysql
    mysql> SELECT @@transaction_isolation;
    +-------------------------+
    | @@transaction_isolation |
    +-------------------------+
    | REPEATABLE-READ         |
    +-------------------------+
    1 row in set (0.00 sec)
    ```
- 切換事務的隔離level    
    - https://stackoverflow.com/questions/7937472/how-to-set-transaction-isolation-level-mysql
    - https://dev.mysql.com/doc/refman/8.0/en/set-transaction.html
    ```mysql
    SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    ```
# 不考慮事務隔離性(Isolation) 引發的問題
    事务的4种隔离级别（Isolation Level）分别是什么？
    https://blog.51cto.com/lhrbest/2705377
- 髒讀
    - A 事務讀取到B事務`尚未提交`更改的數據
- 不可重複讀
    - 在同一事務中，不同時間點的查詢where，會受其他事務`提交後`的`update`值
- 幻讀
    - 在當前事務上未提交前，多次進行select區間的query，看到了其他事務`提交後`的`insert`資料

# row lock 升級成 table lock的問題
- 參考
- https://www.cnblogs.com/itdragon/p/8194622.html
    1. InnoDB 支持表锁和行锁，使用索引作为检索条件修改数据时采用行锁，否则采用表锁。
    2. InnoDB 自动给修改操作加锁，给查询操作不自动加锁
    3. 行锁可能因为未使用索引而升级为表锁，所以除了检查索引是否创建的同时，也需要通过explain执行计划查询索引是否被实际使用。
    4. 行锁相对于表锁来说，优势在于高并发场景下表现更突出，毕竟锁的粒度小。
    5. 当表的大部分数据需要被修改，或者是多表复杂关联查询时，建议使用表锁优于行锁。
    6. 为了保证数据的一致完整性，任何一个数据库都存在锁定机制。锁定机制的优劣直接影响到一个数据库的并发处理能力和性能。    