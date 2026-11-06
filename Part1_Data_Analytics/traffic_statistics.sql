
-- Task 2.1: Traffic volume statistics
WITH ordered AS (
    SELECT
        traffic_volume,
        ROW_NUMBER() OVER (
            ORDER BY traffic_volume
        ) AS rn,
        COUNT(*) OVER () AS n
    FROM traffic
)
SELECT
    ROUND(AVG(traffic_volume), 2) AS mean_traffic,

    (SELECT AVG(traffic_volume)
     FROM ordered
     WHERE rn IN ((n + 1) / 2, (n + 2) / 2)
    ) AS median_traffic,

    ROUND(
        SQRT(AVG(traffic_volume * traffic_volume * 1.0)
        - AVG(traffic_volume) * AVG(traffic_volume)), 2
    ) AS std_deviation,

    ROUND(
        AVG(traffic_volume * traffic_volume * 1.0)
        - AVG(traffic_volume) * AVG(traffic_volume), 2
    ) AS variance,

    MAX(traffic_volume) - MIN(traffic_volume)
        AS traffic_range
FROM traffic;


-- Task 2.2: Correlation between temperature and traffic

SELECT
    ROUND(
        (AVG(temp * traffic_volume)
        - AVG(temp) * AVG(traffic_volume))
        /
        SQRT(
            (AVG(temp * temp) - AVG(temp) * AVG(temp))
            *
            (AVG(traffic_volume * traffic_volume)
            - AVG(traffic_volume) * AVG(traffic_volume))
        ), 4
    ) AS correlation
FROM traffic;

