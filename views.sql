CREATE OR REPLACE VIEW analysis.users AS 
SELECT id
	,"name"
	,login
FROM production.users;
CREATE OR REPLACE VIEW analysis.orders AS
SELECT order_id
	,order_ts
	,user_id
	,payment
	,status
FROM production.orders o;
CREATE OR REPLACE VIEW analysis.orderitems AS
SELECT id
	,order_id
	,product_id
	,price
	,quantity
FROM production.orderitems o;
CREATE OR REPLACE VIEW analysis.products AS
SELECT id
	,"name"
	,price
FROM production.products p;
CREATE OR REPLACE VIEW analysis.orderstatuses AS
SELECT id
	,"key"
FROM production.orderstatuses o;