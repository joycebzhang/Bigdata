Download hbase client phoenix from http://apache.forsale.plus/phoenix/apache-phoenix-4.14.0-HBase-1.4/bin/

 gunzip apache-phoenix-4.14.0-HBase-1.4-bin.tar.gz

 tar xvf apache-phoenix-4.14.0-HBase-1.4-bin.tar



or using yum install phoenix in Centos

--Run sqlline.py localhost
[root@sandbox-hdp bin]# pwd
/usr/hdp/current/phoenix-client/bin

[root@sandbox-hdp bin]# ./sqlline.py localhost


CREATE TABLE company (COMPANY_ID INTEGER PRIMARY KEY, NAME VARCHAR(225));

!tables

0: jdbc:phoenix:localhost> !table
+------------+--------------+-------------+---------------+----------+------------+----------------------------+-----------------+--------------+-----------+
| TABLE_CAT  | TABLE_SCHEM  | TABLE_NAME  |  TABLE_TYPE   | REMARKS  | TYPE_NAME  | SELF_REFERENCING_COL_NAME  | REF_GENERATION  | INDEX_STATE  | IMMUTABLE |
+------------+--------------+-------------+---------------+----------+------------+----------------------------+-----------------+--------------+-----------+
|            | SYSTEM       | CATALOG     | SYSTEM TABLE  |          |            |                            |                 |              | false     |
|            | SYSTEM       | FUNCTION    | SYSTEM TABLE  |          |            |                            |                 |              | false     |
|            | SYSTEM       | SEQUENCE    | SYSTEM TABLE  |          |            |                            |                 |              | false     |
|            | SYSTEM       | STATS       | SYSTEM TABLE  |          |            |                            |                 |              | false     |
+------------+--------------+-------------+---------------+----------+------------+----------------------------+-----------------+--------------+-----------+
0: jdbc:phoenix:localhost>

0: jdbc:phoenix:localhost> CREATE TABLE company (COMPANY_ID INTEGER PRIMARY KEY, NAME VARCHAR(225));
No rows affected (1.283 seconds)
0: jdbc:phoenix:localhost> !table
+------------+--------------+-------------+---------------+----------+------------+----------------------------+-----------------+--------------+-----------+
| TABLE_CAT  | TABLE_SCHEM  | TABLE_NAME  |  TABLE_TYPE   | REMARKS  | TYPE_NAME  | SELF_REFERENCING_COL_NAME  | REF_GENERATION  | INDEX_STATE  | IMMUTABLE |
+------------+--------------+-------------+---------------+----------+------------+----------------------------+-----------------+--------------+-----------+
|            | SYSTEM       | CATALOG     | SYSTEM TABLE  |          |            |                            |                 |              | false     |
|            | SYSTEM       | FUNCTION    | SYSTEM TABLE  |          |            |                            |                 |              | false     |
|            | SYSTEM       | SEQUENCE    | SYSTEM TABLE  |          |            |                            |                 |              | false     |
|            | SYSTEM       | STATS       | SYSTEM TABLE  |          |            |                            |                 |              | false     |
|            |              | COMPANY     | TABLE         |          |            |                            |                 |              | false     |
+------------+--------------+-------------+---------------+----------+------------+----------------------------+-----------------+--------------+-----------+
0


UPSERT INTO company VALUES(1, 'Microsoft');
UPSERT INTO company VALUES(2, 'IBM');
UPSERT INTO company VALUES(3, 'Oracle');
UPSERT INTO company VALUES(4, 'Twitter');
UPSERT INTO company VALUES(5, 'Facebook');

SELECT * FROM Company;

0: jdbc:phoenix:localhost> select * from company;
+-------------+------------+
| COMPANY_ID  |    NAME    |
+-------------+------------+
| 1           | Microsoft  |
| 2           | IBM        |
| 3           | Oracle     |
| 4           | Twitter    |
| 5           | Facebook   |
+-------------+------------+
5 rows selected (0.043 seconds)

DELETE FROM company WHERE COMPANY_ID=5;

SELECT * FROM Company;
0: jdbc:phoenix:localhost> select * from company;
+-------------+------------+
| COMPANY_ID  |    NAME    |
+-------------+------------+
| 1           | Microsoft  |
| 2           | IBM        |
| 3           | Oracle     |
| 4           | Twitter    |
+-------------+------------+
4 rows selected (0.022 seconds)

CREATE TABLE stock (COMPANY_ID INTEGER PRIMARY KEY, PRICE DECIMAL(10,2));
0: jdbc:phoenix:localhost> !column stock
+------------+--------------+-------------+--------------+------------+------------+--------------+----------------+-----------------+-----------------+----+
| TABLE_CAT  | TABLE_SCHEM  | TABLE_NAME  | COLUMN_NAME  | DATA_TYPE  | TYPE_NAME  | COLUMN_SIZE  | BUFFER_LENGTH  | DECIMAL_DIGITS  | NUM_PREC_RADIX  | NU |
+------------+--------------+-------------+--------------+------------+------------+--------------+----------------+-----------------+-----------------+----+
|            |              | STOCK       | COMPANY_ID   | 4          | INTEGER    | null         | null           | null            | null            | 0  |
|            |              | STOCK       | PRICE        | 3          | DECIMAL    | 10           | null           | 2               | null            | 1  |
+------------+--------------+-------------+--------------+------------+------------+--------------+----------------+-----------------+-----------------+----+
0


UPSERT INTO stock VALUES(1, 124.9);
UPSERT INTO stock VALUES(2, 99);
UPSERT INTO stock VALUES(3, 150.9);
UPSERT INTO stock VALUES(4, 45.5);
UPSERT INTO stock VALUES(5, 120.5);
0: jdbc:phoenix:localhost> select * from stock;
+-------------+--------+
| COMPANY_ID  | PRICE  |
+-------------+--------+
| 2           | 99     |
| 3           | 150.9  |
| 4           | 45.5   |
| 5           | 120.5  |
+-------------+--------+



select s.company_id, c.name, s.price
from stock s left outer join company c on s.COMPANY_ID = c.COMPANY_ID;
0: jdbc:phoenix:localhost> select c.name, s.price from company c left outer join stock s on c.company_id = s.company_id;
+------------+----------+
|   C.NAME   | S.PRICE  |
+------------+----------+
| Microsoft  | null     |
| IBM        | 99       |
| Oracle     | 150.9    |
| Twitter    | 45.5     |
+------------+----------+

0: jdbc:phoenix:localhost> select c.name, s.price from company c right join stock s on c.company_id = s.company_id ;
+----------+----------+
|  C.NAME  | S.PRICE  |
+----------+----------+
| IBM      | 99       |
| Oracle   | 150.9    |
| Twitter  | 45.5     |
|          | 120.5    |
+----------+----------+
4 rows selected (0.051 seconds)



!quit
0: jdbc:phoenix:localhost> !quit
Closing: org.apache.phoenix.jdbc.PhoenixConnection

