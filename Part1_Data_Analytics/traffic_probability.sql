
-- Task 3.1: Basic Probability Analysis

SELECT
    ROUND(
        AVG(CASE WHEN traffic_volume > 5500
            THEN 1.0 ELSE 0 END), 4
    ) AS p_congestion,

    ROUND(
        AVG(CASE WHEN weather_main = 'Clear'
            THEN 1.0 ELSE 0 END), 4
    ) AS p_clear_weather,

    ROUND(
        AVG(CASE WHEN traffic_volume > 5500
            AND weather_main = 'Clear'
            THEN 1.0 ELSE 0 END), 4
    ) AS p_congestion_and_clear

FROM traffic;



-- Task 3.2: Conditional Probability

SELECT
    ROUND(
        AVG(CASE WHEN weather_main = 'Clear'
            THEN 1.0 ELSE 0 END), 4
    ) AS p_clear_given_congestion,

    ROUND(
        AVG(CASE WHEN temp > 292
            THEN 1.0 ELSE 0 END), 4
    ) AS p_high_temp_given_congestion

FROM traffic
WHERE traffic_volume > 5500;


-- Task 3.2: Independence Test

SELECT
    ROUND(
        AVG(CASE WHEN traffic_volume > 5500
            AND weather_main = 'Clear'
            THEN 1.0 ELSE 0 END), 4
    ) AS p_both,

    ROUND(
        AVG(CASE WHEN traffic_volume > 5500
            THEN 1.0 ELSE 0 END)
        *
        AVG(CASE WHEN weather_main = 'Clear'
            THEN 1.0 ELSE 0 END), 4
    ) AS p_if_independent

FROM traffic;



-- Task 3.2: Odds Ratio (Clear vs Cloudy)

WITH counts AS (
    SELECT
        SUM(CASE WHEN weather_main = 'Clear'
            AND traffic_volume > 5500
            THEN 1 ELSE 0 END) AS clear_congested,

        SUM(CASE WHEN weather_main = 'Clear'
            AND traffic_volume <= 5500
            THEN 1 ELSE 0 END) AS clear_not_congested,

        SUM(CASE WHEN weather_main = 'Clouds'
            AND traffic_volume > 5500
            THEN 1 ELSE 0 END) AS cloudy_congested,

        SUM(CASE WHEN weather_main = 'Clouds'
            AND traffic_volume <= 5500
            THEN 1 ELSE 0 END) AS cloudy_not_congested
    FROM traffic
)
SELECT
    ROUND(
        1.0 * clear_congested * cloudy_not_congested
        / NULLIF(clear_not_congested * cloudy_congested, 0),
        4
    ) AS odds_ratio
FROM counts;

