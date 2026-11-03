
-- Holiday temperature and traffic comparison
SELECT
    SUBSTR(date_time, 1, 10) AS holiday_date,
    COUNT(*) AS total_records,
    ROUND(AVG(temp) - 273.15, 1) AS avg_temp_c,
    ROUND(AVG(traffic_volume), 0) AS avg_traffic
FROM traffic
WHERE SUBSTR(date_time, 1, 10) IN (
    '2015-01-01',
    '2016-01-01',
    '2017-01-01',
    '2015-09-07',
    '2016-09-05',
    '2017-09-04'
)
GROUP BY holiday_date
ORDER BY holiday_date;

