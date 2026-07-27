WITH CTE AS(
SELECT 
		*
		,ROW_NUMBER() OVER(PARTITION BY ORDER_ID ) AS RN
 FROM order_items)
 SELECT ORDER_ID FROM CTE WHERE RN >1;
 
SELECT 
		*
		,rank() OVER(order by salary desc) AS RN
 FROM employees;
 
 SELECT 
		*
		,dense_rank() OVER(order by salary desc) AS RN
 FROM employees;
 
 SELECT *,
		MAX(UNIT_PRICE) OVER (PARTITION BY O.ORDER_ID) AS max,
        MIN(UNIT_PRICE) OVER (PARTITION BY O.ORDER_ID) MIN,
        SUM(UNIT_PRICE) OVER (PARTITION BY O.ORDER_ID) AS SUM,
        AVG(UNIT_PRICE) OVER (PARTITION BY O.ORDER_ID) AS AVG
 FROM 
 ORDER_ITEMS O;

SELECT 
    customer_id,
    order_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_date,
    LEAD(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_order_date
FROM orders;

DELIMITER //

CREATE PROCEDURE GetCustomerOrders(IN cust_id INT)
BEGIN
    SELECT order_id, order_date, order_status
    FROM orders
    WHERE customer_id = cust_id;
END //

DELIMITER ;
CALL GetCustomerOrders(1);

DELIMITER //

CREATE TRIGGER trg_update_order_items_date
BEFORE UPDATE ON order_items
FOR EACH ROW
BEGIN
    SET NEW.LastUpdatedDate = CURRENT_DATE();
END //

DELIMITER ;
UPDATE order_items SET quantity = 3 WHERE order_item_id = 1;
SELECT * FROM order_items WHERE order_item_id = 1;