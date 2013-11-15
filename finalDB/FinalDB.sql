USE master

IF DB_ID('finalDB') IS NOT NULL
	DROP DATABASE finalDB
GO

CREATE DATABASE finalDB
GO

GO
CREATE USER [Azrael] FOR LOGIN [AZRAEL-PC\Azrael] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Azrael]
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

CREATE TABLE Employees(
	EmployeeID		int				NOT NULL 
		IDENTITY(1,1) PRIMARY KEY,

	UserName		varchar(50)		NOT NULL 
		UNIQUE,

	FName			nvarchar(100)	NOT NULL,
	MI				char(1)			NOT NULL,
	LName			nvarchar(100)	NOT NULL,
	DateOfHire		date			NOT NULL 
		DEFAULT GETDATE(),
	
	PositionID		int				NOT NULL
		FOREIGN KEY REFERENCES DepartmentPositions(PositionID)
)

CREATE TABLE Wages(
	WageID			int				NOT NULL
		IDENTITY(1,1) PRIMARY KEY,

	EmployeeID		int				NOT NULL
		UNIQUE
		FOREIGN KEY REFERENCES Employees(EmployeeID)
		ON DELETE CASCADE,

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

	Bonus			int				NULL
)

CREATE TABLE EmployeeInfo(
	EInfoID			int				NOT NULL
		IDENTITY(1,1) PRIMARY KEY,

	EmployeeID		int				NOT NULL
		UNIQUE
		FOREIGN KEY REFERENCES Employees(EmployeeID)
		ON DELETE CASCADE,

	DOB				date			NULL,
	EEmail			varchar(100)	NULL,
	EAddress		varchar(200)	NULL,
	ECity			varchar(100)	NULL,
	Zip				varchar(10)		NULL,
	EState			varchar(2)		NULL,
	EPhone			varchar(15)		NULL,

	CONSTRAINT emailCheck CHECK (EEmail LIKE '_%@_%._%'),

	CONSTRAINT phoneCheck CHECK (EPhone LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),

	CONSTRAINT zipCheck CHECK (Zip LIKE '[0-9][0-9][0-9][0-9][0-9]' OR 
       Zip LIKE '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' OR
       Zip LIKE '[A-Y][0-9][A-Z][0-9][A-Z][0-9]')
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

CREATE TABLE Tasks(
	TaskID			int				NOT NULL
		IDENTITY(1,1) PRIMARY KEY,

	Name			varchar(100)	NOT NULL,
	Descr			varchar(512)	NOT NULL,
	StartDate		DateTime		NOT NULL
		DEFAULT GETDATE(),

	EndDate			DateTime		NULL,
	CompletionDate	DateTime		NOT NULL, 
	IsMilestone		bit				NOT NULL
)

CREATE TABLE TasksEmployeeLink(
	TaskID			int				NOT NULL
		FOREIGN KEY REFERENCES Tasks(TaskID)
		ON DELETE CASCADE,

	EmployeeID		int				NOT NULL
		FOREIGN KEY REFERENCES Employees(EmployeeID)
		ON DELETE CASCADE

	CONSTRAINT TaskEmpLinkConstraint PRIMARY KEY (TaskID, EmployeeID)
)

CREATE TABLE TasksDepartmentLink(
	TaskID			int				NOT NULL
		FOREIGN KEY REFERENCES Tasks(TaskID)
		ON DELETE CASCADE,

	DepartmentID	int				NOT NULL
		FOREIGN KEY REFERENCES Departments(DepartmentID)
		ON DELETE CASCADE

	CONSTRAINT TaskDeptLinkConstraint PRIMARY KEY (TaskID, DepartmentID)
)

CREATE TABLE TasksProjectLink(
	TaskID			int				NOT NULL
		FOREIGN KEY REFERENCES Tasks(TaskID)
		ON DELETE CASCADE,

	ProjectID		int				NOT NULL
		FOREIGN KEY REFERENCES Projects(ProjectID)
		ON DELETE CASCADE

	CONSTRAINT TaskProjLinkConstraint PRIMARY KEY (TaskID, ProjectID)
)

CREATE TABLE TasksProjectPositionLink(
	TaskID			int				NOT NULL
		FOREIGN KEY REFERENCES Tasks(TaskID)
		ON DELETE CASCADE,

	ProjPositionID		int				NOT NULL
		FOREIGN KEY REFERENCES ProjectPositions(ProjPositionID)
		ON DELETE CASCADE

	CONSTRAINT TaskProjPosLinkConstraint PRIMARY KEY (TaskID, ProjPositionID)
)

CREATE TABLE TasksDepartmentPositionLink(
	TaskID			int				NOT NULL
		FOREIGN KEY REFERENCES Tasks(TaskID)
		ON DELETE CASCADE,

	PositionID		int				NOT NULL
		FOREIGN KEY REFERENCES DepartmentPositions(PositionID)
		ON DELETE CASCADE

	CONSTRAINT TaskDeptPosLinkConstraint PRIMARY KEY (TaskID, PositionID)
)

GO

CREATE PROCEDURE InsertEmployee
	@UserName varchar(50),
	@LName nvarchar(100),
	@MI char(1),
	@FName nvarchar(100),
	@DateOfHire date,
	@DepartmentID int,
	@PositionID int,
	@EContract bit,
	@id int out
AS
	SET NOCOUNT ON;
	INSERT INTO Employees(UserName, LName, MI, FName, DateOfHire, PositionID)
	VALUES (@UserName, @LName, @MI, @FName, @DateOfHire, @PositionID)
	SET @id = SCOPE_IDENTITY()
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

INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (1, N'tjtimberlake', N'Taylor', N'J', N'Timberlake', CAST(0xCA370B00 AS Date), 1)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (2, N'kgjarrett', N'Kody', N'G', N'Jarrett', CAST(0xCA370B00 AS Date), 2)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (3, N'ideads', N'Ivan', N'D', N'Eads', CAST(0xCA370B00 AS Date), 3)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (4, N'emhibbert', N'Emmerson', N'M', N'Hibbert', CAST(0xCA370B00 AS Date), 4)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (5, N'bslockwood', N'Branson', N'S', N'Lockwood', CAST(0xCA370B00 AS Date), 7)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (6, N'flbeverley', N'Finnegan', N'L', N'Beverley', CAST(0xCA370B00 AS Date), 8)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (7, N'mpdurant', N'Michael', N'P', N'Durant', CAST(0xCA370B00 AS Date), 8)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (8, N'ecvarley', N'Eden', N'C', N'Varley', CAST(0xCA370B00 AS Date), 8)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (9, N'ogduke', N'Owen', N'G', N'Duke', CAST(0xCA370B00 AS Date), 8)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (10, N'rsjanson', N'Roderick', N'S', N'Janson', CAST(0xCA370B00 AS Date), 9)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (11, N'ekford', N'Ethan', N'K', N'Ford', CAST(0xCA370B00 AS Date), 10)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (12, N'eeharper', N'Eden', N'E', N'Harper', CAST(0xCA370B00 AS Date), 11)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (13, N'hdholmwood', N'Howie', N'D', N'Holmwood', CAST(0xCA370B00 AS Date), 12)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (14, N'flmadison', N'Finley', N'L', N'Madison', CAST(0xCA370B00 AS Date), 12)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (15, N'tmdurant', N'Todd', N'M', N'Durant', CAST(0xCA370B00 AS Date), 13)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (16, N'wzhawkins', N'Wallace', N'Z', N'Hawkins', CAST(0xCA370B00 AS Date), 14)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (17, N'ambaker', N'Al', N'M', N'Baker', CAST(0xCA370B00 AS Date), 15)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (18, N'deeverill', N'Darrell', N'E', N'Everill', CAST(0xCB370B00 AS Date), 15)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (19, N'abdietrich', N'Dietrich', N'B', N'Annabeth', CAST(0xCB370B00 AS Date), 16)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (20, N'ersamuels', N'Esmond', N'R', N'Samuels', CAST(0xCB370B00 AS Date), 17)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (21, N'rdterry', N'Roddy', N'D', N'Terry', CAST(0xCB370B00 AS Date), 18)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (22, N'mawhitaker', N'Merritt', N'A', N'Whitaker', CAST(0xCB370B00 AS Date), 18)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (23, N'alclark', N'Adele', N'L', N'Clark', CAST(0xCB370B00 AS Date), 19)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (24, N'embell', N'Errol', N'M', N'Bell', CAST(0xCB370B00 AS Date), 20)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (25, N'ckpeyton', N'Colbert', N'K', N'Peyton', CAST(0xCB370B00 AS Date), 21)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (26, N'lzchance', N'Laurie', N'Z', N'Chance', CAST(0xCB370B00 AS Date), 21)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (27, N'ebtaylor', N'Eliot', N'B', N'Taylor', CAST(0xCB370B00 AS Date), 21)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (28, N'gtchristopherson', N'Gregg', N'T', N'Christopherson', CAST(0xCB370B00 AS Date), 22)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (29, N'cbvictorson', N'Clive', N'B', N'Victorson', CAST(0xCB370B00 AS Date), 23)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (30, N'slmartins', N'Shelby', N'L', N'Martins', CAST(0xCB370B00 AS Date), 24)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (31, N'tbhampton', N'Tyrell', N'B', N'Hampton', CAST(0xCB370B00 AS Date), 25)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (32, N'dfdaniell', N'Dominick', N'F', N'Daniell', CAST(0xCB370B00 AS Date), 25)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (33, N'mgcotterill', N'Mickey', N'G', N'Cotterill', CAST(0xCB370B00 AS Date), 25)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (34, N'mrgrayson', N'Mason', N'R', N'Grayson', CAST(0xCB370B00 AS Date), 26)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (35, N'caeccleston', N'Cole', N'A', N'Eccleston', CAST(0xCB370B00 AS Date), 27)
INSERT INTO Employees(EmployeeID, UserName, FName, MI, LName, DateOfHire, PositionID) VALUES (36, N'klrome', N'Kenneth', N'L', N'Rome', CAST(0xCB370B00 AS Date), 27)
GO

SET IDENTITY_INSERT Employees OFF
GO

SET IDENTITY_INSERT EmployeeInfo ON 
GO

INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (1, 1, CAST(0xCFF60A00 AS Date), N'tjtimberlake@corp.net', N' 123 Coffins Ct', N'Portsmouth', N'03801', N'NH', N'603-123-4567')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (2, 2, CAST(0x0CE50A00 AS Date), N'kgjarrett@corp.net', N'11 State St', N'Portsmouth', N'03801', N'NH', N'603-544-5568')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (3, 3, CAST(0x57030B00 AS Date), N'ideads@corp.net', N'56 Brewster St', N'Portsmouth', N'03801', N'NH', N'603-465-6778')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (4, 4, CAST(0x22080B00 AS Date), N'emhibbert@corp.net', N'71 Aldrich Rd', N'Portsmouth', N'03801', N'NH', N'603-552-2520')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (5, 5, CAST(0xABDC0A00 AS Date), N'bslockwood@corp.net', N'155 Richards Ave', N'Portsmouth', N'03801', N'NH', N'603-686-3361')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (6, 6, CAST(0xEC060B00 AS Date), N'flbeverley@corp.net', N'223 Lincoln Ave', N'Portsmouth', N'03801', N'NH', N'603-699-1231')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (7, 7, CAST(0x49F40A00 AS Date), N'mpdurant@corp.net', N'22C Echo Ave', N'Newington', N'03805', N'NH', N'603-552-5852')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (8, 8, CAST(0xAC0D0B00 AS Date), N'ecvarley@corp.net', N'91 Elwyn Ave', N'Portsmouth', N'03801', N'NH', N'603-699-8858')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (9, 9, CAST(0x7A080B00 AS Date), N'ogduke@corp.net', N'22 Orchard Ct', N'Portsmouth', N'03801', N'NH', N'603-696-1467')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (10, 10, CAST(0x32F70A00 AS Date), N'rsjanson@corp.net', N'34 Thaxter Rd', N'Portsmouth', N'03801', N'NH', N'603-554-2852')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (11, 11, CAST(0xB0030B00 AS Date), N'ekford@corp.net', N'56 George St', N'Kittery', N'03904', N'ME', N'207-556-9966')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (12, 12, CAST(0x29050B00 AS Date), N'eeharper@corp.net', N'118 Old Post Rd', N'Kittery', N'03904', N'ME', N'207-556-2503')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (14, 13, CAST(0x18090B00 AS Date), N'hdholmwood@corp.net', N'208 Woodlawn Ave', N'Kittery', N'03904', N'ME', N'207-516-5175')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (15, 14, CAST(0x4A0B0B00 AS Date), N'flmadison@corp.net', N'331 Sagamore Ave', N'Portsmouth', N'03801', N'NH', N'603-451-8551')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (16, 15, CAST(0x97060B00 AS Date), N'tmdurant@corp.net', N'1 Union St', N'Portsmouth', N'03801', N'NH', N'603-556-1556')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (17, 16, CAST(0x1AFB0A00 AS Date), N'wzhawkins@corp.net', N'655 Broad St', N'Portsmouth', N'03801', N'NH', N'603-556-8831')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (18, 17, CAST(0x3FFF0A00 AS Date), N'ambaker@corp.net', N'1566 Central Rd', N'Rye', N'03870', N'NH', N'603-656-4467')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (19, 18, CAST(0x210F0B00 AS Date), N'deeverill@corp.net', N'1250 #9C Washington Rd', N'Rye', N'03870', N'NH', N'603-556-2335')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (20, 19, CAST(0xE8130B00 AS Date), N'abdeitrich@corp.net', N'229 Pine St Apt C', N'Portsmouth', N'03801', N'NH', N'603-556-8439')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (21, 20, CAST(0x7DF80A00 AS Date), N'ersamuels@corp.net', N'63 Bartlett St', N'Portstmouth', N'03801', N'NH', N'603-865-4646')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (22, 21, CAST(0x3D000B00 AS Date), N'rdterry@corp.net', N'15 Whipple St', N'Portsmouth', N'03801', N'NH', N'603-865-2112')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (23, 22, CAST(0x0AEA0A00 AS Date), N'mawhitaker@corp.net', N'65 Whipple St', N'Portsmouth', N'03801', N'NH', N'603-865-3523')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (24, 23, CAST(0xD3020B00 AS Date), N'alclark@corp.net', N'461 Little Bay Rd', N'Newington', N'03805', N'NH', N'603-556-4515')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (25, 24, CAST(0xAD100B00 AS Date), N'embell@corp.net', N'322 Fox Point Rd', N'Newington', N'03805', N'NH', N'603-556-5223')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (26, 25, CAST(0x75090B00 AS Date), N'ckpeyton@corp.net', N'55 Osprey Dr', N'Newington', N'03805', N'NH', N'603-581-2645')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (27, 26, CAST(0x1E000B00 AS Date), N'lzchance@corp.net', N'455 Spinnaker Way', N'Newington', N'03805', N'NH', N'603-554-5823')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (28, 27, CAST(0x02F40A00 AS Date), N'ebtaylor@corp.net', N'32 Shearwater Dr', N'Newington', N'03805', N'NH', N'603-452-6614')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (29, 28, CAST(0xFFFF0A00 AS Date), N'gtchristopherson@corp.net', N'99 Ashland St', N'Portsmouth', N'03801', N'NH', N'603-234-6653')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (30, 29, CAST(0x1F0D0B00 AS Date), N'cbvictorson@corp.net', N'4 Ruth St', N'Portsmouth', N'03801', N'NH', N'603-246-5124')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (31, 30, CAST(0x95060B00 AS Date), N'slmartins@corp.net', N'34 Myrtle Ave', N'Portsmouth', N'03801', N'NH', N'603-321-5626')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (32, 31, CAST(0x85F00A00 AS Date), N'tbhampton@corp.net', N'132 Columbia St', N'Portsmouth', N'03801', N'NH', N'603-554-7531')
INSERT INTO EmployeeInfo (EInfoID, EmployeeID, DOB, EEmail, EAddress, ECity, Zip, EState, EPhone) VALUES (33, 32, CAST(0x4F0A0B00 AS Date), N'dfdaniell@corp.net', N'22 Austin St', N'Portsmouth', N'03801', N'NH', N'603-544-2615')

SET IDENTITY_INSERT EmployeeInfo OFF
GO

