# Hospital Network Data  Analysis  (SQL):-

A SQL-based analysis of patient volume, staffing, and medical expenses across a 10-hospital network, built on a 100-record dataset spanning 10 cities and 10 departments.

## What this project does:-

- Loads hospital operations data (patients, doctors, admissions, discharges, expenses) into a relational schema
- Answers the 10 core business questions from the source assignment using aggregation, grouping, and date arithmetic
- Identifies and corrects a real **data quality issue** (26% of records had an invalid discharge/admission date pair) that would otherwise have produced misleading results for 3 of the 10 queries

## Tech stack:-

`SQL (PostgreSQL syntax)` · relational schema design · aggregation & grouping ·  data quality auditing

## Project structure:-

```
hospital-sql-project/
├── README.md                — this file
├── schema.sql                — table definition
├── insights.md                — key findings, in plain English
├── data/
│   └── hospital_data.csv        — source dataset
└── queries/
    ├── 01_core_analysis.sql     — the 10 core assignment questions
    └── 03_data_quality.sql      — detecting and documenting bad records
```

## Sample  finding:-

Naively calculating "average medical expense per day of stay" per hospital ranks **City Hospital** and **Heritage Hospital** as the most expensive — but only because ~26% of records have a discharge date earlier than the admission date, producing negative stay lengths that distort the ratio. After filtering those rows out, **Fortis Care** is actually the highest at ~₹1,081/patient-day. See `insights.md` for the full breakdown.       

## How to run:-

1. Create a PostgreSQL database and run `schema.sql`.
2. Load `data/hospital_data.csv` into the `hospital_records` table (see the `\copy` command commented at the bottom of `schema.sql`).
3. Run `queries/01_core_analysis.sql` for the 10 core questions, `queries/03_data_quality.sql` to reproduce the data quality check that 3 of those queries depend on.

## Why this exists

Built from a SQL practice assignment (30-Day SQL Micro Course), taken a step further with a genuine data-quality audit — checking whether the raw data could be trusted before using it to answer the assignment's questions, rather than accepting the numbers at face value.
