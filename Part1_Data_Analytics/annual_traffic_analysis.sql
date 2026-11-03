
-- Annual traffic volume from 2012 to 2017
SELECT
    SUBSTR(date_time, 1, 4) AS year,
    COUNT(*) AS total_records,
    SUM(traffic_volume) AS total_traffic
FROM traffic
WHERE SUBSTR(date_time, 1, 4) BETWEEN '2012' AND '2017'
GROUP BY year
ORDER BY year;

-- Year-on-year traffic volume changes
WITH yearly AS (
    SELECT
        SUBSTR(date_time, 1, 4) AS year,
        COUNT(*) AS total_records,
        SUM(traffic_volume) AS total_traffic
    FROM traffic
    WHERE SUBSTR(date_time, 1, 4)
          BETWEEN '2012' AND '2017'
    GROUP BY year
)
SELECT
    year,
    total_records,
    total_traffic,
    total_traffic - LAG(total_traffic)
        OVER (ORDER BY year) AS yearly_change
FROM yearly
ORDER BY year;




