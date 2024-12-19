CREATE SCHEMA `hospital database`;
use `hospital database` ;

-- Creating tables for the hospital database

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    ContactNumber VARCHAR(15),
    Address VARCHAR(255));
    
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialization VARCHAR(100),
    ContactNumber VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME,
    Status ENUM('Scheduled', 'Completed', 'Cancelled'),
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Treatments (
    TreatmentID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT,
    TreatmentDescription TEXT,
    Cost DECIMAL(10, 2),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

CREATE TABLE Billing (
    BillingID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    TotalAmount DECIMAL(10, 2),
    PaymentStatus ENUM('Paid', 'Pending', 'Partially Paid'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- Insert example data

INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, ContactNumber, Address)
VALUES
('John', 'Doe', '1985-03-15', 'Male', '1234567890', '123 Elm Street'),
('Jane', 'Smith', '1990-07-20', 'Female', '0987654321', '456 Oak Avenue');

INSERT INTO Doctors (FirstName, LastName, Specialization, ContactNumber, Email)
VALUES
('Alice', 'Johnson', 'Cardiology', '5551234567', 'alice.johnson@hospital.com'),
('Bob', 'Brown', 'Orthopedics', '5559876543', 'bob.brown@hospital.com');

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status, Notes)
VALUES
(1, 1, '2024-12-01 10:00:00', 'Scheduled', 'Regular checkup'),
(2, 2, '2024-12-02 11:30:00', 'Completed', 'Follow-up on knee surgery');

INSERT INTO Treatments (AppointmentID, TreatmentDescription, Cost)
VALUES
(2, 'Knee surgery follow-up treatment', 1500.00);

INSERT INTO Billing (PatientID, TotalAmount, PaymentStatus)
VALUES
(2, 1500.00, 'Pending');

-- Complex queries for meaningful reports

-- 1. Calculate average patient wait times by doctor

SELECT 
    d.DoctorID,
    CONCAT(d.FirstName, ' ', d.LastName) AS DoctorName,
    AVG(TIMESTAMPDIFF(MINUTE, a.AppointmentDate, NOW())) AS AvgWaitTimeMinutes
FROM 
    Appointments a
JOIN 
    Doctors d ON a.DoctorID = d.DoctorID
WHERE 
    a.Status = 'Scheduled'
GROUP BY 
    d.DoctorID;
    
-- 2. List patients with unpaid bills

SELECT 
    p.PatientID,
    CONCAT(p.FirstName, ' ', p.LastName) AS PatientName,
    b.TotalAmount,
    b.PaymentStatus
FROM 
    Billing b
JOIN 
    Patients p ON b.PatientID = p.PatientID
WHERE 
    b.PaymentStatus != 'Paid';

-- 3. Generate report of total revenue by doctor

SELECT 
    d.DoctorID,
    CONCAT(d.FirstName, ' ', d.LastName) AS DoctorName,
    SUM(t.Cost) AS TotalRevenue
FROM 
    Treatments t
JOIN 
    Appointments a ON t.AppointmentID = a.AppointmentID
JOIN 
    Doctors d ON a.DoctorID = d.DoctorID
GROUP BY 
    d.DoctorID;

-- 4. Count the number of patients treated by each doctor

SELECT 
    d.DoctorID,
    CONCAT(d.FirstName, ' ', d.LastName) AS DoctorName,
    COUNT(DISTINCT a.PatientID) AS PatientsTreated
FROM 
    Appointments a
JOIN 
    Doctors d ON a.DoctorID = d.DoctorID
WHERE 
    a.Status = 'Completed'
GROUP BY 
    d.DoctorID;

-- 5. Identify frequently cancelled appointments by patient

SELECT 
    p.PatientID,
    CONCAT(p.FirstName, ' ', p.LastName) AS PatientName,
    COUNT(a.AppointmentID) AS CancelledAppointments
FROM 
    Appointments a
JOIN 
    Patients p ON a.PatientID = p.PatientID
WHERE 
    a.Status = 'Cancelled'
GROUP BY 
    p.PatientID
HAVING 
    COUNT(a.AppointmentID) > 2;
    
-- 6. Identify the busiest day for appointments for each doctor

SELECT 
    d.DoctorID,
    CONCAT(d.FirstName, ' ', d.LastName) AS DoctorName,
    DATE(a.AppointmentDate) AS BusiestDay,
    COUNT(a.AppointmentID) AS AppointmentCount
FROM 
    Appointments a
JOIN 
    Doctors d ON a.DoctorID = d.DoctorID
GROUP BY 
    d.DoctorID, DATE(a.AppointmentDate)
ORDER BY 
    AppointmentCount DESC;

-- 7. List patients who have seen multiple doctors

SELECT 
    p.PatientID,
    CONCAT(p.FirstName, ' ', p.LastName) AS PatientName,
    COUNT(DISTINCT a.DoctorID) AS NumberOfDoctors
FROM 
    Appointments a
JOIN 
    Patients p ON a.PatientID = p.PatientID
GROUP BY 
    p.PatientID
HAVING 
    COUNT(DISTINCT a.DoctorID) > 1;

-- 8. Calculate average treatment cost per patient

SELECT 
    p.PatientID,
    CONCAT(p.FirstName, ' ', p.LastName) AS PatientName,
    AVG(t.Cost) AS AvgTreatmentCost
FROM 
    Treatments t
JOIN 
    Appointments a ON t.AppointmentID = a.AppointmentID
JOIN 
    Patients p ON a.PatientID = p.PatientID
GROUP BY 
    p.PatientID;

-- 9. Find the most common specialization for completed appointments

SELECT 
    d.Specialization,
    COUNT(a.AppointmentID) AS CompletedAppointments
FROM 
    Appointments a
JOIN 
    Doctors d ON a.DoctorID = d.DoctorID
WHERE 
    a.Status = 'Completed'
GROUP BY 
    d.Specialization
ORDER BY 
    CompletedAppointments DESC
LIMIT 1;

-- 10. List all appointments with their associated billing status

SELECT 
    a.AppointmentID,
    CONCAT(p.FirstName, ' ', p.LastName) AS PatientName,
    CONCAT(d.FirstName, ' ', d.LastName) AS DoctorName,
    a.AppointmentDate,
    b.PaymentStatus
FROM 
    Appointments a
LEFT JOIN 
    Billing b ON a.PatientID = b.PatientID
JOIN 
    Patients p ON a.PatientID = p.PatientID
JOIN 
    Doctors d ON a.DoctorID = d.DoctorID;