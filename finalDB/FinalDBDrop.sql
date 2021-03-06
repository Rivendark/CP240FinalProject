USE [master]
GO
/****** Object:  Database [finalDB]    Script Date: 11/7/2013 11:36:49 PM ******/
CREATE DATABASE [finalDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'finalDB', FILENAME = N'F:\MSSQLSERVER\MSSQL11.MSSQLSERVER\MSSQL\DATA\finalDB.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'finalDB_log', FILENAME = N'F:\MSSQLSERVER\MSSQL11.MSSQLSERVER\MSSQL\DATA\finalDB_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [finalDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [finalDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [finalDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [finalDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [finalDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [finalDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [finalDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [finalDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [finalDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [finalDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [finalDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [finalDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [finalDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [finalDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [finalDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [finalDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [finalDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [finalDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [finalDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [finalDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [finalDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [finalDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [finalDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [finalDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [finalDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [finalDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [finalDB] SET  MULTI_USER 
GO
ALTER DATABASE [finalDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [finalDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [finalDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [finalDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [finalDB]
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmpFromProj]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteEmpFromProj]
	@id int
AS
	DELETE FROM linkprojemp WHERE emp_id = @id

GO
/****** Object:  StoredProcedure [dbo].[DeleteProjectBase]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteProjectBase]
	@id int
AS
	DELETE FROM projects WHERE proj_id = @id

GO
/****** Object:  StoredProcedure [dbo].[DeleteProjectPosition]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteProjectPosition]
	@id int
AS
	DELETE FROM proj_pos WHERE projpos_id = @id

GO
/****** Object:  StoredProcedure [dbo].[InsertEmployee]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertEmployee]
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
/****** Object:  StoredProcedure [dbo].[InsertEmpToProject]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertEmpToProject]
	@empid int,
	@projpos int
AS
	SET NOCOUNT ON;
	INSERT INTO linkprojemp (emp_id, projpos_id)
	VALUES (@empid, @projpos)

GO
/****** Object:  StoredProcedure [dbo].[InsertProjectBase]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertProjectBase]
	@projname varchar(100),
	@projdesc varchar(2048),
	@id int out
AS
	SET NOCOUNT ON;
	INSERT INTO projects (proj_name, proj_desc) VALUES (@projname, @projdesc)
	SET @id = SCOPE_IDENTITY()

GO
/****** Object:  StoredProcedure [dbo].[InsertProjectPosition]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertProjectPosition]
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
/****** Object:  Table [dbo].[departments]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[departments](
	[dept_id] [int] IDENTITY(1,1) NOT NULL,
	[dept_name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[dept_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dept_pos]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dept_pos](
	[pos_id] [int] IDENTITY(1,1) NOT NULL,
	[dept_id] [int] NOT NULL,
	[pos_name] [varchar](100) NOT NULL,
	[pos_desc] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pos_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[emp_base]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[emp_base](
	[emp_id] [int] IDENTITY(1,1) NOT NULL,
	[emp_uname] [varchar](50) NOT NULL,
	[emp_lname] [nvarchar](100) NOT NULL,
	[emp_mi] [char](1) NOT NULL,
	[emp_fname] [nvarchar](100) NOT NULL,
	[emp_dofh] [date] NOT NULL,
	[emp_dept] [int] NOT NULL,
	[emp_position] [int] NOT NULL,
	[emp_contract] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[emp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[emp_wages]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[emp_wages](
	[empw_id] [int] NOT NULL,
	[empw_ishourly] [bit] NOT NULL,
	[empw_wage] [decimal](12, 2) NOT NULL,
	[empw_salary] [decimal](12, 2) NULL,
	[empw_iscom] [bit] NOT NULL,
	[empw_comperc] [decimal](3, 2) NULL,
	[empw_combase] [int] NULL,
	[empw_isbonus] [bit] NOT NULL,
	[empw_bonus] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[linkdeptemp]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[linkdeptemp](
	[pos_id] [int] NOT NULL,
	[emp_id] [int] NOT NULL,
 CONSTRAINT [dp2elink] PRIMARY KEY CLUSTERED 
(
	[pos_id] ASC,
	[emp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[linkprojemp]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[linkprojemp](
	[emp_id] [int] NOT NULL,
	[projpos_id] [int] NOT NULL,
 CONSTRAINT [e2pplink] PRIMARY KEY CLUSTERED 
(
	[emp_id] ASC,
	[projpos_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[proj_pos]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[proj_pos](
	[projpos_id] [int] IDENTITY(1,1) NOT NULL,
	[proj_id] [int] NOT NULL,
	[projpos_name] [varchar](100) NOT NULL,
	[projpos_desc] [varchar](512) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[projpos_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[projects]    Script Date: 11/7/2013 11:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[projects](
	[proj_id] [int] IDENTITY(1,1) NOT NULL,
	[proj_name] [varchar](100) NOT NULL,
	[proj_desc] [varchar](2048) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[proj_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[departments] ON 

INSERT [dbo].[departments] ([dept_id], [dept_name]) VALUES (1, N'Administration')
INSERT [dbo].[departments] ([dept_id], [dept_name]) VALUES (2, N'Engineering')
INSERT [dbo].[departments] ([dept_id], [dept_name]) VALUES (4, N'Human Resources')
INSERT [dbo].[departments] ([dept_id], [dept_name]) VALUES (7, N'Information Technology')
INSERT [dbo].[departments] ([dept_id], [dept_name]) VALUES (5, N'Quality Assurance')
INSERT [dbo].[departments] ([dept_id], [dept_name]) VALUES (3, N'Research & Development')
INSERT [dbo].[departments] ([dept_id], [dept_name]) VALUES (6, N'Sales')
SET IDENTITY_INSERT [dbo].[departments] OFF
SET IDENTITY_INSERT [dbo].[dept_pos] ON 

INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (1, 1, N'C.E.O.', N'Chief Executive Officer')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (2, 1, N'C.F.O.', N'Cheif Fincial Officer')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (3, 1, N'C.O.O.', N'Cheif Operations Officer')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (4, 2, N'Administrator', N'Administrator - Engineering Department')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (7, 2, N'Assistant Administrator', N'Assistant Administrator - Engineering Department')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (8, 2, N'Engineer', N'Engineer - Engineering Department')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (9, 3, N'Administrator', N'Administrator - Research & Developement')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (10, 3, N'Assistant Adminstrator', N'Assistant Administrator - Research & Developement')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (11, 3, N'Lead Researcher', N'Lead Researcher - Research & Developement')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (12, 3, N'Researcher', N'Researcher - Research & Developement')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (13, 4, N'Administrator', N'Administrator - Human Resources')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (14, 4, N'Assistant Administrator', N'Assistant Administrator - Human Resources')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (15, 4, N'Legal Advisor', N'Legal Advisor - Human Resources')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (16, 4, N'Secretary', N'Secretary - Human Resources')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (17, 5, N'Administrator', N'Administrator - Quality Assurance')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (18, 5, N'Tester', N'Tester - Quality Assurance')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (19, 6, N'Administrator', N'Administrator - Sales')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (20, 6, N'Lead Salesman', N'Lead Salesman - Sales')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (21, 6, N'Salesman', N'Salesman - Sales')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (22, 7, N'Administrator', N'Administrator - Information Technology')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (23, 7, N'Assistant Administrator', N'Assistant Administrator - Information Technology')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (24, 7, N'Lead Support', N'Lead Support - Information Technology')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (25, 7, N'Support', N'Support - Information Technology')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (26, 7, N'Technician', N'Technicial - Information Technology')
INSERT [dbo].[dept_pos] ([pos_id], [dept_id], [pos_name], [pos_desc]) VALUES (27, 7, N'Help Desk Support', N'Help Desk Support - Information Technology')
SET IDENTITY_INSERT [dbo].[dept_pos] OFF
SET IDENTITY_INSERT [dbo].[emp_base] ON 

INSERT [dbo].[emp_base] ([emp_id], [emp_uname], [emp_lname], [emp_mi], [emp_fname], [emp_dofh], [emp_dept], [emp_position], [emp_contract]) VALUES (1, N'addrew', N'Drew', N'D', N'Adam', CAST(0xCA370B00 AS Date), 1, 1, 0)
SET IDENTITY_INSERT [dbo].[emp_base] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__departme__C7D39AE1FDC56A61]    Script Date: 11/7/2013 11:36:49 PM ******/
ALTER TABLE [dbo].[departments] ADD UNIQUE NONCLUSTERED 
(
	[dept_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [deptposlink]    Script Date: 11/7/2013 11:36:49 PM ******/
ALTER TABLE [dbo].[dept_pos] ADD  CONSTRAINT [deptposlink] UNIQUE NONCLUSTERED 
(
	[pos_id] ASC,
	[dept_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__emp_base__568FC715D8A9E09A]    Script Date: 11/7/2013 11:36:49 PM ******/
ALTER TABLE [dbo].[emp_base] ADD UNIQUE NONCLUSTERED 
(
	[emp_uname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [projposlink]    Script Date: 11/7/2013 11:36:49 PM ******/
ALTER TABLE [dbo].[proj_pos] ADD  CONSTRAINT [projposlink] UNIQUE NONCLUSTERED 
(
	[projpos_id] ASC,
	[proj_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[emp_base] ADD  DEFAULT (getdate()) FOR [emp_dofh]
GO
ALTER TABLE [dbo].[emp_base] ADD  DEFAULT ((0)) FOR [emp_contract]
GO
ALTER TABLE [dbo].[emp_wages] ADD  DEFAULT ((1)) FOR [empw_ishourly]
GO
ALTER TABLE [dbo].[emp_wages] ADD  DEFAULT ((7.25)) FOR [empw_wage]
GO
ALTER TABLE [dbo].[emp_wages] ADD  DEFAULT ((0)) FOR [empw_iscom]
GO
ALTER TABLE [dbo].[emp_wages] ADD  DEFAULT ((0)) FOR [empw_isbonus]
GO
ALTER TABLE [dbo].[dept_pos]  WITH CHECK ADD FOREIGN KEY([dept_id])
REFERENCES [dbo].[departments] ([dept_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[emp_base]  WITH CHECK ADD FOREIGN KEY([emp_dept])
REFERENCES [dbo].[departments] ([dept_id])
GO
ALTER TABLE [dbo].[emp_base]  WITH CHECK ADD FOREIGN KEY([emp_position])
REFERENCES [dbo].[dept_pos] ([pos_id])
GO
ALTER TABLE [dbo].[emp_wages]  WITH CHECK ADD FOREIGN KEY([empw_id])
REFERENCES [dbo].[emp_base] ([emp_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[linkdeptemp]  WITH CHECK ADD FOREIGN KEY([emp_id])
REFERENCES [dbo].[emp_base] ([emp_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[linkdeptemp]  WITH CHECK ADD FOREIGN KEY([pos_id])
REFERENCES [dbo].[dept_pos] ([pos_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[linkprojemp]  WITH CHECK ADD FOREIGN KEY([emp_id])
REFERENCES [dbo].[emp_base] ([emp_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[linkprojemp]  WITH CHECK ADD FOREIGN KEY([projpos_id])
REFERENCES [dbo].[proj_pos] ([projpos_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[proj_pos]  WITH CHECK ADD FOREIGN KEY([proj_id])
REFERENCES [dbo].[projects] ([proj_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[emp_wages]  WITH CHECK ADD  CONSTRAINT [chk_bonus] CHECK  (([empw_isbonus]=(1) AND [empw_bonus]>(0)))
GO
ALTER TABLE [dbo].[emp_wages] CHECK CONSTRAINT [chk_bonus]
GO
ALTER TABLE [dbo].[emp_wages]  WITH CHECK ADD  CONSTRAINT [chk_salary] CHECK  (([empw_ishourly]=(0) AND [empw_salary]>(0)))
GO
ALTER TABLE [dbo].[emp_wages] CHECK CONSTRAINT [chk_salary]
GO
ALTER TABLE [dbo].[emp_wages]  WITH CHECK ADD  CONSTRAINT [chk_wages] CHECK  (([empw_ishourly]=(1) AND [empw_wage]>=(7.25)))
GO
ALTER TABLE [dbo].[emp_wages] CHECK CONSTRAINT [chk_wages]
GO
USE [master]
GO
ALTER DATABASE [finalDB] SET  READ_WRITE 
GO
