Download hbase client phoenix from http://apache.forsale.plus/phoenix/apache-phoenix-4.14.0-HBase-1.4/bin/

 gunzip apache-phoenix-4.14.0-HBase-1.4-bin.tar.gz

 tar xvf apache-phoenix-4.14.0-HBase-1.4-bin.tar

--Run sqlline.py localhost



CREATE TABLE company (COMPANY_ID INTEGER PRIMARY KEY, NAME VARCHAR(225));

!tables

UPSERT INTO company VALUES(1, 'Microsoft');
UPSERT INTO company VALUES(2, 'IBM');
UPSERT INTO company VALUES(3, 'Oracle');
UPSERT INTO company VALUES(4, 'Twitter');
UPSERT INTO company VALUES(5, 'Facebook');

SELECT * FROM Company;

DELETE FROM company WHERE COMPANY_ID=5;

SELECT * FROM Company;

CREATE TABLE stock (COMPANY_ID INTEGER PRIMARY KEY, PRICE DECIMAL(10,2));
UPSERT INTO stock VALUES(1, 124.9);
UPSERT INTO stock VALUES(2, 99);
UPSERT INTO stock VALUES(3, 150.9);
UPSERT INTO stock VALUES(4, 45.5);
UPSERT INTO stock VALUES(5, 120.5);

select s.company_id, c.name, s.price
from stock s left outer join company c on s.COMPANY_ID = c.COMPANY_ID;

!quit