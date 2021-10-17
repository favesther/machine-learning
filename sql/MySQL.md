4. MySQL 隔离等级有哪些
MySQL isolation levels有read committed, snapshot isolation (repeatable read), serializable isolation.
5. MySQL 默认隔离等级是什么？有什么优点？会出现什么现象？
MySQL默认的isolation level是snapshot isolation (repeatable read)
优点是可以解决dirty read, dirty write, non-repeatable read(read skew)且是一种optimistic concurrency control所以read不会block write, write不会block read.
但是没法解决write skew or phantom的anomaly, 并且由于是read consistent snapshot所以没有linearizable guarantee, 另外MVCC本身不知道算不算是一种cost毕竟要maintain 很多不同的committed versions
7. MySQL 有哪些锁？
row-level lock, index-range lock(next-key lock), table-level lock