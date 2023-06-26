TRUNCATE analysis.tmp_rfm_frequency;
INSERT INTO analysis.tmp_rfm_frequency
SELECT user_id
	,NTILE(5) OVER (ORDER BY order_count) frequency
FROM (	SELECT u.id user_id
			,COALESCE(COUNT(distinct oc.order_ts), 0) order_count
		FROM analysis.users u
		LEFT JOIN ( SELECT o.* 
				   	FROM analysis.orders o 
					LEFT JOIN analysis.orderstatuses os 
						ON o.status = os.id
					WHERE os."key" = 'Closed' ) AS oc
			ON u.id = oc.user_id
		GROUP BY u.id ) AS f