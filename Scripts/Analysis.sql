🩺 Healthcare Analytics Project: Improving Clinical Quality and Reducing Readmission Risk

Comprehensive Problem Statement
Title:
"Uncovering Patterns in Patient Readmissions, Doctor Effectiveness, and Condition Severity Using SQL"
Realistic Scenario:
Hospital administrators want to reduce costly readmissions, identify doctors with best patient outcomes, and analyze condition severity patterns using internal records.
You’ve been asked to use SQL to investigate the following:

Key Investigation Areas & Business Questions
1. Readmission Risk Tracking
Question:
Which patients were readmitted within 30 days of discharge? How often is this happening for chronic conditions?
SQL Tasks:
* Use admissions with patient_id and admission/discharge dates
* Apply window functions (LAG()) to find short-term readmissions
* Join with medical_conditions to filter chronic issues like Diabetes, Hypertension

---A. Which patients were readmitted within 30 days of discharge
WITH ordered_admissions AS (
    SELECT
        admission_id,
        patient_id,
        admission_date::date AS admission_date,
        discharge_date::date AS discharge_date,
        LAG(discharge_date::date) OVER (
            PARTITION BY patient_id
            ORDER BY admission_date::date
        ) AS previous_discharge
    FROM admissions
),

readmissions_within_30_days AS (
    SELECT
        oa.admission_id,
        oa.patient_id,
        oa.admission_date,
        oa.discharge_date,
        oa.previous_discharge,
        (oa.admission_date::date - oa.previous_discharge::date) AS days_between
    FROM ordered_admissions oa
    WHERE oa.previous_discharge IS NOT NULL
      AND (oa.admission_date::date - oa.previous_discharge::date) <= 30
)SELECT * FROM readmissions_within_30_days,


---B.How often is this happening for chronic conditions?
chronic_conditions AS (
    SELECT
        rw.admission_id,
        rw.patient_id,
        rw.admission_date,
        rw.discharge_date,
        rw.days_between,
        mc.condition
    FROM readmissions_within_30_days rw
    JOIN medical_conditions mc ON rw.admission_id = mc.admission_id
    WHERE mc.condition IN ('Diabetes', 'Hypertension')
)

SELECT
    condition,
    COUNT(*) AS readmission_events,
    COUNT(DISTINCT patient_id) AS unique_patients
FROM chronic_conditions
GROUP BY condition
ORDER BY readmission_events DESC;


--CREATING A VIEW AND PUT chronic_readmissions_within_30_days TABLE IN A VIEW

CREATE OR REPLACE VIEW chronic_readmissions_within_30_days AS
WITH ordered_admissions AS (
    SELECT
        admission_id,
        patient_id,
        admission_date::date AS admission_date,
        discharge_date::date AS discharge_date,
        LAG(discharge_date::date) OVER (
            PARTITION BY patient_id
            ORDER BY admission_date::date
        ) AS previous_discharge
    FROM admissions
),

readmissions_within_30_days AS (
    SELECT
        oa.admission_id,
        oa.patient_id,
        oa.admission_date,
        oa.discharge_date,
        oa.previous_discharge,
        (oa.admission_date - oa.previous_discharge) AS days_between
    FROM ordered_admissions oa
    WHERE oa.previous_discharge IS NOT NULL
      AND (oa.admission_date - oa.previous_discharge) <= 30
),

chronic_conditions AS (
    SELECT
        rw.admission_id,
        rw.patient_id,
        rw.admission_date,
        rw.discharge_date,
        rw.days_between,
        mc.condition
    FROM readmissions_within_30_days rw
    JOIN medical_conditions mc ON rw.admission_id = mc.admission_id
    WHERE LOWER(mc.condition) IN ('diabetes', 'hypertension')
)

SELECT
    condition,
    COUNT(*) AS readmission_events,
    COUNT(DISTINCT patient_id) AS unique_patients
FROM chronic_conditions
GROUP BY condition
ORDER BY readmission_events DESC;


SELECT * FROM chronic_readmissions_within_30_days


------CREATING A VIEW AND PUT readmissions_within_30_days TABLE IN A VIEW


CREATE OR REPLACE VIEW readmissions_within_30_days AS
WITH ordered_admissions AS (
    SELECT
        admission_id,
        patient_id,
        admission_date::date AS admission_date,
        discharge_date::date AS discharge_date,
        LAG(discharge_date::date) OVER (
            PARTITION BY patient_id
            ORDER BY admission_date::date
        ) AS previous_discharge
    FROM admissions
)
SELECT
    oa.admission_id,
    oa.patient_id,
    oa.admission_date,
    oa.discharge_date,
    oa.previous_discharge,
    (oa.admission_date - oa.previous_discharge) AS days_between
FROM ordered_admissions oa
WHERE oa.previous_discharge IS NOT NULL
  AND (oa.admission_date - oa.previous_discharge) <= 30;

SELECT * FROM readmissions_within_30_days

2. Diagnostic Success Rate per Doctor
Question:
Which doctors have the highest percentage of patients who leave with only "Normal" test results?
SQL Tasks:
* Join test_results, admissions, doctors
* Group by doctor and calculate normal_count / total_tests
* Handle lowercase/dirty values (LOWER(result) = 'normal')

CREATE OR REPLACE VIEW doctor_diagnostic_success_rate AS
WITH test_with_doctors AS(
	SELECT
		d.doctor_id,
		d.name AS doctor_name,
		tr.result
	FROM test_results tr
	JOIN admissions a ON tr.admission_id = a.admission_id
	JOIN doctors d ON a.doctor_id = d.doctor_id
),
aggregated_results AS(
	SELECT 
		doctor_id,
		doctor_name,
		COUNT(*) AS total_tests,
		COUNT(*) FILTER (WHERE LOWER(result) = 'normal') AS normal_tests
	FROM test_with_doctors
	GROUP BY doctor_id, doctor_name
)
SELECT 
	doctor_id,
	doctor_name,
	total_tests,
	normal_tests,
	ROUND(100.0 * normal_tests/NULLIF(total_tests,0),2) AS normal_percentage
FROM aggregated_results
ORDER BY normal_percentage DESC;

SELECT * FROM doctor_diagnostic_success_rate



3. Length of Stay by Doctor & Condition
Question:
What’s the average hospital stay by doctor and condition?
SQL Tasks:
* Calculate DATEDIFF(discharge_date, admission_date)
* Join with doctors and medical_conditions
* Rank longest/shortest stays

CREATE OR REPLACE VIEW avg_stay_by_doctor_condition_view AS(
WITH admission_details AS(
	SELECT a.admission_id,
	d.doctor_id, d.name AS doctor_name,
	d.specialty,mc.condition,
	a.admission_date, a.discharge_date,
	(a.discharge_date::date - a.admission_date::date) AS length_of_stay
FROM admissions a
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN medical_conditions mc ON a.admission_id = mc.admission_id
),
avg_stay_by_doctor_conditions AS(
	SELECT doctor_id,doctor_name, specialty, condition,
	ROUND(AVG(length_of_stay),2) AS avg_length_of_stay,
	COUNT(*) AS case_count
	FROM admission_details
	GROUP BY doctor_id,doctor_name, specialty, condition
)
	SELECT doctor_id,
	doctor_name,
	specialty,
	condition,
	avg_length_of_stay,
	case_count
FROM avg_stay_by_doctor_conditions
ORDER BY avg_length_of_stay DESC
);

SELECT * FROM avg_stay_by_doctor_condition_view






4. Condition Recurrence Analysis
Question:
For chronic patients, how often do the same conditions reappear across multiple admissions?
SQL Tasks:
* Use COUNT(*) of condition appearances per patient
* Join medical_conditions with admissions
* Filter HAVING count > 1 for same condition

CREATE OR REPLACE VIEW chronic_condition_recurrence AS
SELECT
    a.patient_id,
    mc.condition,
    COUNT(*) AS recurrence_count
FROM medical_conditions mc
JOIN admissions a ON mc.admission_id = a.admission_id
WHERE mc.condition IN ('Diabetes', 'Hypertension') -- Add more chronic conditions as needed
GROUP BY a.patient_id, mc.condition
HAVING COUNT(*) > 1;

SELECT * FROM chronic_condition_recurrence


5. Dirty Data Tracking
Question:
How much data is missing or unusable, such as NULL test results, unknown genders, or blank discharge dates?
SQL Tasks:
* Use IS NULL or = '' in filters
* Count missing values in patients, test_results, admissions
* Generate a "Data Quality Score" per table

1. Check for NULL or Blank in Critical Fields

🔸 Missing Test Results
SELECT 
  COUNT(*) AS missing_test_results
FROM test_results
WHERE result IS NULL OR TRIM(result) = '';


🔸 Unknown Genders
SELECT 
  COUNT(*) AS unknown_gender_count
FROM patients
WHERE gender IS NULL 
   OR TRIM(gender) = '' 
   OR LOWER(gender) IN ('unknown', 'other', 'unspecified');


🔸 Blank or Missing Discharge Dates

SELECT 
  COUNT(*) AS missing_discharge_dates
FROM admissions
WHERE discharge_date IS NULL OR TRIM(discharge_date::text) = '';


11. Data Quality Score Per Table

CREATE OR REPLACE VIEW data_quality_summary AS
SELECT 'test_results' AS table_name,
       COUNT(*) AS total_rows,
       SUM(CASE WHEN result IS NULL OR TRIM(result) = '' THEN 1 ELSE 0 END) AS missing_count,
       ROUND(100 * SUM(CASE WHEN result IS NOT NULL AND TRIM(result) != '' THEN 1 ELSE 0 END)::decimal / COUNT(*), 2) AS quality_score
FROM test_results

UNION ALL

SELECT 'patients' AS table_name,
       COUNT(*) AS total_rows,
       SUM(CASE WHEN gender IS NULL OR TRIM(gender) = '' OR LOWER(gender) IN ('unknown', 'other', 'unspecified') THEN 1 ELSE 0 END) AS missing_count,
       ROUND(100 * SUM(CASE WHEN gender IS NOT NULL AND TRIM(gender) != '' AND LOWER(gender) NOT IN ('unknown', 'other', 'unspecified') THEN 1 ELSE 0 END)::decimal / COUNT(*), 2) AS quality_score
FROM patients

UNION ALL

SELECT 'admissions' AS table_name,
       COUNT(*) AS total_rows,
       SUM(CASE WHEN discharge_date IS NULL OR TRIM(discharge_date::text) = '' THEN 1 ELSE 0 END) AS missing_count,
       ROUND(100 * SUM(CASE WHEN discharge_date IS NOT NULL AND TRIM(discharge_date::text) != '' THEN 1 ELSE 0 END)::decimal / COUNT(*), 2) AS quality_score
FROM admissions;

Select * from data_quality_summary



OUTPUT TABLES:
SELECT * FROM readmissions_within_30_days
SELECT * FROM doctor_diagnostic_success_rate
SELECT * FROM avg_stay_by_doctor_condition_view
SELECT * FROM chronic_condition_recurrence
Select * from data_quality_summary












Sample Output Tables You Could Generate with SQL
* readmission_summary
* doctor_success_rates
* condition_recurrence
* data_quality_flags

 Project Goals
* Improve patient outcomes by identifying readmission triggers
* Measure doctor performance objectively
* Surface chronic patient condition patterns
* Monitor and improve data quality
