TRUNCATE analysis.dm_rfm_segments;
INSERT INTO analysis.dm_rfm_segments
SELECT COALESCE(r.user_id,f.user_id,m.user_id) user_id
	,r.recency recency
	,f.frequency frequency
	,m.monetary_value monetary_value
FROM analysis.tmp_rfm_recency r
FULL JOIN analysis.tmp_rfm_frequency f
	ON r.user_id = f.user_id
FULL JOIN analysis.tmp_rfm_monetary_value m
	ON r.user_id = m.user_id

user_id recency frequency monetary_value
0	1	3	4
1	4	3	3
2	2	3	5
3	2	3	3
4	4	3	3
5	5	5	5
6	1	3	5
7	4	2	2
8	1	1	3
9	1	2	2
10	3	5	2