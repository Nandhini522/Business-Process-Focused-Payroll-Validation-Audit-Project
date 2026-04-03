--Payroll Validation Project SQL Queries
--Author: Nandhini Kondaparthi
--Purpose: To validate payroll calculations and detect discrepancies



--1.Create Payroll Table

CREATE TABLE payroll(
Employee_ID VARCHAR(10),
Employee_Name VARCHAR(50),
Basic_Salary INT,
HRA_Percent FLOAT,
Bonus INT,
Tax_Percent FLOAT,
PF_Percent FLOAT,
);



--2.Insert Employee Data

INSERT INTO payroll VALUES
('E005','Kiran',22000,0.25,2500,0.10,0.12),
('E006','Anjali',27000,0.20,3500,0.12,0.10),
('E007','Rahul',35000,0.30,5000,0.18,0.12),
('E008','Pooja',16000,0.20,1200,0.8,0.10),
('E009','Vikram',28000,0.25,3000,0.14,0.12),
('E010','Neha',24000,0.20,2000,0.10,0.10),
('E011','Arjun',26000,0.25,3200,0.12,0.12),
('E012','Meena',21000,0.20,1800,0.9,0.10),
('E013','Varun',33000,0.30,4500,0.16,0.12),
('E014','Kavya',19000,0.20,1500,0.8,0.10),
('E015','Suraj',31000,0.25,4000,0.15,0.12),
('E016','Nisha',23000,0.20,2200,0.10,0.10),
('E017','Ramesh',17000,0.20,1000,0.7,0.12),
('E018','Swathi',29000,0.25,3500,0.14,0.10),
('E019','Deepak',27000,0.30,3800,0.13,0.12),
('E020','Lakshmi',20000,0.20,2000,0.10,0.10);



--3.View All Employee Data

SELECT * FROM payroll;


--4.Payroll Salary Breakdown Calculation
-- Calculates HRA, Tax, PF and Final Net Salary (Correct Logic)

SELECT 
    Employee_ID,
    Employee_Name,
    Basic_Salary,

    -- HRA
    (Basic_Salary * HRA_Percent) AS HRA_Amount,
     Bonus,

    -- Correct Tax
    ((Basic_Salary + (Basic_Salary * HRA_Percent) + Bonus) * Tax_Percent) AS Tax_Amount,

    -- PF
    (Basic_Salary * PF_Percent) AS PF_Amount,

    -- Net Salary (Correct)
    (Basic_Salary + (Basic_Salary * HRA_Percent) + Bonus 
     - ((Basic_Salary + (Basic_Salary * HRA_Percent) + Bonus) * Tax_Percent) 
     - (Basic_Salary * PF_Percent)) AS Net_Salary

FROM payroll;



--5.Simulated System Salary Calculation (Incorrect Logic)
-- System ignores HRA while calculating tax

SELECT 
    Employee_ID,

    -- Wrong Net Salary
    (Basic_Salary + (Basic_Salary * HRA_Percent) + Bonus 
     - ((Basic_Salary + Bonus) * Tax_Percent) -- ❌ HRA missing
     - (Basic_Salary * PF_Percent)) AS System_Salary

FROM payroll;



--6.Payroll Validation & Error Detection
-- Compares correct Salary vs System and calculates Difference

SELECT 
    Employee_ID,

    -- Correct
    (Basic_Salary + (Basic_Salary * HRA_Percent) + Bonus 
     - ((Basic_Salary + (Basic_Salary * HRA_Percent) + Bonus) * Tax_Percent) 
     - (Basic_Salary * PF_Percent)) AS Net_Salary,

    -- Wrong system
    (Basic_Salary + (Basic_Salary * HRA_Percent) + Bonus 
     - ((Basic_Salary + Bonus) * Tax_Percent) 
     - (Basic_Salary * PF_Percent)) AS System_Salary,

    -- Difference
    ABS(
    (Basic_Salary + (Basic_Salary * HRA_Percent) + Bonus 
     - ((Basic_Salary + (Basic_Salary * HRA_Percent) + Bonus) * Tax_Percent) 
     - (Basic_Salary * PF_Percent))
    -
    (Basic_Salary + (Basic_Salary * HRA_Percent) + Bonus 
     - ((Basic_Salary + Bonus) * Tax_Percent) 
     - (Basic_Salary * PF_Percent))
    ) AS Difference

FROM payroll;
