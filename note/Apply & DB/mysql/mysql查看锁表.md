-- 查看那些表锁到了
show OPEN TABLES where In_use > 0;
-- 查看进程号
show processlist;
--删除进程
kill 1085850；  
