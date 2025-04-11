# BAMOE Oracle Mappings
This module contains the necessary resources to make BAMOE applications that require persistence 
correctly work in Oracle.


## Hibernate ORM's

Some BAMOE Components, such as Data Index, Job Service and Data Audit, use JPA to manage the persistence. 
In order to make them correctly work, some of the BAMOE DDL's have been adapted to avoid using reserved 
words in Oracle, renaming some columns and table names. To solve this, this module contains a set of orm.xml
that will remap those entities for each individual BAMOE component that requires it, to use the fixed names defined 
in the DB.

 The available orm's are:
-    META-INF/bamoe-job-service-orm.xml: This file remaps some entities from the jbpm-usertask-storage-jpa component.
-    META-INF/bamoe-user-task-orm.xml: This file remaps some entities from the user-task component.

### Configuration

Depending on the dependencies configured in the application it may be required to configure which ORM should be used. 
To configure which mapping files should be imported you can use the quarkus.hibernate-orm.mapping-files to configure
a comma-separated list containing which ORM  files to use.

````
Eg:
 quarkus.hibernate-orm.mapping-files=META-INF/bamoe-job-service-ormxml,META-INF/bamoe-user-task-orm.xml
````
Note: 
 More about Quarkus Hibernate-ORM: https://es.quarkus.io/guides/hibernate-orm
