-- Hospital Data Analysis — Schema
-- Database: PostgreSQL (adjust types slightly if using MySQL/SQLite)

DROP TABLE IF EXISTS hospital_records;

CREATE TABLE hospital_records (
    hospital_name      VARCHAR(50),
    location            VARCHAR(50),
    department          VARCHAR(30),
    doctors_count        INT,
    patients_count        INT,
    admission_date        DATE,
    discharge_date        DATE,
    medical_expenses       NUMERIC(10,2)
);

-- Load data (psql example):
-- \copy hospital_records FROM 'data/hospital_data.csv' WITH (FORMAT csv, HEADER true);
