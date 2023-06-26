TRUNCATE analysis.tmp_rfm_monetary_value;
INSERT INTO analysis.tmp_rfm_monetary_value
SELECT user_id
	,NTILE(5) OVER (ORDER BY payment_sum) monetary_value
FROM (	SELECT u.id user_id
			,COALESCE(SUM(oc.payment), 0) payment_sum
		FROM analysis.users u
		LEFT JOIN ( SELECT o.* 
				   	FROM analysis.orders o 
					LEFT JOIN analysis.orderstatuses os 
						ON o.status = os.id
					WHERE os."key" = 'Closed' ) AS oc
			ON u.id = oc.user_id
		GROUP BY u.id ) AS f