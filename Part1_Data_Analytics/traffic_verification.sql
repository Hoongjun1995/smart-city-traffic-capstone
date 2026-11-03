
-- Verify total number of records
SELECT COUNT(*) AS total_rows
FROM traffic;

-- Check first five records
SELECT *
FROM traffic
LIMIT 5;

-- Check dataset columns
PRAGMA table_info(traffic);
