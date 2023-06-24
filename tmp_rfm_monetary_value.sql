TRUNCATE analysis.tmp_rfm_monetary_value;
INSERT INTO analysis.tmp_rfm_monetary_value
SELECT user_id
	,NTILE(5) OVER (ORDER BY payment_sum) monetary_value
FROM (	SELECT u.id user_id
			,SUM(o.payment) payment_sum
		FROM analysis.users u
		LEFT JOIN analysis.orders o 
			ON u.id = o.user_id
		LEFT JOIN analysis.orderstatuses os 
			ON o.status = os.id
		WHERE os."key" = 'Closed'
		GROUP BY u.id ) AS f