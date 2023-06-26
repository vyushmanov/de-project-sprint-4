TRUNCATE analysis.tmp_rfm_recency;
INSERT INTO analysis.tmp_rfm_recency
SELECT user_id
	,NTILE(5) OVER (ORDER BY last_order_dt) recency
FROM (	SELECT u.id user_id
			,COALESCE(MAX(oc.order_ts), (SELECT MIN(order_ts) FROM analysis.orders)) last_order_dt
		FROM analysis.users u
		LEFT JOIN ( SELECT o.* 
				   	FROM analysis.orders o 
					LEFT JOIN analysis.orderstatuses os 
						ON o.status = os.id
					WHERE os."key" = 'Closed' ) AS oc
			ON u.id = oc.user_id
		GROUP BY u.id ) AS f