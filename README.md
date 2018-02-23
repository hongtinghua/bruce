 spring事务，围绕着两个核心PlatformTransactionManager和TransactionStatus
 spring提供了几个关于事务处理的类： 
 TransactionDefinition     //事务属性定义
 TranscationStatus         //代表了当前的事务，可以提交，回滚。
 PlatformTransactionManager这个是spring提供的用于管理事务的基础接口，其下有一个实现的抽象类AbstractPlatformTransactionManager,
我们使用的事务管理类例如:DataSourceTransactionManager等都是这个类的子类。
 

一般事务定义步骤：
TransactionDefinition td = new TransactionDefinition();
     TransactionStatus ts = transactionManager.getTransaction(td);
      try {
           transactionManager.commit(ts);
      }catch(Exception e) {
           transactionManager.rollback(ts);
      }


1.@Transactional方式（声明式）
1).在spring-mvc.xml中添加如下注解

2).在service的方法上添加如下注解即可




2.编程式













