CREATE OR REPLACE VIEW analysis.orders AS
SELECT o.order_id
	,osl.dttm order_ts
	,o.user_id
	,o.payment
	,osl.status_id status
FROM production.orders o
LEFT JOIN (	SELECT *, ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY dttm desc) rn
			FROM production.orderstatuslog ) osl 
	ON o.order_id = osl.order_id
		AND osl.rn = 1