# ref
- https://dev.mysql.com/doc/refman/8.0/en/internal-locking.html
- https://dev.mysql.com/doc/refman/8.0/en/lock-tables.html
- https://blog.twjoin.com/%E9%8E%96-lock-%E7%9A%84%E4%BB%8B%E7%B4%B9%E8%88%87%E6%AD%BB%E9%8E%96%E5%88%86%E6%9E%90-19833c18baab

# tip
- 分為讀鎖跟寫鎖
- 讀鎖
    - 唯讀，嘗試更改、刪除、新增操作都會失敗
    - 其他thread在嘗試讀取時並不會失敗也不會堵塞
    - 嘗試讀取其他表時，將會失敗
- 寫鎖
    - 可以對該table進行CRUD
    - 其他thread如果要訪問table就會發生堵塞，直到lock被釋放
    - 嘗試操作其他表時，將會失敗