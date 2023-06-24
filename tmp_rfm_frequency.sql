TRUNCATE analysis.tmp_rfm_frequency;
INSERT INTO analysis.tmp_rfm_frequency
SELECT user_id
	,NTILE(5) OVER (ORDER BY order_count) frequency
FROM (	SELECT u.id user_id
			,COUNT(o.order_ts) order_count
		FROM analysis.users u
		LEFT JOIN analysis.orders o 
			ON u.id = o.user_id
		LEFT JOIN analysis.orderstatuses os 
			ON o.status = os.id
		WHERE os."key" = 'Closed'
		GROUP BY u.id ) AS f