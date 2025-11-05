-- CSIT 455- Relational/Object Databases
-- Dr. Shahin Mehdipour Ataee
-- Term Project- Bank Database
-- Aaron Burkett & Ryan P
-- 10/29/2025

-- Database Population Queries

INSERT INTO Branch (Branch_Name, Address, City, State, Zip_Code)
VALUES 
	('Downtown Branch', '100 Main St', 'Buffalo', 'NY', '14201'), -- Branch_ID = 1
	('Northtowns Branch', '250 North Ave', 'Buffalo', 'NY', '14216'), -- Branch_ID = 2, etc.
	('Blasdell Branch', '1444 South Park Ave', 'Blasdell', 'NY', '14219'),
	('Hamburg Branch', '25 Bayview Dr', 'Hamburg', 'NY', '14075'),
	('Lakeview Branch', '42 Lakeview Blvd', 'Rochester', 'NY', '14607'),
	('Fredonia Branch', '280 Central Ave', 'Fredonia', 'NY', '14063'),
	('Dunkirk Branch', '155 W 2nd St', 'Dunkirk', 'NY', '14063'),
	('Bank Tower', '1 Tower Dr', 'Buffalo', 'NY', '14444')
	;

INSERT INTO Employee (First_Name, Last_Name, Position, Salary, Hire_Date, Branch_ID)
VALUES
('Anna', 'Gun', 'Manager', 75000, '2019-03-14', 1),
('Bryan', 'Cranston', 'Cashier', 42000, '2021-06-01', 1),
('Aaron', 'Paul', 'Security', 62000, '2020-09-22', 2),
('Bob', 'Odenkirk', 'Loan Officer', 62000, '2020-09-22', 2),
('Dean', 'Norris', 'Manager', 42000, '2021-06-01', 4),
('Jonathon', 'Banks', 'General Manager', 42000, '2021-06-01', 2),
('Giancarlo', 'Esposito', 'Human Resources', 42000, '2021-06-01', 8),
('Levell', 'Crawford', 'Security', 42000, '2021-06-01', 1),
('David', 'Costabile', 'Loan Officer', 42000, '2021-06-01', 1),
('Raymond', 'Cruz', 'Intern', 0, '2021-06-01', 8)
;

INSERT INTO Client (First_Name, Last_Name, Date_of_Birth, Email, Phone, Address, City, State, Zip_Code, State_License_No, hasChecking, hasSavings, hasLoan, loanType)
VALUES
('Sklyer', 'White', '2003-02-17', 'aaronburkett@example.com', '7165558123', '123 Elm St', 'Buffalo', 'NY', '14201', 9876543210, 1, 1, 0, NULL), --Client_ID = 1, etc.
('Walter', 'White', '1995-07-10', 'emmaw@example.com', '7165552244', '456 Maple Rd', 'Buffalo', 'NY', '14216', 1234567890, 1, 0, 1, 'Auto'),
('Jesse', 'Pinkman', '1988-11-05', 'davidk@example.com', '5855559988', '89 Hilltop Dr', 'Rochester', 'NY', '14607', 1122334455, 1, 1, 1, 'Mortgage'),
('Saul', 'Goodman', '1988-11-05', 'davidk@example.com', '5855559988', '89 Hilltop Dr', 'Rochester', 'NY', '14607', 1122334455, 1, 1, 1, 'Mortgage'),
('Hank', 'Schrader', '1988-11-05', 'davidk@example.com', '5855559988', '89 Hilltop Dr', 'Rochester', 'NY', '14607', 1122334455, 1, 1, 1, 'Mortgage'),
('Mike', 'Ehrmantraut', '1988-11-05', 'davidk@example.com', '5855559988', '89 Hilltop Dr', 'Rochester', 'NY', '14607', 1122334455, 1, 1, 1, 'Mortgage'),
('Gustavo', 'Fring', '1988-11-05', 'davidk@example.com', '5855559988', '89 Hilltop Dr', 'Rochester', 'NY', '14607', 1122334455, 1, 1, 1, 'Mortgage'),
('Huell', 'Babineaux', '1988-11-05', 'davidk@example.com', '5855559988', '89 Hilltop Dr', 'Rochester', 'NY', '14607', 1122334455, 1, 1, 1, 'Mortgage'),
('Gale', 'Boetticher', '1988-11-05', 'davidk@example.com', '5855559988', '89 Hilltop Dr', 'Rochester', 'NY', '14607', 1122334455, 1, 1, 1, 'Mortgage'),
('Tuco', 'Salamanca', '1988-11-05', 'davidk@example.com', '5855559988', '89 Hilltop Dr', 'Rochester', 'NY', '14607', 1122334455, 1, 1, 1, 'Auto'); --Blue Convertible


INSERT INTO Account (Client_ID, Branch_ID, Account_Type, Balance, Open_Date)
VALUES
(1, 1, 'Checking', 1250.75, '2023-05-10'),
(1, 1, 'Savings', 5400.00, '2023-05-11'),
(2, 2, 'Checking', 820.50, '2024-01-18'),
(2, 2, 'Savings', 12000000.00, '2004-04-23'),
(3, 3, 'Checking', 3000.00, '2022-03-05'),
(3, 3, 'Savings', 12000.00, '2022-03-07');

INSERT INTO Loan (Client_ID, Branch_ID, Loan_Type, Amount, Interest_Rate, Start_Date, Due_Date)
VALUES
(2, 2, 'Auto', 15000.00, 4.5, '2024-02-01', '2029-02-01'),
(3, 3, 'Mortgage', 250000.00, 3.9, '2022-03-15', '2052-03-15');

INSERT INTO Loan_Payment (Loan_ID, Payment_Date, Amount)
VALUES
(1, '2024-03-01', 300.00),
(1, '2024-04-01', 300.00),
(2, '2024-03-01', 1200.00),
(2, '2024-04-01', 1200.00);

INSERT INTO Transactions (Account_ID, Transaction_Type, Amount, Transaction_Date, Description)
VALUES
(1, 'Deposit', 500.00, '2024-05-01', 'Paycheck Deposit'),
(1, 'Withdrawal', 100.00, '2024-05-03', 'ATM Withdrawal'),
(2, 'Deposit', 200.00, '2024-05-04', 'Savings Transfer'),
(3, 'Deposit', 820.50, '2024-01-18', 'Initial Deposit'),
(4, 'Transfer', 500.00, '2024-03-10', 'Transfer to Savings'),
(5, 'Deposit', 300.00, '2024-04-12', 'Interest Credit');


INSERT INTO User_Login (Username, Password_Hash, Role, Client_ID, Employee_ID)
VALUES
('aaronb', 'hash123', 'Client', 1, NULL),
('emmaw', 'hash456', 'Client', 2, NULL),
('davidk', 'hash789', 'Client', 3, NULL),
('susanm', 'hash999', 'Employee', NULL, 1),
('jamesb', 'hash222', 'Employee', NULL, 2);


INSERT INTO Logs (User_ID, Action, Details)
VALUES
(1, 'Login', 'Client login successful'),
(1, 'Transfer', 'Transferred $100 from Checking to Savings'),
(2, 'Loan Payment', 'Auto loan payment processed'),
(4, 'Approval', 'Approved new savings account for client 3');

