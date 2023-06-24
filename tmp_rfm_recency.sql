TRUNCATE analysis.tmp_rfm_recency;
INSERT INTO analysis.tmp_rfm_recency
SELECT user_id
	,NTILE(5) OVER (ORDER BY last_order_dt) recency
FROM (	SELECT u.id user_id
			,MAX(o.order_ts) last_order_dt
		FROM analysis.users u
		LEFT JOIN analysis.orders o 
			ON u.id = o.user_id
		LEFT JOIN analysis.orderstatuses os 
			ON o.status = os.id
		WHERE os."key" = 'Closed'
		GROUP BY u.id ) AS f;