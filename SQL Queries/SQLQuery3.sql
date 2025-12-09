-- CSIT 455- Relational/Object Databases
-- Dr. Shahin Mehdipour Ataee
-- Term Project- Bank Database
-- Aaron Burkett & Ryan Pontonio
-- 10/29/2025

-- Database Table Testing Queries

-- View all clients and their accounts
SELECT C.First_Name, C.Last_Name, A.Account_Type, A.Balance
FROM Client C
JOIN Account A ON C.Client_ID = A.Client_ID;

-- View all transactions for a client
SELECT C.First_Name, C.Last_Name, T.Transaction_Type, T.Amount, T.Transaction_Date
FROM Client C
JOIN Account A ON C.Client_ID = A.Client_ID
JOIN Transactions T ON A.Account_ID = T.Account_ID
WHERE C.Client_ID = 1;

-- View loans and payments
SELECT L.Loan_ID, C.First_Name, L.Loan_Type, L.Amount, P.Payment_Date, P.Amount AS Payment_Amount
FROM Loan L
JOIN Client C ON L.Client_ID = C.Client_ID
LEFT JOIN Loan_Payment P ON L.Loan_ID = P.Loan_ID;

-- Find the average salary for all employees 
SELECT AVG(Salary) Avg_Salary 
FROM Employee; 

-- Total balance of all savings accounts 
SELECT SUM(Balance) Total_Savings 
FROM Account 
WHERE Account_Type = 'Savings';  

-- List all clients who have both a checking and savings account 

SELECT DISTINCT C.Client_ID, C.First_Name, C.Last_name  
FROM Client C  
JOIN Account A1 ON C.Client_ID = A1.Client_ID AND A1.Account_Type = 'Checking' 
JOIN Account A2 ON C.Client_ID = A2.Client_ID AND A2.Account_Type = 'Savings'; 

-- Show all clients who have made a transaction over $500 

SELECT DISTINCT C.Client_ID, C.First_Name, C.Last_Name 
FROM Client C 
JOIN Account A ON C.Client_ID = A.Client_ID 
JOIN Transactions T ON A.Account_ID = T.Account_ID 
WHERE T.Amount > 500; 

-- Show me all employees who have a login account, ordered by salary 
SELECT E.Employee_ID, E.First_Name, E.Last_Name, E.Salary 
FROM Employee E 
JOIN User_Login U ON E.Employee_ID = U.Employee_ID 
ORDER BY E.Salary DESC; 

-- Give all employees who have a salary greater than 65000 a 3% raise 
UPDATE Employee 
SET Salary = Salary * 1.03 
WHERE Salary > 65000; 

-- Create a procedure that gets employees with login accounts 

CREATE PROCEDURE EmployeesWithLogin 
AS SELECT E.Employee_ID, E.First_Name, E.Last_Name, E.Salary 
FROM Employee E 
JOIN User_Login U ON E.Employee_ID = U.Employee_ID 
ORDER BY E.Salary DESC; 

EXEC EmployeesWithLogin 
