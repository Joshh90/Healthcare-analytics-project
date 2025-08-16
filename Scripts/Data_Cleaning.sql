
--DATA PROFILING
--CHECKING FOR NULLS

--Finding number of rows in doctors table
select * from doctors
--We have 5000 rows in doctors

SELECT SUM(CASE WHEN doctor_id IS NULL THEN 1 ELSE 0 END) AS nulls_in_doctor_id,
SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS nulls_in_name,
SUM(CASE WHEN specialty IS NULL THEN 1 ELSE 0 END) AS nulls_in_speciality
FROM doctors;
--We have 0 nulls in other columns. We have 1437 nulls in doctors table

--Finding number of rows in admissions table(1000000 rows)
select * from admissions;

SELECT SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) AS nulls_in_patient_id,
SUM(CASE WHEN doctor_id IS NULL THEN 1 ELSE 0 END) AS nulls_in_doctor_id,
SUM(CASE WHEN admission_date IS NULL THEN 1 ELSE 0 END) AS nulls_in_admission_date,
SUM(CASE WHEN discharge_date IS NULL THEN 1 ELSE 0 END) AS nulls_in_discharge_date
FROM admissions;

--We have 0  nulls in all columns in admissions table, except 666486 nulls in discharge_date column 

--Finding number of rows in medical_conditions table(1000000)
select * from medical_conditions;

--Finding number of nulls in condition_id column of medical_conditions table(0 nulls)
SELECT SUM(CASE WHEN condition_id IS NULL THEN 1 ELSE 0 END) AS nulls_in_condition_id,
SUM(CASE WHEN admission_id IS NULL THEN 1 ELSE 0 END) AS nulls_in_admission_id,
SUM(CASE WHEN condition IS NULL THEN 1 ELSE 0 END) AS nulls_in_condition
FROM medical_conditions;

--We have 0  nulls in all columns in admissions table, except 286371 nulls in discharge_date column 

--Finding number of rows in patients table(250000)
select * from patients;

SELECT SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) AS nulls_in_patients_id,
SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS nulls_in_name,
SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS nulls_in_age,
SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS null_in_gender
FROM patients

--We have 0  nulls in patient_id and name column. We have 124807 nulls in age column and 99740 nulls in gender column


--Finding number of rows in test_results table(1000000)
select * from test_results;

SELECT SUM(CASE WHEN test_result_id IS NULL THEN 1 ELSE 0 END) AS nulls_in_test_result_id,
SUM(CASE WHEN admission_id IS NULL THEN 1 ELSE 0 END) AS nulls_in_test_admission_id,
SUM(CASE WHEN test_name IS NULL THEN 1 ELSE 0 END) AS nulls_in_test_name,
SUM(CASE WHEN result IS NULL THEN 1 ELSE 0 END) AS nulls_in_result
FROM test_results
--We have 0 nulls in all column except result column that has 250166 nulls


--CHECKING % OF NULLS
--admissions table
SELECT 'admission_id' AS admission_id, 
ROUND((COUNT(*) - COUNT(admission_id)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM admissions

UNION ALL

SELECT 'patient_id' AS patient_id, 
ROUND((COUNT(*) - COUNT(patient_id)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM admissions

UNION ALL

SELECT 'doctor_id' AS doctor_id, 
ROUND((COUNT(*) - COUNT(doctor_id)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM admissions

UNION ALL

SELECT 'admission_date' AS admission_date, 
ROUND((COUNT(*) - COUNT(admission_date)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM admissions

UNION ALL

SELECT 'discharge_date' AS discharge_date, 
ROUND((COUNT(*) - COUNT(discharge_date)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM admissions
---% OF NULLS IN DISCHARGE DATE COLUMN OF ADMISSIONS TABLE IS 66.65%. THE REST ARE 0


--doctors table
SELECT 'doctor_id' AS doctor_id, 
ROUND((COUNT(*) - COUNT(doctor_id)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM doctors

UNION ALL

SELECT 'name' AS name, 
ROUND((COUNT(*) - COUNT(name)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM doctors

UNION ALL

SELECT 'specialty' AS specialty, 
ROUND((COUNT(*) - COUNT(specialty)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM doctors
---% OF NULLS IN SPECIALTY COLUMN OF DOCTORS TABLE IS 28.74%. THE REST ARE 0


--medical conditions table
SELECT 'condition_id' AS condition_id, 
ROUND((COUNT(*) - COUNT(condition_id)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM medical_conditions

UNION ALL

SELECT 'admission_id' AS admission_id, 
ROUND((COUNT(*) - COUNT(admission_id)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM medical_conditions

UNION ALL

SELECT 'condition' AS condition, 
ROUND((COUNT(*) - COUNT(condition)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM medical_conditions
---% OF NULLS IN CONDITION COLUMN OF MEDICAL_CONDITIONS TABLE IS 28.74%. THE REST ARE 0


--patients table
SELECT 'patient_id' AS patient_id, 
ROUND((COUNT(*) - COUNT(patient_id)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM patients

UNION ALL

SELECT 'name' AS name, 
ROUND((COUNT(*) - COUNT(name)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM patients

UNION ALL

SELECT 'age' AS age, 
ROUND((COUNT(*) - COUNT(age)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM patients

UNION ALL

SELECT 'gender' AS gender, 
ROUND((COUNT(*) - COUNT(gender)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM patients
---% OF NULLS IN GENDER COLUMN OF MEDICAL_CONDITIONS TABLE IS 39.90%. AGE COLUMN HAS 49.92% OF NULLS. THE REST ARE 0


--test_results table
SELECT 'test_result_id' AS test_result_id, 
ROUND((COUNT(*) - COUNT(test_result_id)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM test_results

UNION ALL

SELECT 'admission_id' AS admission_id, 
ROUND((COUNT(*) - COUNT(admission_id)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM test_results

UNION ALL

SELECT 'test_name' AS test_name, 
ROUND((COUNT(*) - COUNT(test_name)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM test_results

UNION ALL

SELECT 'result' AS result, 
ROUND((COUNT(*) - COUNT(result)) * 100.0/ COUNT(*),2) AS percentage_of_nulls
FROM test_results

---% OF NULLS IN RESULT COLUMN OF MEDICAL_CONDITIONS TABLE IS 25.02%. THE REST ARE 0


--CHECKING FOR DUPLICATES
SELECT admission_id, COUNT(*) AS cnt
FROM admissions
GROUP BY 1
HAVING COUNT(*) > 1;

--0 DUPLICATE IN ADMISSIONS TABLE
WITH ranked_users AS (
  SELECT *, 
    ROW_NUMBER() OVER(
      PARTITION BY admission_id,patient_id, doctor_id, admission_date, discharge_date
	  ) AS rowN
  FROM admissions
)
SELECT *
FROM ranked_users
WHERE rowN > 1;

--0 DUPLICATE IN ADMISSIONS TABLE

WITH ranked_users AS (
  SELECT *, 
    ROW_NUMBER() OVER(
      PARTITION BY doctor_id,name, specialty
	  ) AS rowN
  FROM doctors
)
SELECT *
FROM ranked_users
WHERE rowN > 1;

--0 DUPLICATE IN DOCTORS TABLE

WITH ranked_users AS (
  SELECT *, 
    ROW_NUMBER() OVER(
      PARTITION BY condition_id ,admission_id, condition
	  ) AS rowN
  FROM medical_conditions
)
SELECT *
FROM ranked_users
WHERE rowN > 1;

--0 DUPLICATE IN MEDICAL_CONDITIONS TABLE


WITH ranked_users AS (
  SELECT *, 
    ROW_NUMBER() OVER(
      PARTITION BY patient_id ,name, age, gender
	  ) AS rowN
  FROM patients
)
SELECT *
FROM ranked_users
WHERE rowN > 1;

--0 DUPLICATE IN PATIENTS TABLE

WITH ranked_users AS (
  SELECT *, 
    ROW_NUMBER() OVER(
      PARTITION BY test_result_id ,admission_id, test_name, result
	  ) AS rowN
  FROM test_results
)
SELECT *
FROM ranked_users
WHERE rowN > 1;

--0 DUPLICATE IN TEST RESULT TABLE
SELECT admission_id, COUNT(*) AS cnt
FROM admissions
GROUP BY 1
HAVING COUNT(*) > 1;

--CHECKING FOR DUPLICATES
SELECT doctor_id, COUNT(*) AS cnt
FROM doctors
GROUP BY 1
HAVING COUNT(*) > 1;

SELECT condition_id, COUNT(*) AS cnt
FROM medical_conditions
GROUP BY 1
HAVING COUNT(*) > 1;

SELECT patient_id, COUNT(*) AS cnt
FROM patients
GROUP BY 1
HAVING COUNT(*) > 1;

SELECT test_result_id, COUNT(*) AS cnt
FROM test_results
GROUP BY 1
HAVING COUNT(*) > 1;

ALTER TABLE medical_conditions 
ALTER COLUMN condition DROP NOT NULL;

--CHECKING FOR DATA TYPES
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'admissions'

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'medical_conditions'

ALTER TABLE admissions
ALTER COLUMN admission_id TYPE INTEGER,
ALTER COLUMN admission_id SET NOT NULL;

Select name from doctors


--CHECKING FOR TRAILING AND LEADING SPACES IN COLUMNS THAT HAS NAMES

--DOCTORS TABLE
SELECT name, LENGTH(name) Original_length, LENGTH(Trim(name)) Trimmed_length, Trim(name) cleaned_name
FROM doctors
WHERE LENGTH(name) <>LENGTH(Trim(name));
--The output is empty

--PATIENTS TABLE
SELECT name, LENGTH(name) Original_length, LENGTH(Trim(name)) Trimmed_length, Trim(name) cleaned_name
FROM patients
WHERE LENGTH(name) <> LENGTH(Trim(name));

--The output shows that there is no trailing space

--CHECKING FOR INVALID NUMBERS
--Standard patient age range is 0-100
SELECT patient_id, name, age
FROM patients
WHERE (age ~ '^\d+$')
AND (CAST(age AS INTEGER) < 0 OR CAST(age AS INTEGER) >100);

SELECT DISTINCT age
FROM patients
WHERE age !~ '^\d+$';
--A patient age was 'Unknown'.Then, we updated it to a NULL

UPDATE patients
SET age = NULL
WHERE age !~ '^\d+$';

ALTER TABLE patients
ALTER COLUMN age TYPE integer USING age::integer;

SELECT *
FROM patients
WHERE age::text !~ '^\d+$';

--CHECKING FOR INVALID DATE RANGE
SELECT * FROM admissions
WHERE discharge_date <= admission_date
--The output should be empty. Since discharge date should be greater than admission_date

--CHECKING FOR DISTINCT SPECIALTY IN DOCTORS TABLE
SELECT Distinct specialty from doctors
--There is no need for change based on the output

--CHECKING FOR DISTINCT CONDITION IN MEDICAL CONDITION TABLE
Select Distinct condition
from medical_conditions
--We have a null medical condition. We are modifying to N/A
UPDATE medical_conditions
SET condition =
CASE WHEN condition is null THEN 'N/A'
ELSE condition 	END;
--Now, the condition that is null is updated to 'N/A'


--CHECKING FOR DISTINCT GENDER FROM PATIENT TABLE
Select Distinct gender
from patients
--We have 'F', 'M', Other and null. We can keep it as it is.


--CHECKING FOR DISTINCT test_name FROM TEST RESULTS TABLE
Select Distinct test_name
from test_results
--The outputs are distinct. We need to keep it as it is


--CHECKING FOR DISTINCT RESULT FROM TEST RESULTS TABLE
Select Distinct result
from test_results
--The test_results is not standardized. We need to standardize it.

--STANDARDIZING TEST RESULTS IN TEST RESULT TABLE
UPDATE test_results
SET result =
CASE WHEN result = 'ABNORMAL' THEN 'Abnormal'
WHEN result = 'normal' THEN 'Normal'
WHEN result = 'Inconclusive' THEN 'Inconclusive'
WHEN result = 'N/A' THEN 'N/A'
WHEN result is null THEN 'N/A'
ELSE result END;


