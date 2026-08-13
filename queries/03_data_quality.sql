-- ============================================================
-- Data Quality Check
-- ============================================================
-- The raw dataset contains 26 of 100 records where discharge_date
-- is EARLIER than admission_date — a data entry inconsistency.
-- Left unhandled, this produces incorrect (and sometimes negative)
-- results for any stay-length or per-day-expense calculation.
--
-- This check was used to decide: queries 5, 6, 8, and 11-13 (any
-- query touching stay length) exclude these rows via
-- `WHERE discharge_date - admission_date >= 0`.

SELECT COUNT(*) AS invalid_stay_rows
FROM hospital_records
WHERE discharge_date - admission_date < 0;
-- Result: 26 rows

SELECT hospital_name, COUNT(*) AS invalid_rows
FROM hospital_records
WHERE discharge_date - admission_date < 0
GROUP BY hospital_name
ORDER BY invalid_rows DESC;
