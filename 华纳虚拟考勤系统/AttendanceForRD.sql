USE [master]
GO
/****** Object:  Database [AttendanceForRD]    Script Date: 2025/03/21 11:50:42 ******/
CREATE DATABASE [AttendanceForRD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AttendanceForRD', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\AttendanceForRD.mdf' , SIZE = 49152KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AttendanceForRD_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\AttendanceForRD_log.ldf' , SIZE = 3164032KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [AttendanceForRD] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AttendanceForRD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AttendanceForRD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AttendanceForRD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AttendanceForRD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AttendanceForRD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AttendanceForRD] SET ARITHABORT OFF 
GO
ALTER DATABASE [AttendanceForRD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AttendanceForRD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AttendanceForRD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AttendanceForRD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AttendanceForRD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AttendanceForRD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AttendanceForRD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AttendanceForRD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AttendanceForRD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AttendanceForRD] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AttendanceForRD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AttendanceForRD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AttendanceForRD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AttendanceForRD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AttendanceForRD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AttendanceForRD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AttendanceForRD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AttendanceForRD] SET RECOVERY FULL 
GO
ALTER DATABASE [AttendanceForRD] SET  MULTI_USER 
GO
ALTER DATABASE [AttendanceForRD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AttendanceForRD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AttendanceForRD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AttendanceForRD] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [AttendanceForRD] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'AttendanceForRD', N'ON'
GO
USE [AttendanceForRD]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAttendanceDays]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date, ,>
-- Description:	获取出勤总天数
-- =============================================
CREATE FUNCTION [dbo].[GetAttendanceDays] 
(
	@EmployeeNo varchar(50),
	@sYear int,
	@sMonth int
)
RETURNS numeric(10,1)
AS
BEGIN
	DECLARE @StartDate DateTime,@EndDate DateTime,@CurDate DateTime,@TotalDays numeric(10,1),@LeaveDays numeric(10,1)
	,@EveryDays numeric(10,1),@QuitDate DateTime,@AttendanceDays numeric(10,1),@oldLeaveDays numeric(10,1)
	DECLARE @sDate DateTime,@eDate DateTime
	SET @StartDate=Convert(DateTime,cast(@sYear as varchar(4))+'-'+cast(@sMonth as varchar(2))+'-1')
	SET @EndDate=Convert(varchar(10),dateadd(ms,-3,DATEADD(mm, DATEDIFF(m,0,@StartDate)+1, 0)),23) --上月最后一天

	--获取离职日期
	select @QuitDate=QuitDate from Employees where EmployeeNo=@EmployeeNo and QuitDate is not null
	if exists(select 1 from Employees where EmployeeNo=@EmployeeNo and QuitDate is not null)
	begin
		SET @EndDate=DateAdd(day,-1,@QuitDate)
	end

	SET @AttendanceDays=0
	SET @TotalDays=0
	SET @LeaveDays=0
	SET @CurDate=Convert(DateTime,@StartDate)
	while @CurDate<=@EndDate
	begin
		SET @EveryDays=0
		SELECT @sDate=min(StartTime),@eDate=max(EndTime),@oldLeaveDays=sum(Days) FROM Leave WHERE EmployeeNo=@EmployeeNo and @CurDate between Convert(varchar(10),StartTime,23) and EndTime
			and Year(EndTime)=@sYear and MONTH(EndTime)=@sMonth
		if exists(SELECT 1 FROM Leave WHERE EmployeeNo=@EmployeeNo and @CurDate between Convert(varchar(10),StartTime,23) and EndTime and Year(EndTime)=@sYear and MONTH(EndTime)=@sMonth)
		begin
			SELECT @EveryDays=IsNull(sum(sDays),0) FROM dbo.GetLeaveDaysList(@sDate,@eDate,@oldLeaveDays) Where Convert(DateTime,Convert(varchar(10),sDate,23))=@CurDate
		end
		SET @TotalDays=@TotalDays+1
		SET @LeaveDays=@LeaveDays+@EveryDays
		SELECT @CurDate=DateAdd(d,1,@CurDate)
	end
	SET @AttendanceDays=@TotalDays-@LeaveDays

	if exists(select 1 from Employees where EmployeeNo=@EmployeeNo and FullName in('何立军','朱勇'))
	begin
		SET @AttendanceDays=@TotalDays-4
	end

	if exists(select 1 from Employees where EmployeeNo=@EmployeeNo and FullName in('黄炜波','章朝晖'))
	begin
		SET @AttendanceDays=15
	end
	return @AttendanceDays

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetLeaveDaysList]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2021-3-30 12:25
-- Description:	获取每天的请假天数
-- =============================================
CREATE FUNCTION [dbo].[GetLeaveDaysList] 
(
    @StartDate DateTime,
    @EndDate DateTime,
	@Days numeric(10,1)
)
RETURNS @t_table TABLE(sDate DateTime,period varchar(20),sDays numeric(10,1))
AS
BEGIN
	--DECLARE @t_table TABLE(sDate DateTime,period varchar(20),sDays numeric(10,1))
	--DECLARE @StartDate DateTime,@EndDate DateTime,@Days numeric(10,1)
	--SET @StartDate='2021-08-30 14:00:00.000'
	--SET @EndDate='2021-08-31 12:00:00.000'
	--SET @Days=1
	DECLARE @period varchar(20),@LeaveDays decimal(18,1)
	DECLARE @CurDate DateTime,@sDate varchar(30),@nStartDate DateTime,@nEndDateTime DateTime,@IntervalDays int,@oldDays numeric(10,1)

	SET @oldDays=CEILING(@Days)
	SET @nStartDate=Convert(DateTime,Convert(varchar(10),@StartDate,23))
	SET @nEndDateTime=Convert(DateTime,Convert(varchar(10),@EndDate,23))
	SELECT @IntervalDays=DATEDIFF(day,@nStartDate,@nEndDateTime)+1
	SET @CurDate=@nStartDate
	while @CurDate<=@nEndDateTime
	begin
		set @sDate=@CurDate

		if @Days>0 and @Days%1=0 and @oldDays=@IntervalDays
		begin
			set @LeaveDays=1
			set @period='全天'
		end
		else
		begin
			if @CurDate<@nEndDateTime
			begin
				if @CurDate=@nStartDate
				begin
					set @sDate=@nStartDate
					if DATEPART(hh, @StartDate)>11
					begin
						set @LeaveDays=0.5
						set @period='下午'
					end
					else if @nEndDateTime=@nStartDate
					begin
						set @LeaveDays=0.5
						set @period='上午'
					end
					else
					begin
						set @LeaveDays=1
						set @period='全天'
					end
				end
				else
				begin
					set @LeaveDays=1
					set @period='全天'
				end
			end
			else
			begin
				set @sDate=@nEndDateTime
				if DATEPART(hh, @EndDate)<14
				begin
					set @LeaveDays=0.5
					set @period='上午'
				end
				else
				begin
					set @LeaveDays=0.5
					set @period='下午'
				end
			end
		end
		
		set @Days=@Days-@LeaveDays

		INSERT INTO @t_table(sDate,period,sDays) VALUES(@sDate,@period,@LeaveDays)
		SELECT @CurDate=DateAdd(d,1,@CurDate)
	end

	--SELECT * from @t_table
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetLeaveProjectNoTopCount]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	获取还没有绑定项目编号的前几行请假记录
-- =============================================
CREATE FUNCTION [dbo].[GetLeaveProjectNoTopCount] 
(	
	@EmployeeNo varchar(50),
	@sYear int,
	@sMonth int
)
RETURNS @t_table TABLE(ProjectNo varchar(50),TopCount int) 
AS
begin
	--declare @t_table TABLE(ProjectNo varchar(50),TopCount int) 
	declare @nCount int,@nRows numeric(10,3),@ProjectNo varchar(50)

	select @nCount=count(*) from OnWorkRec where EmployeeNo=@EmployeeNo and Year(WorkDate)=@sYear and Month(WorkDate)=@sMonth and Days=0
	DECLARE Pro_Cursor CURSOR FOR select ProjectNo,@nCount*Ratio/100.00 from ProjectMembers
	where IsDel=0 and EmployeeNo=@EmployeeNo and (@sYear<Year(EndDate) or(@sYear=Year(EndDate) and @sMonth<=Month(EndDate))) order by Ratio desc
	OPEN Pro_Cursor
    FETCH NEXT FROM Pro_Cursor INTO @ProjectNo,@nRows
    while @@fetch_status = 0
    begin
		if @nRows%1>=0.5
			set @nRows=CEILING(@nRows)
		else
			set @nRows=FLOOR(@nRows)

		insert into @t_table(ProjectNo,TopCount) values(@ProjectNo,@nRows)
	    FETCH NEXT FROM Pro_Cursor INTO @ProjectNo,@nRows
    end
    CLOSE Pro_Cursor
    DEALLOCATE Pro_Cursor

	return;
end

GO
/****** Object:  UserDefinedFunction [dbo].[GetNoProjectNoTopCount]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	获取还没有绑定项目编号的前几行出勤记录
-- =============================================
CREATE FUNCTION [dbo].[GetNoProjectNoTopCount] 
(	
	@EmployeeNo varchar(50),
	@sYear int,
	@sMonth int
)
RETURNS @t_table TABLE(ProjectNo varchar(50),TopCount int) 
AS
begin
	--declare @t_table TABLE(ProjectNo varchar(50),TopCount int) 
	declare @nCount int,@nRows numeric(10,3),@ProjectNo varchar(50)

	select @nCount=count(*) from OnWorkRec where EmployeeNo=@EmployeeNo and Year(WorkDate)=@sYear and Month(WorkDate)=@sMonth and Days>0 and ProjectNo is null
	DECLARE Pro_Cursor CURSOR FOR select ProjectNo,@nCount*Ratio/100.00 from ProjectMembers
	where IsDel=0 and EmployeeNo=@EmployeeNo and (@sYear<Year(EndDate) or(@sYear=Year(EndDate) and @sMonth<=Month(EndDate))) order by Ratio desc
	OPEN Pro_Cursor
    FETCH NEXT FROM Pro_Cursor INTO @ProjectNo,@nRows
    while @@fetch_status = 0
    begin
		if @nRows%1>=0.5
			set @nRows=CEILING(@nRows)
		else
			set @nRows=FLOOR(@nRows)

		insert into @t_table(ProjectNo,TopCount) values(@ProjectNo,@nRows)
	    FETCH NEXT FROM Pro_Cursor INTO @ProjectNo,@nRows
    end
    CLOSE Pro_Cursor
    DEALLOCATE Pro_Cursor

	return;
end

GO
/****** Object:  UserDefinedFunction [dbo].[GetProjectNoTopCount]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	获取每一个项目的前几行出勤记录(每个项目间隔2天)
-- =============================================
CREATE FUNCTION [dbo].[GetProjectNoTopCount] 
(	
	@EmployeeNo varchar(50),
	@sYear int,
	@sMonth int
)
RETURNS @t_table1 TABLE(RowNo int,ProjectNo varchar(50),TopCount int) 
AS
begin
	declare @t_table TABLE(RowNo int,ProjectNo varchar(50),TopCount int) 
	declare @FactDays numeric(10,1),@nRows numeric(10,3),@iRow int

	select @FactDays=sum(Days) from OnWorkRec where EmployeeNo=@EmployeeNo and Year(WorkDate)=@sYear and Month(WorkDate)=@sMonth and Days>0
	select TOP 1 @nRows=@FactDays*Ratio/100/3 from ProjectMembers where IsDel=0 and EmployeeNo=@EmployeeNo and (@sYear<Year(EndDate) or(@sYear=Year(EndDate) and @sMonth<=Month(EndDate))) order by Ratio desc
	if @nRows%1>0.7
		set @nRows=CEILING(@nRows)
	else
		set @nRows=FLOOR(@nRows)

	set @iRow=1
	while @iRow<=@nRows
	begin
		insert into @t_table(RowNo,ProjectNo,TopCount)
		select @iRow as RowNo,ProjectNo,round((@FactDays*Ratio/100),0,1)*2-((@iRow-1)*6) as TopCount from ProjectMembers 
		where IsDel=0 and EmployeeNo=@EmployeeNo and (@sYear<Year(EndDate) or(@sYear=Year(EndDate) and @sMonth<=Month(EndDate))) order by Ratio desc
		set @iRow=@iRow+1
	end
	
	--每个项目间隔2天
	insert into @t_table1 select RowNo,ProjectNo,case when TopCount>4 then 4 else TopCount end as TopCount
	from @t_table where TopCount>0
	return;
end

GO
/****** Object:  Table [dbo].[Employees]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrgName] [nvarchar](50) NULL,
	[Department] [nvarchar](30) NULL,
	[EmployeeNo] [nvarchar](50) NULL,
	[FullName] [nvarchar](30) NULL,
	[Sex] [nvarchar](20) NULL,
	[IDNo] [nvarchar](50) NULL,
	[BirthDate] [date] NULL,
	[Education] [nvarchar](30) NULL,
	[Speciality] [nvarchar](50) NULL,
	[Station] [nvarchar](50) NULL,
	[EntryDate] [datetime] NULL,
	[QuitDate] [datetime] NULL,
	[EmployeeType] [nvarchar](30) NULL,
	[Status] [nvarchar](20) NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Leave]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Leave](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrgName] [nvarchar](50) NULL,
	[Department] [nvarchar](50) NULL,
	[EmployeeNo] [nvarchar](30) NULL,
	[FullName] [nvarchar](30) NULL,
	[LeaveType] [nvarchar](30) NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Hours] [numeric](18, 0) NULL,
	[Days] [numeric](18, 1) NULL,
	[Reason] [nvarchar](240) NULL,
	[Status] [int] NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_Leave] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OnWorkRec]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OnWorkRec](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectNo] [nvarchar](50) NULL,
	[EmployeeNo] [nvarchar](30) NULL,
	[FullName] [nvarchar](30) NULL,
	[WorkDate] [datetime] NULL,
	[Period] [nvarchar](10) NULL,
	[Days] [numeric](18, 1) NULL,
	[OnDesc] [nvarchar](30) NULL,
	[Remark] [nvarchar](200) NULL,
	[Status] [int] NULL,
	[Creator] [nvarchar](30) NULL,
	[CreateTime] [datetime] NULL,
	[Updater] [nvarchar](30) NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_OnWorkRec] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OnWorkRecForTest]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OnWorkRecForTest](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectNo] [nvarchar](50) NULL,
	[EmployeeNo] [nvarchar](30) NULL,
	[FullName] [nvarchar](30) NULL,
	[WorkDate] [datetime] NULL,
	[Period] [nvarchar](10) NULL,
	[Days] [numeric](18, 1) NULL,
	[OnDesc] [nvarchar](30) NULL,
	[Remark] [nvarchar](200) NULL,
	[Status] [int] NULL,
	[Creator] [nvarchar](30) NULL,
	[CreateTime] [datetime] NULL,
	[Updater] [nvarchar](30) NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_OnWorkRecForTest] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectAttenSum]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectAttenSum](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrgName] [nvarchar](50) NULL,
	[ProjectNo] [nvarchar](50) NULL,
	[ProjectName] [nvarchar](200) NULL,
	[ProjectTitle] [nvarchar](250) NULL,
	[JobContent] [nvarchar](30) NULL,
	[EmployeeNo] [nvarchar](50) NULL,
	[FullName] [nvarchar](30) NULL,
	[IsFull] [nvarchar](20) NULL,
	[sYear] [int] NULL,
	[sMonth] [int] NULL,
	[WorkDays] [numeric](18, 1) NULL,
	[ProjectDays] [numeric](18, 1) NULL,
	[Ratio] [numeric](18, 2) NULL,
	[Creator] [nvarchar](30) NULL,
	[CreateTime] [datetime] NULL,
	[Updater] [nvarchar](30) NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_ProjectAttenSum] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectChange]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectChange](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectNo] [nvarchar](50) NULL,
	[ProjectName] [nvarchar](100) NULL,
	[ChangeDate] [datetime] NULL,
	[OrgName] [nvarchar](100) NULL,
	[ChangeCount] [int] NULL,
	[ChangeOptions] [nvarchar](200) NULL,
	[ProjectName_old] [nvarchar](100) NULL,
	[ProjectName_new] [nvarchar](100) NULL,
	[StartDate_old] [datetime] NULL,
	[StartDate_new] [datetime] NULL,
	[EndDate_old] [datetime] NULL,
	[EndDate_new] [datetime] NULL,
	[Charger_old] [nvarchar](20) NULL,
	[Charger_new] [nvarchar](20) NULL,
	[MemberChange] [nvarchar](max) NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_ProjectChange] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectMembers]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectMembers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectNo] [nvarchar](50) NULL,
	[EmployeeNo] [nvarchar](30) NULL,
	[FullName] [nvarchar](30) NULL,
	[JobContent] [nvarchar](50) NULL,
	[Ratio] [int] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[IsFull] [nvarchar](10) NULL,
	[IsDel] [int] NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_ProjectMembers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectNo] [nvarchar](50) NULL,
	[ProjectName] [nvarchar](200) NULL,
	[OrgName] [nvarchar](50) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Charger] [nvarchar](30) NULL,
	[GroupLeader] [nvarchar](30) NULL,
	[Status] [int] NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectTestMembers]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectTestMembers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectNo] [nvarchar](50) NULL,
	[EmployeeNo] [nvarchar](30) NULL,
	[FullName] [nvarchar](30) NULL,
	[ProductName] [nvarchar](100) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_ProjectTestMembers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SysLog]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](30) NULL,
	[logContent] [nvarchar](220) NULL,
	[logTime] [datetime] NULL,
 CONSTRAINT [PK_SysLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SysPer]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysPer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[code] [nvarchar](20) NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_SysPer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SysUser]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](30) NULL,
	[password] [nvarchar](50) NULL,
	[userPers] [nvarchar](200) NULL,
 CONSTRAINT [PK_SysUser] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_AllMembers]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_AllMembers]
AS
select ProjectNo,EmployeeNo,FullName,StartDate,EndDate from ProjectTestMembers
union
select ProjectNo,EmployeeNo,FullName,StartDate,EndDate from ProjectMembers where IsDel=0




GO
/****** Object:  View [dbo].[v_Department]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_Department]
AS
select *,case when OrgName='华纳股份' then 1 else 2 end as OrgNo 
from
(
select distinct OrgName,Department from employees where Department!=''
) a 

GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ProjectAttenSum]    Script Date: 2025/03/21 11:50:42 ******/
CREATE NONCLUSTERED INDEX [IX_ProjectAttenSum] ON [dbo].[ProjectAttenSum]
(
	[ProjectNo] ASC,
	[sYear] ASC,
	[sMonth] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProjectMembers] ADD  CONSTRAINT [DF_ProjectMembers_IsDel]  DEFAULT ((0)) FOR [IsDel]
GO
/****** Object:  StoredProcedure [dbo].[CalOnWorkRecForProject]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	计算生成项目考勤记录
-- =============================================
CREATE PROCEDURE [dbo].[CalOnWorkRecForProject] 
(
	@sYear int,
	@sMonth int
)
AS
BEGIN
	SET NOCOUNT ON;

	--指定个别领导周末休息
	exec UpdateIndividualEmpForLeave @sYear,@sMonth

    DECLARE @EmployeeNo varchar(50),@FullName varchar(30)
	DECLARE Emp_Cursor CURSOR FOR select EmployeeNo,FullName from OnWorkRec where Year(Workdate)=@sYear and Month(WorkDate)=@sMonth group by EmployeeNo,FullName
	OPEN Emp_Cursor
    FETCH NEXT FROM Emp_Cursor INTO @EmployeeNo,@FullName
    while @@fetch_status = 0
    begin
		--间隔3天一个项目考勤
		exec UpdateOnWorkForProjectNo @EmployeeNo,@sYear,@sMonth
		--不按3天间隔剩下项目考勤,这个必须在UpdateOnWorkForProjectNo过程的后面执行
		exec UpdateOnWorkForNoProjectNo @EmployeeNo,@sYear,@sMonth
		--请假记录的项目考勤
		exec UpdateOnWorkForLeaveProjectNo @EmployeeNo,@sYear,@sMonth
	    FETCH NEXT FROM Emp_Cursor INTO @EmployeeNo,@FullName
    end
    CLOSE Emp_Cursor
    DEALLOCATE Emp_Cursor

	--清除无用记录
	delete from OnWorkRec where ProjectNo is null and year(workdate)=@sYear and month(workdate)=@sMonth
END

GO
/****** Object:  StoredProcedure [dbo].[CalProjectAttenSum]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		唐毓师
-- Create date: 2021-4-19 12:00
-- Description:	计算研发人员每月考勤汇总
-- =============================================
CREATE PROCEDURE [dbo].[CalProjectAttenSum] 
(
	@sYear int,
	@sMonth int
)
AS
BEGIN
	SET NOCOUNT ON
	--DECLARE @sYear int,@sMonth int
	--SET @Year=2021
	--SET @Month=7
	DECLARE @OrgName varchar(50),@EmployeeNo varchar(50),@FullName varchar(30),@WorkDays numeric(18,1),@Ratio numeric(10,2)
	DECLARE @ProjectNo varchar(50),@ProjectName varchar(200),@ProjectTitle varchar(250),@JobContent varchar(30),@IsFull varchar(20),@ProjectDays numeric(18,1)
		
    DECLARE Emp_Cursor CURSOR FOR select EmployeeNo,FullName,ProjectNo,sum(Days) as ProjectDays from OnWorkRec 
	where ProjectNo is not null and Year(WorkDate)=@sYear and Month(WorkDate)=@sMonth 
	group by ProjectNo,EmployeeNo,FullName
	OPEN Emp_Cursor
    FETCH NEXT FROM Emp_Cursor INTO @EmployeeNo,@FullName,@ProjectNo,@ProjectDays
    while @@fetch_status = 0
    begin
		SELECT @ProjectTitle=b.ProjectName+'('+cast(Year(b.StartDate) as varchar(4))+'.'+cast(Month(b.StartDate) as varchar(2))+'-'+cast(Year(b.EndDate) as varchar(4))+'.'+cast(Month(b.EndDate) as varchar(2))+')' 
		,@JobContent=case when JobContent='全面负责' then '项目负责人' else '项目成员' end
		,@IsFull=a.IsFull,@ProjectName=b.ProjectName,@OrgName=b.OrgName  
		FROM ProjectMembers a inner join Projects b on b.ProjectNo=a.ProjectNo 
		WHERE EmployeeNo=@EmployeeNo and a.ProjectNo=@ProjectNo

		SET @WorkDays=dbo.GetAttendanceDays(@EmployeeNo,@sYear,@sMonth)
		if @WorkDays>0  SET @Ratio=@ProjectDays/@WorkDays*100
			
		--插入表中
		if not exists(select 1 from ProjectAttenSum where ProjectNo=@ProjectNo and EmployeeNo=@EmployeeNo and sYear=@sYear and sMonth=@sMonth)
		begin
			insert into ProjectAttenSum(OrgName,ProjectNo,ProjectName,ProjectTitle,JobContent,EmployeeNo,FullName,IsFull,sYear,sMonth,WorkDays,ProjectDays,Ratio,Creator,CreateTime)
			values(@OrgName,@ProjectNo,@ProjectName,@ProjectTitle,@JobContent,@EmployeeNo,@FullName,@IsFull,@sYear,@sMonth,@WorkDays,@ProjectDays,@Ratio,'系统',getdate())
		end
		else
		begin
			update ProjectAttenSum set OrgName=@OrgName,ProjectName=@ProjectName,ProjectTitle=@ProjectTitle,JobContent=@JobContent,IsFull=@IsFull,WorkDays=@WorkDays,ProjectDays=@ProjectDays,Ratio=@Ratio 
			where ProjectNo=@ProjectNo and EmployeeNo=@EmployeeNo and sYear=@sYear and sMonth=@sMonth
		end
	    FETCH NEXT FROM Emp_Cursor INTO @EmployeeNo,@FullName,@ProjectNo,@ProjectDays
    end
    CLOSE Emp_Cursor
    DEALLOCATE Emp_Cursor

	DECLARE Test_Cursor CURSOR FOR select EmployeeNo,FullName,ProjectNo,sum(Days) as ProjectDays 
	from OnWorkRecForTest where Year(WorkDate)=@sYear and Month(WorkDate)=@sMonth 
	group by EmployeeNo,FullName,ProjectNo order by ProjectNo
	OPEN Test_Cursor
    FETCH NEXT FROM Test_Cursor INTO @EmployeeNo,@FullName,@ProjectNo,@ProjectDays
    while @@fetch_status = 0
    begin
		SELECT @ProjectTitle=b.ProjectName+'('+cast(Year(b.StartDate) as varchar(4))+'.'+cast(Month(b.StartDate) as varchar(2))+'-'+cast(Year(b.EndDate) as varchar(4))+'.'+cast(Month(b.EndDate) as varchar(2))+')' 
		,@JobContent='中试人员',@IsFull='否',@ProjectName=b.ProjectName,@OrgName=b.OrgName  
		FROM ProjectTestMembers a inner join Projects b on b.ProjectNo=a.ProjectNo 
		WHERE EmployeeNo=@EmployeeNo and a.ProjectNo=@ProjectNo

		SET @WorkDays=dbo.GetAttendanceDays(@EmployeeNo,@sYear,@sMonth)
		if @WorkDays>0  SET @Ratio=@ProjectDays/@WorkDays*100
			
		--插入表中
		if not exists(select 1 from ProjectAttenSum where ProjectNo=@ProjectNo and EmployeeNo=@EmployeeNo and sYear=@sYear and sMonth=@sMonth)
		begin
			insert into ProjectAttenSum(OrgName,ProjectNo,ProjectName,ProjectTitle,JobContent,EmployeeNo,FullName,IsFull,sYear,sMonth,WorkDays,ProjectDays,Ratio,Creator,CreateTime)
			values(@OrgName,@ProjectNo,@ProjectName,@ProjectTitle,@JobContent,@EmployeeNo,@FullName,@IsFull,@sYear,@sMonth,@WorkDays,@ProjectDays,@Ratio,'系统',getdate())
		end
		else
		begin
			update ProjectAttenSum set OrgName=@OrgName,ProjectName=@ProjectName,ProjectTitle=@ProjectTitle,JobContent=@JobContent,IsFull=@IsFull,WorkDays=@WorkDays,ProjectDays=@ProjectDays,Ratio=@Ratio 
			where ProjectNo=@ProjectNo and EmployeeNo=@EmployeeNo and sYear=@sYear and sMonth=@sMonth
		end
	    FETCH NEXT FROM Test_Cursor INTO @EmployeeNo,@FullName,@ProjectNo,@ProjectDays
    end
    CLOSE Test_Cursor
    DEALLOCATE Test_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteOnWorkRecForQuit]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	删除已经离职的考勤记录
-- =============================================
CREATE PROCEDURE [dbo].[DeleteOnWorkRecForQuit] 
AS
BEGIN
	DECLARE @EmployeeNo varchar(50),@QuitDate DateTime
	DECLARE EmpQuit_Cursor CURSOR FOR select a.EmployeeNo,a.QuitDate from Employees a inner join (
	select EmployeeNo from v_AllMembers group by EmployeeNo) b on b.EmployeeNo=a.EmployeeNo 
	where QuitDate is not null and dateadd(month,6,QuitDate)>=getdate() order by QuitDate
	OPEN EmpQuit_Cursor
    FETCH NEXT FROM EmpQuit_Cursor INTO @EmployeeNo,@QuitDate
    while @@fetch_status = 0
    begin
		delete from OnWorkRec where EmployeeNo=@EmployeeNo and WorkDate>=@QuitDate
		delete from OnWorkRecForTest where EmployeeNo=@EmployeeNo and WorkDate>=@QuitDate
		delete from ProjectAttenSum where EmployeeNo=@EmployeeNo and sYear>Year(@QuitDate) and sMonth>Month(@QuitDate)
	    FETCH NEXT FROM EmpQuit_Cursor INTO @EmployeeNo,@QuitDate
    end
    CLOSE EmpQuit_Cursor
    DEALLOCATE EmpQuit_Cursor
END

GO
/****** Object:  StoredProcedure [dbo].[InsertOnWorkRec]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2021-3-25 16:15:00
-- Description:	插入或修改上班记录
-- =============================================
CREATE PROCEDURE [dbo].[InsertOnWorkRec]
(
    @EmployeeNo varchar(30),
    @FullName varchar(30),
	@WorkDate DateTime,
    @Period varchar(30),
	@Days numeric(18, 1),
    @OnDesc varchar(30),
    @Remark varchar(100)
)
AS
BEGIN
	SET NOCOUNT ON;
	
    if not exists(SELECT 1 FROM OnWorkRec WHERE EmployeeNo=@EmployeeNo AND WorkDate=@WorkDate AND Period=@Period)
    begin
        INSERT INTO OnWorkRec(EmployeeNo, FullName, WorkDate, Period, Days, OnDesc, Remark, Status, Creator, CreateTime)
        VALUES(@EmployeeNo,@FullName,@WorkDate,@Period,@Days,@OnDesc,@Remark,2,'系统',getdate())
    end
END
GO
/****** Object:  StoredProcedure [dbo].[InsertOnWorkRecForTest]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2021-3-25 16:15:00
-- Description:	插入或修改上班记录
-- =============================================
CREATE PROCEDURE [dbo].[InsertOnWorkRecForTest]
(
	@ProjectNo varchar(50),
    @EmployeeNo varchar(30),
    @FullName varchar(30),
	@WorkDate DateTime,
    @Period varchar(30),
	@Days numeric(18, 1),
    @OnDesc varchar(30),
    @Remark varchar(100)
)
AS
BEGIN
	SET NOCOUNT ON;
	
    if not exists(SELECT 1 FROM OnWorkRecForTest WHERE ProjectNo=@ProjectNo AND EmployeeNo=@EmployeeNo AND WorkDate=@WorkDate AND Period=@Period)
    begin
        INSERT INTO OnWorkRecForTest(ProjectNo,EmployeeNo, FullName, WorkDate, Period, Days, OnDesc, Remark, Status, Creator, CreateTime)
        VALUES(@ProjectNo,@EmployeeNo,@FullName,@WorkDate,@Period,@Days,@OnDesc,@Remark,2,'系统',getdate())
    end
END
GO
/****** Object:  StoredProcedure [dbo].[RowConvertToColumn]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--5：参数化动态PIVOT行转列
-- =============================================
-- Author:        <听风吹雨>
-- Create date: <2014.05.26>
-- Description:    <参数化动态PIVOT行转列>
-- Blog:        <http://www.cnblogs.com/gaizai/>
-- =============================================
CREATE PROCEDURE  [dbo].[RowConvertToColumn]
(
	@tableName sysname,  ----表名
	@strWhere nvarchar(max), --查询条件,带where
	@groupColumn nvarchar(max), --分组字段,字段间用[]隔开
	@rowTocolumn SYSNAME, --行变列的字段
	@rowTocolumnValue SYSNAME --行变列值的字段
)
AS
BEGIN
	DECLARE @strSql nvarchar(max),
	@row_cols nvarchar(max)  --某行转换后显示的列名
	--@tableName sysname,  ----行转列表
	--@groupColumn nvarchar(max), --分组字段,字段间用[]隔开
	--@rowTocolumn SYSNAME, --行变列的字段
	--@rowTocolumnValue SYSNAME --行变列值的字段
	--SET @tableName = 'v_AllMemberAttenSum'
	--SET @groupColumn = '[FullName],[IsFull],[WorkDays]'
	--SET @rowTocolumn = 'ProjectTitle'
	--SET @rowTocolumnValue = 'ProjectDays'

	--从行数据中获取可能存在的列
	SET @strSql = N'SELECT @sql_col_out = ISNULL(@sql_col_out + '','','''') + QUOTENAME('+@rowTocolumn+') 
    FROM '+@tableName+' '+@strWhere+' GROUP BY '+@rowTocolumn+''
	--PRINT @strSql
	EXEC sp_executesql @strSql,N'@sql_col_out NVARCHAR(MAX) OUTPUT',@sql_col_out=@row_cols OUTPUT
	--PRINT @row_cols
	
	SET @strSql = N'SELECT * FROM (
	SELECT '+@groupColumn+',['+@rowTocolumn+'],['+@rowTocolumnValue+'] FROM '+@tableName+ ' '+@strWhere+') p 
	PIVOT 
    (SUM(['+@rowTocolumnValue+']) FOR ['+@rowTocolumn+'] IN ( '+ @row_cols +') ) AS pvt 
	ORDER BY pvt.'+@groupColumn
	--PRINT (@strSql)
	EXEC (@strSql)
END

GO
/****** Object:  StoredProcedure [dbo].[RptAllMembersAttenStat]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	月度研发工时分配汇总
-- =============================================
CREATE PROCEDURE [dbo].[RptAllMembersAttenStat] 
(
	@OrgName nvarchar(50),
	@sYear int,
	@sMonth int
)
AS
BEGIN
	SET NOCOUNT ON;

    declare @strWhere nvarchar(max), --查询条件,带where
	@strSql nvarchar(max),
	@row_cols nvarchar(max)  --某行转换后显示的列名
	SET @strWhere=' where OrgName='''+@OrgName+''' and sYear='+cast(@sYear as varchar(4))+' and sMonth='+cast(@sMonth as varchar(2))

	--从行数据中获取可能存在的列
	SET @strSql = N'SELECT @sql_col_out = ISNULL(@sql_col_out + '','','''') + QUOTENAME(ProjectTitle) 
    FROM ProjectAttenSum '+@strWhere+' GROUP BY ProjectTitle'
	--PRINT @strSql
	EXEC sp_executesql @strSql,N'@sql_col_out NVARCHAR(MAX) OUTPUT',@sql_col_out=@row_cols OUTPUT
	--PRINT @row_cols

	SET @strSql = N'SELECT FullName,IsFull,WorkDays,'+@row_cols+' FROM (
	SELECT ProjectTitle,FullName,IsFull,WorkDays,ProjectDays  
	FROM ProjectAttenSum '+@strWhere+' group by ProjectTitle,FullName,IsFull,WorkDays,ProjectDays) p 
	PIVOT 
    (sum(ProjectDays) FOR ProjectTitle IN ( '+ @row_cols +') ) AS pvt 
	ORDER BY IsFull desc'
	--PRINT (@strSql)
	EXEC (@strSql)
END

GO
/****** Object:  StoredProcedure [dbo].[RptOnWorkRecForProject]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	月度研发人员考勤表
-- =============================================
CREATE PROCEDURE [dbo].[RptOnWorkRecForProject] 
(
	@ProjectNo varchar(50),
	@sYear int,
	@sMonth int
)
AS
BEGIN
	SET NOCOUNT ON;

    declare @strWhere nvarchar(max), --查询条件,带where
	@strSql nvarchar(max),
	@row_cols nvarchar(max)  --某行转换后显示的列名
	SET @strWhere=' where YEAR(WorkDate)='+cast(@sYear as varchar(4))+' and MONTH(WorkDate)='+cast(@sMonth as varchar(2))+' and ProjectNo='''+@ProjectNo+''''

	--从行数据中获取可能存在的列
	SET @strSql = N'SELECT @sql_col_out = ISNULL(@sql_col_out + '','','''') + QUOTENAME(FullName) 
    FROM OnWorkRec '+@strWhere+' GROUP BY FullName'
	--PRINT @strSql
	EXEC sp_executesql @strSql,N'@sql_col_out NVARCHAR(MAX) OUTPUT',@sql_col_out=@row_cols OUTPUT
	--PRINT @row_cols

	SET @strSql = N'SELECT WorkDate,Period,'+@row_cols+' FROM (
	SELECT FullName,Period,WorkDate,case when [Days]=0 then NULL else [Days] end as Days  
	FROM OnWorkRec '+@strWhere+' group by FullName,Period,WorkDate,[Days]) p 
	PIVOT 
    (max([Days]) FOR [FullName] IN ( '+ @row_cols +') ) AS pvt 
	ORDER BY WorkDate'
	--PRINT (@strSql)
	EXEC (@strSql)
END

GO
/****** Object:  StoredProcedure [dbo].[RptOnWorkRecForTest]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	月度试产人员考勤表
-- =============================================
CREATE PROCEDURE [dbo].[RptOnWorkRecForTest] 
(
	@ProjectNo varchar(50),
	@sYear int,
	@sMonth int
)
AS
BEGIN
	SET NOCOUNT ON;

    declare @strWhere nvarchar(max), --查询条件,带where
	@strSql nvarchar(max),
	@row_cols nvarchar(max)  --某行转换后显示的列名
	SET @strWhere=' where YEAR(WorkDate)='+cast(@sYear as varchar(4))+' and MONTH(WorkDate)='+cast(@sMonth as varchar(2))+' and ProjectNo='''+@ProjectNo+''''

	--从行数据中获取可能存在的列
	SET @strSql = N'SELECT @sql_col_out = ISNULL(@sql_col_out + '','','''') + QUOTENAME(FullName) 
    FROM OnWorkRecForTest '+@strWhere+' GROUP BY FullName'
	--PRINT @strSql
	EXEC sp_executesql @strSql,N'@sql_col_out NVARCHAR(MAX) OUTPUT',@sql_col_out=@row_cols OUTPUT
	--PRINT @row_cols

	SET @strSql = N'SELECT WorkDate,Period,'+@row_cols+' FROM (
	SELECT FullName,Period,WorkDate,case when [Days]=0 then NULL else [Days] end as Days  
	FROM OnWorkRecForTest '+@strWhere+' group by FullName,Period,WorkDate,[Days]) p 
	PIVOT 
    (max([Days]) FOR [FullName] IN ( '+ @row_cols +') ) AS pvt 
	ORDER BY WorkDate'
	--PRINT (@strSql)
	EXEC (@strSql)
END

GO
/****** Object:  StoredProcedure [dbo].[RptYearAttenStatDetail]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	年度研发考勤情况汇总表
-- =============================================
CREATE PROCEDURE [dbo].[RptYearAttenStatDetail] 
(
	@OrgName nvarchar(50),
	@sYear int	
)
AS
BEGIN
	select T8.*,T9.OrgName,T9.Sex,T9.IDNo from Employees T9 inner join (
	select EmployeeNo,IsFull,FullName,ProjectNo,ProjectName,JobContent,sum(ProjectDays) as ProjectDays
	,sum(WorkDays) as WorkDays,cast(Round(sum(ProjectDays)/sum(WorkDays)*100,2) as numeric(10,2)) as YearRatio
	,(select sum(ProjectDays) from ProjectAttenSum a where a.OrgName=@OrgName and a.sYear=@sYear and a.EmployeeNo=t.EmployeeNo) as YearProjectDays
	,(select QuitDate from Employees where EmployeeNo=t.EmployeeNo and QuitDate is not null) as QuitDate
	from ProjectAttenSum t where OrgName=@OrgName and sYear=@sYear 
	group by EmployeeNo,IsFull,FullName,ProjectNo,ProjectName,JobContent
	) T8 on T8.EmployeeNo=T9.EmployeeNo
	order by T8.IsFull desc,T8.EmployeeNo,T8.ProjectNo
END

GO
/****** Object:  StoredProcedure [dbo].[RptYearAttenStatHeader]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	年度研发考勤情况汇总表
-- =============================================
CREATE PROCEDURE [dbo].[RptYearAttenStatHeader] 
(
	@OrgName nvarchar(50),
	@sYear int	
)
AS
BEGIN
	DECLARE @EmpAllCount int,@EmpTestCount int,@EmpProjectCount int,@EmpProjectInCount int,@QuitCount int,@EntryCount int

	select @EmpAllCount=count(*) from (select FullName from ProjectAttenSum where OrgName=@OrgName and sYear=@sYear group by FullName) t
	select @EmpTestCount=count(*) from (select FullName from ProjectAttenSum where OrgName=@OrgName and sYear=@sYear and JobContent='中试人员' group by FullName) t
	select @EmpProjectCount=count(*) from (select FullName from ProjectAttenSum where OrgName=@OrgName and sYear=@sYear and JobContent like'项目%' and IsFull='是' group by FullName) t
	
	select @EmpProjectInCount=count(*) from Employees a inner join (
	select FullName from ProjectAttenSum where OrgName=@OrgName and sYear=@sYear and JobContent like'项目%' and IsFull='是' group by FullName
	) t on a.FullName=t.FullName
	where a.QuitDate is null

	select @QuitCount=count(*) from Employees a inner join (
	select FullName from ProjectAttenSum where OrgName=@OrgName and sYear=@sYear and JobContent like'项目%' group by FullName
	) t on a.FullName=t.FullName
	where a.QuitDate is not null

	select @EntryCount=count(*) from Employees a inner join (
	select FullName from ProjectAttenSum where OrgName=@OrgName and sYear=@sYear and JobContent like'项目%' group by FullName
	) t on a.FullName=t.FullName
	where a.QuitDate is null

	select @EmpAllCount as EmpAllCount,@EmpTestCount as EmpTestCount,@EmpProjectCount as EmpProjectCount,@EmpProjectInCount as EmpProjectInCount
		,@QuitCount as QuitCount,@EntryCount as EntryCount
END
GO
/****** Object:  StoredProcedure [dbo].[TimerMakeOnWorkRec]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2021-4-1 1:42
-- Description:	生成上班记录
-- =============================================
CREATE PROCEDURE [dbo].[TimerMakeOnWorkRec] 
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @CurrDate DateTime
	SET @CurrDate=Convert(DateTime,Convert(varchar(10),DateAdd(d,-1,getdate())))
	--SET @CurrDate=Convert(DateTime,'2021-03-30')
	DECLARE @EmployeeNo varchar(50),@FullName varchar(30),@OnDesc varchar(30)
    DECLARE Emp_Cursor CURSOR FOR select b.* from Employees a inner join (
	SELECT EmployeeNo,FullName from ProjectMembers where @CurrDate between StartDate and EndDate and IsDel=0 GROUP BY EmployeeNo,FullName
	) b on b.EmployeeNo=a.EmployeeNo where a.QuitDate is null and a.[Status] not in('已离职')
	OPEN Emp_Cursor
    FETCH NEXT FROM Emp_Cursor INTO @EmployeeNo,@FullName
    while @@fetch_status = 0
    begin
		EXEC InsertOnWorkRec @EmployeeNo,@FullName,@CurrDate,'上午',0.5,'√',''
		EXEC InsertOnWorkRec @EmployeeNo,@FullName,@CurrDate,'下午',0.5,'√',''
	    FETCH NEXT FROM Emp_Cursor INTO @EmployeeNo,@FullName
    end
    CLOSE Emp_Cursor
    DEALLOCATE Emp_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[TimerMakeOnWorkRecForTest]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2021-5-7 17:38
-- Description:	生成项目试产人员上班记录
-- =============================================
CREATE PROCEDURE [dbo].[TimerMakeOnWorkRecForTest] 
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @CurrDate DateTime
	SET @CurrDate=Convert(DateTime,Convert(varchar(10),DateAdd(d,-1,getdate())))
	--SET @CurrDate=Convert(DateTime,'2021-05-08')
	DECLARE @EmployeeNo varchar(50),@FullName varchar(30),@ProjectNo varchar(50),@lastEmployeeNo varchar(50)
    DECLARE Emp_Cursor CURSOR FOR select b.* from Employees a inner join ( 
	SELECT EmployeeNo,FullName,ProjectNo from ProjectTestMembers where @CurrDate between StartDate and EndDate GROUP BY EmployeeNo,FullName,ProjectNo
	) b on b.EmployeeNo=a.EmployeeNo where a.QuitDate is null and a.[Status] not in('已离职') ORDER BY b.EmployeeNo,b.ProjectNo
	OPEN Emp_Cursor
    FETCH NEXT FROM Emp_Cursor INTO @EmployeeNo,@FullName,@ProjectNo
    while @@fetch_status = 0
    begin
		if @lastEmployeeNo=@EmployeeNo
		begin
			UPDATE OnWorkRecForTest SET ProjectNo=@ProjectNo WHERE EmployeeNo=@EmployeeNo AND WorkDate=@CurrDate AND Period='下午' 
		end
		else
		begin
			EXEC InsertOnWorkRecForTest @ProjectNo,@EmployeeNo,@FullName,@CurrDate,'上午',0.5,'√',''
			EXEC InsertOnWorkRecForTest @ProjectNo,@EmployeeNo,@FullName,@CurrDate,'下午',0.5,'√',''
		end
		SET @lastEmployeeNo=@EmployeeNo
	    FETCH NEXT FROM Emp_Cursor INTO @EmployeeNo,@FullName,@ProjectNo
    end
    CLOSE Emp_Cursor
    DEALLOCATE Emp_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[TimerUpdateOnWorkRecByLeave]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2021-3-30 10:42
-- Description:	根据请假,更新上班记录
-- =============================================
CREATE PROCEDURE [dbo].[TimerUpdateOnWorkRecByLeave]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID int,@EmployeeNo varchar(50),@Period varchar(20),@OnDesc varchar(30),@StartTime DateTime,@EndTime DateTime
	,@LeaveDays numeric(10,1),@sDate DateTime,@lastDate DateTime
	DECLARE Leave_Cursor CURSOR FOR SELECT a.ID,a.EmployeeNo,a.LeaveType,a.StartTime,a.EndTime,a.Days from Leave a inner join 
	(select EmployeeNo,FullName from v_AllMembers group by EmployeeNo,FullName) b on b.EmployeeNo=a.EmployeeNo where a.[Status]=0
	OPEN Leave_Cursor
    FETCH NEXT FROM Leave_Cursor INTO @ID,@EmployeeNo,@OnDesc,@StartTime,@EndTime,@LeaveDays
    while @@fetch_status = 0
    begin
		SELECT TOP 1 @lastDate=sDate FROM dbo.GetLeaveDaysList(@StartTime,@EndTime,@LeaveDays) ORDER BY sDate DESC
		DECLARE sDays_Cursor CURSOR FOR SELECT sDate,period FROM dbo.GetLeaveDaysList(@StartTime,@EndTime,@LeaveDays)
		OPEN sDays_Cursor
		FETCH NEXT FROM sDays_Cursor INTO @sDate,@Period
		while @@fetch_status = 0
		begin
				if @Period='全天'
				begin
					update OnWorkRec SET [Days]=0,OnDesc=@OnDesc where EmployeeNo=@EmployeeNo and WorkDate=Convert(varchar(10),@sDate,23) and [Days]=0.5
					update OnWorkRecForTest SET [Days]=0,OnDesc=@OnDesc where EmployeeNo=@EmployeeNo and WorkDate=Convert(varchar(10),@sDate,23) and [Days]=0.5
				end
				else
				begin
					update OnWorkRec SET [Days]=0,OnDesc=@OnDesc where EmployeeNo=@EmployeeNo and WorkDate=Convert(varchar(10),@sDate,23) and Period=@Period and [Days]=0.5
					update OnWorkRecForTest SET [Days]=0,OnDesc=@OnDesc where EmployeeNo=@EmployeeNo and WorkDate=Convert(varchar(10),@sDate,23) and Period=@Period and [Days]=0.5
				end
			FETCH NEXT FROM sDays_Cursor INTO @sDate,@Period
		end
		CLOSE sDays_Cursor
		DEALLOCATE sDays_Cursor
	   
		if exists(select 1 from OnWorkRec where EmployeeNo=@EmployeeNo and WorkDate=Convert(varchar(10),@lastDate,23) and [Days]=0)
			update Leave set Status=1 where ID=@ID
		if exists(select 1 from OnWorkRecForTest where EmployeeNo=@EmployeeNo and WorkDate=Convert(varchar(10),@lastDate,23) and [Days]=0)
			update Leave set Status=1 where ID=@ID
		FETCH NEXT FROM Leave_Cursor INTO @ID,@EmployeeNo,@OnDesc,@StartTime,@EndTime,@LeaveDays
    end
    CLOSE Leave_Cursor
    DEALLOCATE Leave_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateIndividualEmpForLeave]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	指定个别领导周末休息
-- =============================================
CREATE PROCEDURE [dbo].[UpdateIndividualEmpForLeave] 
(
	@sYear int,
	@sMonth int
)
AS
BEGIN
	DECLARE @EmployeeNo varchar(50),@WorkDays numeric(10,1)
	DECLARE IndividualEmp_Cursor CURSOR FOR SELECT EmployeeNo from OnWorkRec 
	where Year(Workdate)=@sYear and Month(WorkDate)=@sMonth and FullName in('黄炜波','何立军','朱勇','章朝晖') GROUP BY EmployeeNo
	OPEN IndividualEmp_Cursor
    FETCH NEXT FROM IndividualEmp_Cursor INTO @EmployeeNo
    while @@fetch_status = 0
    begin
		update OnWorkRec set Days=0,OnDesc='休息' where ID in(select TOP 8 ID from OnWorkRec where
			Year(Workdate)=@sYear and Month(WorkDate)=@sMonth and EmployeeNo=@EmployeeNo and datename(dw,WorkDate)='星期六'
			order by WorkDate)
	    FETCH NEXT FROM IndividualEmp_Cursor INTO @EmployeeNo
    end
    CLOSE IndividualEmp_Cursor
    DEALLOCATE IndividualEmp_Cursor
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateOnWorkForLeaveProjectNo]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateOnWorkForLeaveProjectNo] 
(
	@EmployeeNo varchar(50),
	@sYear int,
	@sMonth int
)
AS
BEGIN
	create table #t_table1(ID int,EmployeeNo varchar(50),ProjectNo varchar(50),WorkDate DateTime,Period varchar(30))
	declare @ProjectNo varchar(50),@TopCount int,@strSql nvarchar(max),@TopProjectNo varchar(50),@iRow int
	--declare @EmployeeNo varchar(50),@sYear int,@sMonth int
	--set @EmployeeNo='JS40001'
	--set @sYear=2021
	--set @sMonth=6
	set @iRow=1
	DECLARE Topcount_Cursor CURSOR FOR select ProjectNo,TopCount from dbo.GetLeaveProjectNoTopCount(@EmployeeNo,@sYear,@sMonth) 
	OPEN Topcount_Cursor
    FETCH NEXT FROM Topcount_Cursor INTO @ProjectNo,@TopCount
    while @@fetch_status = 0
    begin
		if @iRow=1  set @TopProjectNo=@ProjectNo
		set @strSql=N'insert into #t_table1(ID,EmployeeNo,ProjectNo,WorkDate,Period)
			select top '+cast(@TopCount as varchar(2))+' ID,EmployeeNo,'''+@ProjectNo+''',WorkDate,Period from OnWorkRec 
			where EmployeeNo='''+@EmployeeNo+''' and Year(WorkDate)='+cast(@sYear as varchar(4))+' and Month(WorkDate)='+cast(@sMonth as varchar(2)) 
			+' and Days=0 and ID not in(select ID from #t_table1) order by WorkDate'
		EXEC (@strSql)
		set @iRow=@iRow+1
	    FETCH NEXT FROM Topcount_Cursor INTO @ProjectNo,@TopCount
    end
    CLOSE Topcount_Cursor
    DEALLOCATE Topcount_Cursor

	update OnWorkRec set OnWorkRec.ProjectNo=b.ProjectNo from OnWorkRec a,#t_table1 b where a.id=b.id
	drop table #t_table1

	--如果按比例平均后，还有剩余的记录。就用最高占比的项目
	update OnWorkRec set ProjectNo=@TopProjectNo where EmployeeNo=@EmployeeNo and Year(WorkDate)=@sYear and Month(WorkDate)=@sMonth and Days=0 and ProjectNo is null
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateOnWorkForNoProjectNo]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateOnWorkForNoProjectNo] 
(
	@EmployeeNo varchar(50),
	@sYear int,
	@sMonth int
)
AS
BEGIN
	create table #t_table1(ID int,EmployeeNo varchar(50),ProjectNo varchar(50),WorkDate DateTime,Period varchar(30))
	declare @ProjectNo varchar(50),@TopCount int,@strSql nvarchar(max),@TopProjectNo varchar(50),@iRow int
	--declare @EmployeeNo varchar(50),@sYear int,@sMonth int
	--set @EmployeeNo='JS40001'
	--set @sYear=2021
	--set @sMonth=6
	set @iRow=1
	DECLARE Topcount_Cursor CURSOR FOR select ProjectNo,TopCount from dbo.GetNoProjectNoTopCount(@EmployeeNo,@sYear,@sMonth) 
	OPEN Topcount_Cursor
    FETCH NEXT FROM Topcount_Cursor INTO @ProjectNo,@TopCount
    while @@fetch_status = 0
    begin
		if @iRow=1
		begin
			set @TopProjectNo=@ProjectNo
		end

		set @strSql=N'insert into #t_table1(ID,EmployeeNo,ProjectNo,WorkDate,Period)
			select top '+cast(@TopCount as varchar(2))+' ID,EmployeeNo,'''+@ProjectNo+''',WorkDate,Period from OnWorkRec 
			where EmployeeNo='''+@EmployeeNo+''' and Year(WorkDate)='+cast(@sYear as varchar(4))+' and Month(WorkDate)='+cast(@sMonth as varchar(2)) 
			+' and Days>0 and ProjectNo is null and ID not in(select ID from #t_table1) order by WorkDate'
		EXEC (@strSql)
		set @iRow=@iRow+1
	    FETCH NEXT FROM Topcount_Cursor INTO @ProjectNo,@TopCount
    end
    CLOSE Topcount_Cursor
    DEALLOCATE Topcount_Cursor

	update OnWorkRec set OnWorkRec.ProjectNo=b.ProjectNo from OnWorkRec a,#t_table1 b where a.id=b.id
	drop table #t_table1

	--如果按比例平均后，还有剩余的记录。就用最高占比的项目
	update OnWorkRec set ProjectNo=@TopProjectNo where EmployeeNo=@EmployeeNo and Year(WorkDate)=@sYear and Month(WorkDate)=@sMonth and Days>0 and ProjectNo is null
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateOnWorkForProjectNo]    Script Date: 2025/03/21 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateOnWorkForProjectNo] 
(
	@EmployeeNo varchar(50),
	@sYear int,
	@sMonth int
)
AS
BEGIN
	create table #t_table1(ID int,EmployeeNo varchar(50),ProjectNo varchar(50),WorkDate DateTime,Period varchar(30))
	declare @ProjectNo varchar(50),@TopCount int,@strSql nvarchar(max)
	--declare @EmployeeNo varchar(50),@sYear int,@sMonth int
	--set @EmployeeNo='JS40001'
	--set @sYear=2021
	--set @sMonth=6
	DECLARE Topcount_Cursor CURSOR FOR select ProjectNo,TopCount from dbo.GetProjectNoTopCount(@EmployeeNo,@sYear,@sMonth) 
	OPEN Topcount_Cursor
    FETCH NEXT FROM Topcount_Cursor INTO @ProjectNo,@TopCount
    while @@fetch_status = 0
    begin
		set @strSql=N'insert into #t_table1(ID,EmployeeNo,ProjectNo,WorkDate,Period)
			select top '+cast(@TopCount as varchar(2))+' ID,EmployeeNo,'''+@ProjectNo+''',WorkDate,Period from OnWorkRec 
			where EmployeeNo='''+@EmployeeNo+''' and Year(WorkDate)='+cast(@sYear as varchar(4))+' and Month(WorkDate)='+cast(@sMonth as varchar(2)) 
			+' and Days>0 and ID not in(select ID from #t_table1) order by WorkDate'
		EXEC (@strSql)
	    FETCH NEXT FROM Topcount_Cursor INTO @ProjectNo,@TopCount
    end
    CLOSE Topcount_Cursor
    DEALLOCATE Topcount_Cursor

	update OnWorkRec set OnWorkRec.ProjectNo=b.ProjectNo from OnWorkRec a,#t_table1 b where a.id=b.id
	drop table #t_table1
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'全职;兼职;实习;退休返聘' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employees', @level2type=N'COLUMN',@level2name=N'EmployeeType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-试用期1-正式员工-1-已离职' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employees', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'休息,病假,事假,调休,婚假,产假' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Leave', @level2type=N'COLUMN',@level2name=N'LeaveType'
GO
USE [master]
GO
ALTER DATABASE [AttendanceForRD] SET  READ_WRITE 
GO
