USE master

IF DB_ID('finalDB') IS NOT NULL
	DROP DATABASE finalDB
GO

CREATE DATABASE finalDB
GO

USE finalDB

CREATE TABLE departments(
	dept_id			int				NOT NULL 
		IDENTITY(1,1) PRIMARY KEY,

	dept_name		varchar(100)	NOT NULL 
		UNIQUE,
)

CREATE TABLE dept_pos(
	pos_id			int				NOT NULL
		IDENTITY(1,1) PRIMARY KEY,

	dept_id			int				NOT NULL
		FOREIGN KEY REFERENCES departments(dept_id)
		ON DELETE CASCADE,

	pos_name		varchar(100)	NOT NULL,
	pos_desc		varchar(255)	NOT NULL,

	CONSTRAINT deptposlink UNIQUE(pos_id, dept_id)
)

CREATE TABLE emp_base(
	emp_id			int				NOT NULL 
		IDENTITY(1,1) PRIMARY KEY,

	emp_uname		varchar(50)		NOT NULL 
		UNIQUE,

	emp_lname		nvarchar(100)	NOT NULL,
	emp_mi			char(1)			NOT NULL,
	emp_fname		nvarchar(100)	NOT NULL,
	emp_dofh		date			NOT NULL 
		DEFAULT GETDATE(),

	emp_dept		int				NOT NULL 
		FOREIGN KEY REFERENCES departments(dept_id),
	
	emp_position	int				NOT NULL
		FOREIGN KEY REFERENCES dept_pos(pos_id),

	emp_contract	bit				NOT NULL
		DEFAULT 0
)

CREATE TABLE linkdeptemp(
	pos_id			int				NOT NULL
		FOREIGN KEY REFERENCES dept_pos(pos_id)
		ON DELETE CASCADE,

	emp_id			int				NOT NULL
		FOREIGN KEY REFERENCES emp_base(emp_id)
		ON DELETE CASCADE,

	CONSTRAINT dp2elink PRIMARY KEY(pos_id, emp_id)
)

CREATE TABLE emp_wages(
	empw_id			int				NOT NULL
		FOREIGN KEY REFERENCES emp_base(emp_id)
		ON DELETE CASCADE,

	empw_ishourly	bit				NOT NULL
		DEFAULT 1,

	empw_wage		decimal(12,2)	NOT NULL
		DEFAULT 7.25,

	empw_salary		decimal(12,2)	NULL,
	empw_iscom		bit				NOT NULL
		DEFAULT 0,

	empw_comperc	decimal(3,2)	NULL,
	empw_combase	int				NULL,

	empw_isbonus	bit				NOT NULL
		DEFAULT 0,

	empw_bonus		int				NULL,

	CONSTRAINT chk_wages CHECK (empw_ishourly=1 AND empw_wage >= 7.25),
	CONSTRAINT chk_salary CHECK (empw_ishourly=0 AND empw_salary > 0),
	CONSTRAINT chk_bonus CHECK (empw_isbonus=1 AND empw_bonus > 0)
)

CREATE TABLE projects(
	proj_id			int				NOT NULL
		IDENTITY(1,1) PRIMARY KEY,

	proj_name		varchar(100)	NOT NULL,
	proj_desc		varchar(2048)	NOT NULL
)

CREATE TABLE proj_pos(
	projpos_id		int				NOT NULL
		IDENTITY(1,1) PRIMARY KEY,

	proj_id		int				NOT NULL
		FOREIGN KEY REFERENCES projects(proj_id)
		ON DELETE CASCADE,

	projpos_name	varchar(100)	NOT NULL,
	projpos_desc	varchar(512)	NOT NULL,

	CONSTRAINT projposlink UNIQUE(projpos_id, proj_id)
)

CREATE TABLE linkprojemp(
	emp_id			int				NOT NULL
		FOREIGN KEY REFERENCES emp_base(emp_id)
		ON DELETE CASCADE,

	projpos_id		int				NOT NULL
		FOREIGN KEY REFERENCES proj_pos(projpos_id)
		ON DELETE CASCADE,

	CONSTRAINT e2pplink PRIMARY KEY (emp_id, projpos_id)
)
GO

CREATE PROCEDURE InsertEmployee
	@emp_uname varchar(50),
	@emp_lname nvarchar(100),
	@emp_mi char(1),
	@emp_fname nvarchar(100),
	@emp_doh date,
	@emp_dept int,
	@emp_pos int,
	@emp_cont bit,
	@id int out
AS
	SET NOCOUNT ON;
	INSERT INTO emp_base (emp_uname, emp_lname, emp_mi, emp_fname, emp_dofh, emp_dept, emp_position, emp_contract)
	VALUES (@emp_uname, @emp_lname, @emp_mi, @emp_fname, @emp_doh, @emp_dept, @emp_pos, @emp_cont)
	SET @id = SCOPE_IDENTITY()
GO

CREATE PROCEDURE InsertProjectBase
	@projname varchar(100),
	@projdesc varchar(2048),
	@id int out
AS
	SET NOCOUNT ON;
	INSERT INTO projects (proj_name, proj_desc) VALUES (@projname, @projdesc)
	SET @id = SCOPE_IDENTITY()
GO

CREATE PROCEDURE InsertProjectPosition
	@projid int,
	@projposname varchar(100),
	@projposdesc varchar(512),
	@id int out
AS
	SET NOCOUNT ON;
	INSERT INTO proj_pos (proj_id, projpos_name, projpos_desc)
	VALUES (@projid, @projposname, @projposdesc)
	SET @id = SCOPE_IDENTITY()
GO

CREATE PROCEDURE InsertEmpToProject
	@empid int,
	@projpos int
AS
	SET NOCOUNT ON;
	INSERT INTO linkprojemp (emp_id, projpos_id)
	VALUES (@empid, @projpos)
GO

CREATE PROCEDURE DeleteProjectBase
	@id int
AS
	DELETE FROM projects WHERE proj_id = @id
GO

CREATE PROCEDURE DeleteProjectPosition
	@id int
AS
	DELETE FROM proj_pos WHERE projpos_id = @id
GO

CREATE PROCEDURE DeleteEmpFromProj
	@id int
AS
	DELETE FROM linkprojemp WHERE emp_id = @id
GO


	