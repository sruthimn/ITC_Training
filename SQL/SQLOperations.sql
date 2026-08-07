SELECT DISTINCT order_status FROM ORDERS;

SELECT * FROM ORDERS WHERE ORDER_STATUS = 'pending';

SELECT * FROM CUSTOMERS ORDER BY CUSTOMER_NAME DESC;

SELECT * FROM employees WHERE department = 'Sales' AND salary < 70000;

SELECT * FROM ORDERS WHERE Order_Status = 'pending' OR Order_Date <'2024-07-01';

SELECT * FROM ORDERS WHERE  Order_Date NOT BETWEEN '2024-07-01' AND '2024-09-01';

UPDATE ORDERS SET LASTUPDATEDDATE= current_date() WHERE Order_id < 1005;

SELECT  * FROM ORDERS WHERE LastUpdatedDate IS NOT NULL;
/*
==========================DELETE==================================================
*/
SELECT * FROM customers WHERE EMAIL NOT LIKE '%@%';
DELETE FROM customers WHERE EMAIL NOT LIKE '%@%';
SELECT * FROM customers WHERE EMAIL NOT LIKE '%@%';
/*
==========================TRUNCATE==================================================
*/
SELECT * FROM lookup_flags;

truncate lookup_flags;
SELECT * FROM lookup_flags;

/*
==========================DROP==================================================
*/
DROP table lookup_flags;
SELECT * FROM lookup_flags;

/*
==========================AGGREGATE FUNCTIONS==================================================
*/

##COUNT
SELECT CITY, count(*) AS Customer_Count FROM customers group by CITY;

##HAVING
SELECT CITY, count(*) AS Customer_Count FROM customers group by CITY HAVING COUNT(*)> 1;

##Total amount per order
SELECT ORDER_ID,SUM(UNIT_PRICE) FROM ORDER_ITEMS GROUP BY ORDER_ID;

##Average 
SELECT ORDER_ID,avg(QUANTITY) FROM ORDER_ITEMS GROUP BY ORDER_ID;

##MAX
SELECT MAX(UNIT_PRICE) FROM ORDER_ITEMS;
##MIN
SELECT MIN(UNIT_PRICE) FROM ORDER_ITEMS;



