-- ============================================================
-- Hospital Data Analysis — Core Queries
-- ============================================================

-- 1. What is the total patient volume handled across all hospitals?
SELECT SUM(patients_count) AS total_patients
FROM hospital_records;

-- 2. Which hospitals are running with the most/fewest doctors on average?
--    (staffing comparison across the network)
SELECT hospital_name, ROUND(AVG(doctors_count), 2) AS avg_doctors
FROM hospital_records
GROUP BY hospital_name
ORDER BY avg_doctors DESC;

-- 3. Which departments should be prioritized for staffing/resource
--    allocation, based on total patient load?
SELECT department, SUM(patients_count) AS total_patients
FROM hospital_records
GROUP BY department
ORDER BY total_patients DESC
LIMIT 3;

-- 4. Which hospital is generating the highest total medical expenses?
SELECT hospital_name, ROUND(SUM(medical_expenses), 2) AS total_expenses
FROM hospital_records
GROUP BY hospital_name
ORDER BY total_expenses DESC
LIMIT 1;

-- 5. Which hospitals cost the most per patient-day of care?
--    NOTE: excludes rows with a negative stay length (see 03_data_quality.sql)
SELECT hospital_name,
       ROUND(SUM(medical_expenses), 2) AS total_expenses,
       SUM(discharge_date - admission_date) AS total_stay_days,
       ROUND(SUM(medical_expenses) / NULLIF(SUM(discharge_date - admission_date), 0), 2) AS avg_expense_per_day
FROM hospital_records
WHERE discharge_date - admission_date >= 0
GROUP BY hospital_name
ORDER BY avg_expense_per_day DESC;

-- 6. Which patient had the longest hospital stay?
SELECT hospital_name, department, admission_date, discharge_date,
       (discharge_date - admission_date) AS stay_days
FROM hospital_records
WHERE discharge_date - admission_date >= 0
ORDER BY stay_days DESC
LIMIT 1;

-- 7. How is patient volume distributed across cities?
SELECT location AS city, SUM(patients_count) AS total_patients
FROM hospital_records
GROUP BY location
ORDER BY total_patients DESC;

-- 8. Which departments have the longest average patient stay
--    (a proxy for case complexity / recovery time)?
SELECT department, ROUND(AVG(discharge_date - admission_date), 2) AS avg_stay_days
FROM hospital_records
WHERE discharge_date - admission_date >= 0
GROUP BY department
ORDER BY avg_stay_days DESC;

-- 9. Which department has the lowest patient volume
--    (candidate for consolidation or reduced staffing)?
SELECT department, SUM(patients_count) AS total_patients
FROM hospital_records
GROUP BY department
ORDER BY total_patients ASC
LIMIT 1;

-- 10. How do medical expenses trend month over month?
SELECT TO_CHAR(admission_date, 'YYYY-MM') AS month,
       ROUND(SUM(medical_expenses), 2) AS total_expenses
FROM hospital_records
GROUP BY TO_CHAR(admission_date, 'YYYY-MM')
ORDER BY month;
