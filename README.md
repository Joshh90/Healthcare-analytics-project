#  🏥 Healthcare-analytics-project
Uncovering Patterns in Patient Readmissions, Doctor Effectiveness, and Condition Severity Using SQL 

## 📌 Overview  
This project simulates a **Healthcare Analytics System** using synthetic data.  
It is designed to demonstrate **SQL problem-solving**, **data quality tracking**, and **Tableau dashboards** for real-world healthcare insights.  

The dataset is generated with Python (`faker` library) and consists of multiple related tables such as **patients, admissions, doctors, medical conditions, and test results**.  

---

## Database Schema  

### **Tables**
- **Patients** → `patient_id, name, age, gender`  
- **Admissions** → `admission_id, patient_id, doctor_id, admission_date, discharge_date`  
- **Doctors** → `medical_conditions, patients, test_results`  
- **Medical_Conditions** → `condition_id, admission_id, condition`  
- **Test_Results** → `test_result_id, admission_id, test_name, result`  

---

## 🔍 Problem Statements Solved  

1. **Readmission Risk Tracking** – Patients readmitted within 30 days. The total number of re-admission was 167,076. 
2. **Diagnostic Success Rate per Doctor** – Doctors with highest % of “Normal” results. For example, Dr. Julia Spears had the highest success rate, 34.11% .
3. **Length of Stay by Doctor & Condition** – Avg stay per doctor & condition. Average length of stay of patients was 9.5days.  
4. **Condition Recurrence Analysis** – Recurrence of chronic conditions. 62500 re-ocurrence of hypertension case was documeneted. 
5. **Dirty Data Tracking** – Data quality score across tables. Data quality score was 58%.  

---

## 🗂️ SQL Views  

- `readmissions_within_30_days`  
- `doctor_diagnostic_success_rate`  
- `avg_stay_by_doctor_condition_view`  
- `chronic_condition_recurrence`  
- `data_quality_summary`  

---

## 📈 Tableau Dashboard  

The dashboard consolidates insights into **five key visual areas**:

### 1️⃣ Readmissions Within 30 Days  
![Readmissions Dashboard](images/readmissions.png)  

---

### 2️⃣ Doctor Diagnostic Success Rate  
![Doctor Success Dashboard](images/doctor_success.png)  

---

### 3️⃣ Average Stay by Doctor & Condition  
![Average Stay Dashboard](images/avg_stay.png)  

---

### 4️⃣ Chronic Condition Recurrence  
![Chronic Recurrence Dashboard](images/chronic_recurrence.png)  

---

### 5️⃣ Data Quality Tracking  
![Data Quality Dashboard](images/data_quality.png)  

---
### Main Dashboard  
![Main Dashboard](images/Dashboard.png)  

---

## ⚙️ Tech Stack  

- **Python** → Data generation with `faker`, `pandas`  
- **PostgreSQL** → Data storage + SQL queries & views  
- **Tableau** → Visualization & dashboarding  

---

## 🚀 How to Run  

1. Clone repo:  
   ```bash
   git clone https://github.com/your-username/healthcare-analytics.git
   cd healthcare-analytics

