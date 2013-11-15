USE master

IF DB_ID('finalDB') IS NOT NULL
	DROP DATABASE finalDB
GO

CREATE DATABASE finalDB
GO

USE finalDB

CREATE TABLE Departments(
	DepartmentID	int				NOT NULL 
		IDENTITY(1,1) PRIMARY KEY,

	Name			varchar(100)	NOT NULL 
		UNIQUE,
)

CREATE TABLE DepartmentPositions(
	PositionID		int				NOT NULL
		IDENTITY(1,1) PRIMARY KEY,

	DepartmentID	int				NOT NULL
		FOREIGN KEY REFERENCES Departments(DepartmentID)
		ON DELETE CASCADE,

	Name			varchar(100)	NOT NULL,
	Descr		varchar(255)	NOT NULL,

	CONSTRAINT deptposlink UNIQUE(PositionID, DepartmentID)
)

CREATE TABLE Wages(
	WageID			int				NOT NULL
		IDENTITY(1,1) PRIMARY KEY,

	isHourly		bit				NOT NULL
		DEFAULT 1,

	Wage			decimal(12,2)	NOT NULL
		DEFAULT 7.25,
	isSalary		bit				NOT NULL
		DEFAULT 0,

	Salary			decimal(12,2)	NULL,
	isComm			bit				NOT NULL
		DEFAULT 0,

	CommPerc		decimal(3,2)	NULL,
	CommBase		int				NULL,

	isBonus			bit				NOT NULL
		DEFAULT 0,

	Bonus			int				NULL,

	CONSTRAINT chk_wages	CHECK (isHourly=1 AND Wage >= 7.25),
	CONSTRAINT chk_salary	CHECK (isSalary=1 AND Salary > 0),
	CONSTRAINT chk_bonus	CHECK (isBonus=1 AND Bonus > 0),
	CONSTRAINT chk_Comm		CHECK (isComm=1 AND CommPerc > 0 AND CommBase > 0)
)

CREATE TABLE Employees(
	EmployeeID		int				NOT NULL 
		IDENTITY(1,1) PRIMARY KEY,

	UserName		varchar(50)		NOT NULL 
		UNIQUE,

	LName			nvarchar(100)	NOT NULL,
	MI				char(1)			NOT NULL,
	FName			nvarchar(100)	NOT NULL,
	DateOfHire		date			NOT NULL 
		DEFAULT GETDATE(),
	
	PositionID		int				NOT NULL
		FOREIGN KEY REFERENCES DepartmentPositions(PositionID),

	EContract		bit NOT NULL
		DEFAULT 0,

	WagesID			int				NULL
		FOREIGN KEY REFERENCES Wages(WageID)
)

CREATE TABLE Projects(
	ProjectID		int				NOT NULL
		IDENTITY(1,1) PRIMARY KEY,

	Name			varchar(100)	NOT NULL,
	Descr			varchar(2048)	NOT NULL
)

CREATE TABLE ProjectPositions(
	ProjPositionID	int				NOT NULL
		IDENTITY(1,1) PRIMARY KEY,

	ProjectID		int				NOT NULL
		FOREIGN KEY REFERENCES Projects(ProjectID)
		ON DELETE CASCADE,

	Name			varchar(100)	NOT NULL,
	Descr			varchar(512)	NOT NULL,
)

CREATE TABLE EmployeeProjects(
	EmployeeID		int				NOT NULL
		FOREIGN KEY REFERENCES Employees(EmployeeID)
		ON DELETE CASCADE,

	ProjPositionID	int				NOT NULL
		FOREIGN KEY REFERENCES ProjectPositions(ProjPositionID)
		ON DELETE CASCADE,

	CONSTRAINT linkproj2emp PRIMARY KEY (EmployeeID, ProjPositionID)
)

GO

--CREATE PROCEDURE InsertEmployee
	--@UserName varchar(50),
	--@LName nvarchar(100),
	--@MI char(1),
	--@FName nvarchar(100),
	--@DateOfHire date,
	--@DepartmentID int,
	--@emp_pos int,
	--@emp_cont bit,
	--@id int out
--AS
	--SET NOCOUNT ON;
	--INSERT INTO emp_base (UserName, LName, MI, FName, DateOfHire,  PositionID, EContract)
	--VALUES (@UserName, @LName, @MI, @FName, @DateOfHire, @ @emp_pos, @emp_cont)
	--SET @id = SCOPE_IDENTITY()
GO



SET IDENTITY_INSERT Departments ON
GO

INSERT INTO Departments(DepartmentID, Name) VALUES (1, N'Administration')
INSERT INTO Departments(DepartmentID, Name) VALUES (2, N'Engineering')
INSERT INTO Departments(DepartmentID, Name) VALUES (4, N'Human Resources')
INSERT INTO Departments(DepartmentID, Name) VALUES (7, N'Information Technology')
INSERT INTO Departments(DepartmentID, Name) VALUES (5, N'Quality Assurance')
INSERT INTO Departments(DepartmentID, Name) VALUES (3, N'Research & Development')
INSERT INTO Departments(DepartmentID, Name) VALUES (6, N'Sales')
GO
SET IDENTITY_INSERT Departments OFF
Go

SET IDENTITY_INSERT DepartmentPositions ON
GO

INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (1, 1, N'C.E.O.', N'Chief Executive Officer')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (2, 1, N'C.F.O.', N'Cheif Fincial Officer')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (3, 1, N'C.O.O.', N'Cheif Operations Officer')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (4, 2, N'Administrator', N'Administrator - Engineering Department')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (7, 2, N'Assistant Administrator', N'Assistant Administrator - Engineering Department')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (8, 2, N'Engineer', N'Engineer - Engineering Department')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (9, 3, N'Administrator', N'Administrator - Research & Developement')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (10, 3, N'Assistant Adminstrator', N'Assistant Administrator - Research & Developement')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (11, 3, N'Lead Researcher', N'Lead Researcher - Research & Developement')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (12, 3, N'Researcher', N'Researcher - Research & Developement')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (13, 4, N'Administrator', N'Administrator - Human Resources')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (14, 4, N'Assistant Administrator', N'Assistant Administrator - Human Resources')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (15, 4, N'Legal Advisor', N'Legal Advisor - Human Resources')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (16, 4, N'Secretary', N'Secretary - Human Resources')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (17, 5, N'Administrator', N'Administrator - Quality Assurance')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (18, 5, N'Tester', N'Tester - Quality Assurance')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (19, 6, N'Administrator', N'Administrator - Sales')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (20, 6, N'Lead Salesman', N'Lead Salesman - Sales')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (21, 6, N'Salesman', N'Salesman - Sales')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (22, 7, N'Administrator', N'Administrator - Information Technology')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (23, 7, N'Assistant Administrator', N'Assistant Administrator - Information Technology')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (24, 7, N'Lead Support', N'Lead Support - Information Technology')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (25, 7, N'Support', N'Support - Information Technology')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (26, 7, N'Technician', N'Technicial - Information Technology')
INSERT INTO DepartmentPositions(PositionID, DepartmentID, Name, Descr) VALUES (27, 7, N'Help Desk Support', N'Help Desk Support - Information Technology')
GO

SET IDENTITY_INSERT DepartmentPositions OFF
GO

SET IDENTITY_INSERT Employees ON
GO

INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (1, N'tjtimberlake', N'Timberlake', N'J', N'Taylor', CAST(0xCA370B00 AS Date), 1, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (2, N'kgjarrett', N'Jarrett', N'G', N'Kody', CAST(0xCA370B00 AS Date), 2, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (3, N'ideads', N'Ivan', N'D', N'Eads', CAST(0xCA370B00 AS Date), 3, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (4, N'emhibbert', N'Emmerson', N'M', N'Hibbert', CAST(0xCA370B00 AS Date), 4, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (5, N'bslockwood', N'Branson', N'S', N'Lockwood', CAST(0xCA370B00 AS Date), 7, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (6, N'flbeverley', N'Finnegan', N'L', N'Beverley', CAST(0xCA370B00 AS Date), 8, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (7, N'mpdurant', N'Michael', N'P', N'Durant', CAST(0xCA370B00 AS Date), 8, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (8, N'ecvarley', N'Eden', N'C', N'Varley', CAST(0xCA370B00 AS Date), 8, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (9, N'ogduke', N'Owen', N'G', N'Duke', CAST(0xCA370B00 AS Date), 8, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (10, N'rsjanson', N'Roderick', N'S', N'Janson', CAST(0xCA370B00 AS Date), 9, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (11, N'ekford', N'Ethan', N'K', N'Ford', CAST(0xCA370B00 AS Date), 10, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (12, N'eeharper', N'Eden', N'E', N'Harper', CAST(0xCA370B00 AS Date), 11, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (13, N'hdholmwood', N'Howie', N'D', N'Holmwood', CAST(0xCA370B00 AS Date), 12, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (14, N'flmadison', N'Finley', N'L', N'Madison', CAST(0xCA370B00 AS Date), 12, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (15, N'tmdurant', N'Todd', N'M', N'Durant', CAST(0xCA370B00 AS Date), 13, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (16, N'wzhawkins', N'Wallace', N'Z', N'Hawkins', CAST(0xCA370B00 AS Date), 14, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (17, N'ambaker', N'Al', N'M', N'Baker', CAST(0xCA370B00 AS Date), 15, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (18, N'deeverill', N'Darrell', N'E', N'Everill', CAST(0xCB370B00 AS Date), 15, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (19, N'abdietrich', N'Annabeth', N'B', N'Dietrich', CAST(0xCB370B00 AS Date), 16, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (20, N'ersamuels', N'Esmond', N'R', N'Samuels', CAST(0xCB370B00 AS Date), 17, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (21, N'rdterry', N'Roddy', N'D', N'Terry', CAST(0xCB370B00 AS Date), 18, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (22, N'mawhitaker', N'Merritt', N'A', N'Whitaker', CAST(0xCB370B00 AS Date), 18, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (23, N'alclark', N'Adele', N'L', N'Clark', CAST(0xCB370B00 AS Date), 19, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (24, N'embell', N'Errol', N'M', N'Bell', CAST(0xCB370B00 AS Date), 20, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (25, N'ckpeyton', N'Colbert', N'K', N'Peyton', CAST(0xCB370B00 AS Date), 21, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (26, N'lzchance', N'Laurie', N'Z', N'Chance', CAST(0xCB370B00 AS Date), 21, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (27, N'ebtaylor', N'Eliot', N'B', N'Taylor', CAST(0xCB370B00 AS Date), 21, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (28, N'gtchristopherson', N'Gregg', N'T', N'Christopherson', CAST(0xCB370B00 AS Date), 22, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (29, N'cbvictorson', N'Clive', N'B', N'Victorson', CAST(0xCB370B00 AS Date), 23, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (30, N'slmartins', N'Shelby', N'L', N'Martins', CAST(0xCB370B00 AS Date), 24, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (31, N'tbhampton', N'Tyrell', N'B', N'Hampton', CAST(0xCB370B00 AS Date), 25, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (32, N'dfdaniell', N'Dominick', N'F', N'Daniell', CAST(0xCB370B00 AS Date), 25, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (33, N'mgcotterill', N'Mickey', N'G', N'Cotterill', CAST(0xCB370B00 AS Date), 25, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (34, N'mrgrayson', N'Mason', N'R', N'Grayson', CAST(0xCB370B00 AS Date), 26, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (35, N'caeccleston', N'Cole', N'A', N'Eccleston', CAST(0xCB370B00 AS Date), 27, 0)
INSERT INTO Employees(EmployeeID, UserName, LName, MI, FName, DateOfHire, PositionID, EContract) VALUES (36, N'klrome', N'Kenneth', N'L', N'Rome', CAST(0xCB370B00 AS Date), 27, 0)
GO

SET IDENTITY_INSERT Employees OFF
GO