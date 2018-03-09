
SQL优化准则

1.对查询进行优化，应尽量避免全表扫描，首先应考虑在 where 及 order by 涉及的列上建立索引。

2.应尽量避免在 where 子句中对字段进行 null 值判断，否则将导致引擎放弃使用索引而进行全表扫描，如：	
select id from t where num is null	
可以在num上设置默认值0，确保表中num列没有null值，然后这样查询：	
select id from t where num=0	

3.应尽量避免在 where 子句中使用!=或<>操作符，否则将引擎放弃使用索引而进行全表扫描。

4.应尽量避免在 where 子句中使用 or 来连接条件，否则将导致引擎放弃使用索引而进行全表扫描，如：	
select id from t where num=10 or num=20	
可以这样查询：	
select id from t where num=10	
union all	
select id from t where num=20	

5.应尽量避免在 where 子句中对字段进行表达式操作，这将导致引擎放弃使用索引而进行全表扫描。如：	
select id from t where num/2=100	
应改为:	
select id from t where num=100*2

6.不要在 where 子句中的“=”左边进行函数、算术运算或其他表达式运算，否则系统将可能无法正确使用索引。

7.很多时候用 exists 代替 in 是一个好的选择：	
select num from a where num in(select num from b)	
用下面的语句替换：	
select num from a where exists(select 1 from b where num=a.num)	

8.并不是所有索引对查询都有效，SQL是根据表中数据来进行查询优化的，当索引列有大量数据重复时，SQL查询可能不会去利用索引，	
如一表中有字段sex，male、female几乎各一半，那么即使在sex上建了索引也对查询效率起不了作用。	

9.索引并不是越多越好，索引固然可以提高相应的 select 的效率，但同时也降低了 insert 及 update 的效率，	
因为 insert 或 update 时有可能会重建索引，所以怎样建索引需要慎重考虑，视具体情况而定。	
一个表的索引数最好不要超过6个，若太多则应考虑一些不常使用到的列上建的索引是否有必要。

10.尽量使用数字型字段，若只含数值信息的字段尽量不要设计为字符型，这会降低查询和连接的性能，并会增加存储开销。	
这是因为引擎在处理查询和连接时会逐个比较字符串中每一个字符，而对于数字型而言只需要比较一次就够了。

11.尽可能的使用 varchar 代替 char ，因为首先变长字段存储空间小，可以节省存储空间，	
其次对于查询来说，在一个相对较小的字段内搜索效率显然要高些。


12.任何地方都不要使用 select * from t ，用具体的字段列表代替“*”，不要返回用不到的任何字段。

13.尽量避免大事务操作，提高系统并发能力。

14.6.尽量避免向客户端返回大数据量，若数据量过大，应该考虑相应需求是否合理。 



