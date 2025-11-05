-- CSIT 455- Relational/Object Databases
-- Dr. Shahin Mehdipour Ataee
-- Term Project- Bank Database
-- Aaron Burkett & Ryan Pontonio
-- 10/29/2025

-- Database Creation Queries

use Bank;

create table Branch (
	Branch_ID int identity(1,1) primary key,
	Branch_Name varchar(100) not null,
	Address varchar(200) not null,
	City varchar(100) not null,
	State varchar(50),
	Zip_Code varchar(10)
);

create table Employee (
	Employee_ID int identity(1,1) primary key,
	First_Name varchar(50) not null,
	Last_Name varchar(50) not null,
	Position varchar(50),
	Salary decimal(12,2),
	Hire_Date date not null,
	Branch_ID int not null,
	foreign key (Branch_ID) references Branch(Branch_ID)
);

create table Client (
	Client_ID int identity(1,1) primary key,
	First_Name varchar(50) not null,
	Last_Name varchar (50) not null,
	Date_of_Birth date,
	Email varchar(100) unique,
	Phone varchar(15),
	Address varchar(200),
	City varchar(100),
	State varchar(50),
	Zip_Code varchar(10),
	Registration_Date date default getdate(),
	State_License_No numeric(10,0),
	--optional:
	hasChecking bit default 0,
	hasSavings bit default 0,
	hasLoan bit default 0,
	loanType varchar(20),
);


create table Account (
	Account_ID int identity(1,1) primary key, -- This denotes the unique ID of the account, which appears on the clients credit cards, website, etc.
	Client_ID int not null,
	Branch_ID int not null,
	Account_Type varchar(20) check (Account_Type in ('Checking', 'Savings', 'Credit', 'Business', 'Charge')),
	Balance decimal(15,2) default 0,
	Open_Date date default getdate(),
	foreign key (Client_ID) references Client(Client_ID),
	foreign key (Branch_ID) references Branch(Branch_ID)
);

create table Loan (
	Loan_ID int identity(1,1) primary key,
	Client_ID int not null,
	Branch_ID int not null,
	Loan_Type varchar(20) check (Loan_Type in ('Personal', 'Student', 'Auto', 'Mortgage', 'Business', 'Other')),
	Amount decimal(15,2) default 0,
	Interest_Rate decimal(5,2) not null,
	Start_Date date default getdate(),
	Due_Date date,
	foreign key (Client_ID) references Client(Client_ID),
	foreign key (Branch_ID) references Branch(Branch_ID)
);

create table Transactions(
	Transaction_ID int identity(1,1) primary key,
	Account_ID int not null,
	Transaction_Type varchar(20) check (Transaction_Type in ('Deposit', 'Withdrawal', 'Transfer', 'Payment', 'Wire', 'Closure', 'Default')),
	Account decimal(15,2) not null,
	Transaction_Date datetime default getdate(),
	Description varchar(255),
	foreign key (Account_ID) references Account(Account_ID)
);

create table Loan_Payment (
	Payment_ID int identity(1,1) primary key,
	Loan_ID int not null,
	Payment_Date date not null,
	Amount decimal(15,2) not null,
	foreign key (Loan_ID) references Loan(Loan_ID)
);

create table User_Login (
	User_ID int identity(1,1) primary key,
	Username varchar(50) unique not null,
	Password_Hash varchar(255) not null,
	Role varchar(20) check (Role in ('Client', 'Employee', 'Admin')),
	Client_ID int null,
	Employee_ID int null,
	foreign key (Client_ID) references Client(Client_ID),
	foreign key (Employee_ID) references Employee(Employee_ID)
);

create table Logs (
	Log_ID int identity(1,1) primary key,
	User_ID int,
	Action varchar(100) not null,
	Timestamp datetime default getdate(),
	Details varchar(255),
	foreign key (User_ID) references User_Login(User_ID)
);
