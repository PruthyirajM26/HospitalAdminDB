# HospitalAdminDB

HospitalAdminDB is a SQL-based project designed to simulate a comprehensive hospital database management system. The system supports core functionalities such as managing patients, doctors, appointments, treatments, and billing information, along with generating insightful reports.

---

## **Features**

### **Database Tables**
- **Patients:** Stores patient details such as name, date of birth, gender, contact information, and address.
- **Doctors:** Contains details about doctors, including specialization and contact information.
- **Appointments:** Manages appointments between patients and doctors, along with statuses and notes.
- **Treatments:** Records treatments, their descriptions, and associated costs.
- **Billing:** Tracks billing information, total amounts, and payment statuses.

### **Reports and Queries**
1. Calculate average patient wait times by doctor.
2. List patients with unpaid bills.
3. Generate a report of total revenue by doctor.
4. Count the number of patients treated by each doctor.
5. Identify frequently canceled appointments by patients.
6. Determine the busiest day for appointments for each doctor.
7. List patients who have seen multiple doctors.
8. Calculate average treatment costs per patient.
9. Find the most common specialization for completed appointments.
10. List all appointments along with their associated billing status.

---

## **Project Structure**

```
Hospital Database
│
├── Code
│   └── hospital.sql          # SQL script for creating and populating the database
│
├── Images                    # Visuals representing query outputs
│   ├── 1wait times.png
│   ├── 2unpaid bill.png
│   ├── 3total revenue.png
│   ├── 4no of patients.png
│   ├── 5appointment cancelled.png
│   ├── 6busiest day.png
│   ├── 7multiple doctors.png
│   ├── 8avg treatment cost.png
│   └── 9specialization completed appoint.png
└── README.md                 # Project documentation
```

---

## **Usage**
- Run the SQL queries in the `hospital.sql` file to create the database schema and insert sample data.
- Execute the provided queries to generate insights and reports.
- Customize the database and queries as needed for additional functionality.

---

## ** Outputs**

| Query Description                                                    |  Image                                                                   |
|----------------------------------------------------------------------|--------------------------------------------------------------------------|
| 1. Calculate average patient wait times by doctor                    | ![Wait Times](Images/1wait%20times.png)                                  |
| 2. List patients with unpaid bills                                   | ![Unpaid Bills](Images/2unpaid%20bill.png)                               |
| 3. Generate report of total revenue by doctor                        | ![Revenue](Images/3total%20revenue.png)                                  |
| 4. Count the number of patients treated by each doctor               | ![Patients](Images/4no%20of%20patients.png)                              |
| 5. Identify frequently cancelled appointments by patient             | ![Statistics](Images/5appointment%20cancelled.png)                       |
| 6. Identify the busiest day for appointments for each doctor         | ![Ward Utilization](Images/6busiest%20day.png)                           |
| 7. List patients who have seen multiple doctors                      | ![Appointment](Images/7multiple%20doctors.png)                           |
| 8. Calculate average treatment cost per patient                      | ![Revenue](Images/8avg%20treatment%20cost.png)                           |
| 9. Find the most common specialization for completed appointments    | ![Staff Shift](Images/9specialization%20completed%20appoint.png)         |
| 10. List all appointments with their associated billing status       | ![Discharge Trends](Images/10appointments%20with%20billing%20status.png) |

---
