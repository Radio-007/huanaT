USE [master]
GO
/****** Object:  Database [MakeT+Voucher]    Script Date: 2025/3/26 16:48:53 ******/
CREATE DATABASE [MakeT+Voucher] ON  PRIMARY 
( NAME = N'MakeT+Voucher', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\MakeT+Voucher.mdf' , SIZE = 276480KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MakeT+Voucher_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\MakeT+Voucher_log.ldf' , SIZE = 136064KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MakeT+Voucher] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MakeT+Voucher].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MakeT+Voucher] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET ARITHABORT OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MakeT+Voucher] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MakeT+Voucher] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MakeT+Voucher] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MakeT+Voucher] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MakeT+Voucher] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MakeT+Voucher] SET  MULTI_USER 
GO
ALTER DATABASE [MakeT+Voucher] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MakeT+Voucher] SET DB_CHAINING OFF 
GO
USE [MakeT+Voucher]
GO
/****** Object:  User [exchange]    Script Date: 2025/3/26 16:48:53 ******/
CREATE USER [exchange] FOR LOGIN [exchange] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_denydatawriter', @membername = N'exchange'
GO
/****** Object:  UserDefinedFunction [dbo].[ClearZero]    Script Date: 2025/3/26 16:48:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	去零函数，去除小数点后多余的零
-- =============================================
CREATE FUNCTION [dbo].[ClearZero] 
(
@Number varchar(30)
)
returns varchar(30)
AS
BEGIN
	if @Number = '' or @Number is null     ---如果为空，直接返回  
		return null  
    else  
    begin
		declare @PointIndex int  
        set @PointIndex = charindex('.',@Number)    
        if @PointIndex = 0 return @Number      ---如果不是浮点数，直接返回  
        if @PointIndex = len(@Number)
			return replace(@Number,'.','')    ----数字末尾有小数点，直接删除返回  
        else  
        begin  
            if right(@Number,1) = '0'               ---递归调用，进行去零操作  
            begin  
                set @Number = substring(@Number,1,len(@Number) - 1)  
                return dbo.ClearZero(@Number)  
            end  
            else  
                return @Number  
        end  
    end  
    return null  

END
GO
/****** Object:  UserDefinedFunction [dbo].[DelChinese]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-5
-- Description:	去除字符串中的中文
-- =============================================
CREATE FUNCTION [dbo].[DelChinese] 
(
	@strCol nvarchar(1000)
)
RETURNS nvarchar(1000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @strReturn nvarchar(1000),@len int
	set @strReturn=''
	set @len=1
	while @len<=len(@strCol)
	begin
		if (ASCII(substring(@strCol,@len,1))<122)
			set @strReturn=@strReturn+substring(@strCol,@len,1)
		set @len=@len+1
	end
	set @strReturn=replace(@strReturn,' ','')
	if @strReturn=''
		set @strReturn=@strCol

	RETURN @strReturn

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetAuxiliaryItems]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		获取特殊情况的客户
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetAuxiliaryItems](@customer varchar(100),@type varchar(30)) 
RETURNS varchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @strResult varchar(100)

	if patindex('%中建西部%',@customer)>0
	begin
		if @type='未开票'
		begin
			set @strResult=@customer
		end
		else
		begin
			if patindex('%邕宁分公司（高新厂）%',@customer)>0 
			begin
				set @strResult='广西中建西部建设有限公司邕宁分公司'
			end
			if patindex('%鑫华%',@customer)>0 or patindex('%高新%',@customer)>0 
			begin
				set @strResult='广西中建西部建设有限公司'
			end
			else if patindex('%石埠%',@customer)>0 or patindex('%邕宁%',@customer)>0
			begin
				set @strResult='广西中建西部建设有限公司石埠分公司'
			end
			else if patindex('%福基%',@customer)>0
			begin
				set @strResult='南宁中建西部建设有限公司'
			end
			else if patindex('%屹桂%',@customer)>0 or patindex('%江南华润%',@customer)>0
			begin
				set @strResult='南宁中建西部建设有限公司'
			end
		end
	end
	else if @customer='1' or @customer='2'
	begin
		set @strResult='私人'
	end
	else if patindex('%广西群英%',@customer)>0
	begin
		set @strResult='广西群英供应链有限公司'
	end
	else if patindex('%利汇景%',@customer)>0
	begin
		set @strResult='南宁高新区利汇景建材经营部（票）'
	end
	else if patindex('%宣城华纳%',@customer)>0 or patindex('%安徽省宣城市华纳新材料科技有限公司%',@customer)>0
	begin
		set @strResult='安徽宣城华纳新材料科技有限公司'
	end
	else if patindex('%合山华纳%',@customer)>0
	begin
		set @strResult='广西合山市华纳新材料科技有限公司'
	end
	else if patindex('%纳天山庄%',@customer)>0
	begin
		set @strResult='南宁武鸣纳天农业开发有限公司'
	end
	else if patindex('%甘圩教育基金%',@customer)>0
	begin
		set @strResult='甘圩教育基金'
	end
	else if patindex('%（个体工商户）%',@customer)>0
	begin
		set @strResult=replace(@customer,'（个体工商户）','')
	end
	else if patindex('%（个人）%',@customer)>0
	begin
		set @strResult=replace(@customer,'（个人）','')
	end
	else
	begin
		set @strResult=@customer
	end

	-- Return the result of the function
	RETURN @strResult

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetCustomerPeriod]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date, ,>
-- Description:	获取客户对账期间
-- =============================================
CREATE FUNCTION [dbo].[GetCustomerPeriod] 
(
	@lastMonthDate DateTime, --上月
	@customer_period varchar(50)
)
RETURNS varchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result varchar(50),@year varchar(4),@startDate varchar(10),@endDate varchar(10)

	if @customer_period='' or @customer_period is null
	begin
		set @result=cast(month(@lastMonthDate) as varchar(2))+'月'
	end
	else
	begin
		set @year=left(@customer_period,4)
		set @endDate=@year+'-'+replace(right(@customer_period,5),'.','-')
		select @startDate=@year+'-'+replicate('0',2-len(cast(month(@endDate) as varchar(2))))+cast(month(@endDate) as varchar(2))+'-01'
		select @result=replace(right(@startDate,5),'-','.') + '-' + replace(right(@endDate,5),'-','.')
	end
	RETURN @result

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSummaryKey]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		获取特殊情况的客户
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetSummaryKey](@customer varchar(100)) 
RETURNS varchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @strResult varchar(100)
	
	if patindex('%中建西部%',@customer)>0
	begin
		if patindex('%石埠%',@customer)>0
			set @strResult='石埠'
		else if patindex('%鑫华%',@customer)>0
			set @strResult='鑫华'
		else if patindex('%高新%',@customer)>0 
			set @strResult='高新'
		else if patindex('%邕宁%',@customer)>0
			set @strResult='邕宁'
		else if patindex('%（福基站）',@customer)>0
			set @strResult='福基'
		else if patindex('%（屹桂厂）',@customer)>0
			set @strResult='屹桂'
		else if patindex('%江南华润%',@customer)>0
			set @strResult='江南华润'	
	end
	else
	begin
		set @strResult=''
	end

	-- Return the result of the function
	RETURN @strResult

END
GO
/****** Object:  Table [dbo].[huayao_fh]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[huayao_fh](
	[id] [nvarchar](50) NOT NULL,
	[xs_sn] [nvarchar](50) NULL,
	[dw] [nvarchar](100) NULL,
	[division] [nvarchar](100) NULL,
	[customer_type] [nvarchar](50) NULL,
	[customer] [nvarchar](150) NULL,
	[zcsj] [datetime] NULL,
	[kcsj] [datetime] NULL,
	[carno] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[amount_mao] [numeric](18, 4) NULL,
	[amount_pi] [numeric](18, 4) NULL,
	[amount_jing] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[amount_hd] [numeric](18, 4) NULL,
	[hdrq] [datetime] NULL,
	[amount_pc] [numeric](18, 4) NULL,
	[notes] [nvarchar](100) NULL,
	[notes_hd] [nvarchar](200) NULL,
	[ys_qyyfdj] [numeric](18, 2) NULL,
	[ys_qyyfje] [numeric](18, 2) NULL,
	[price_material] [numeric](18, 2) NULL,
	[money_material] [numeric](18, 2) NULL,
	[yf_sjyfdj] [numeric](18, 2) NULL,
	[yf_sjyfje] [numeric](18, 2) NULL,
	[money_material_k] [numeric](18, 2) NULL,
	[writeoffState] [int] NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
	[yfjsfs] [nvarchar](50) NULL,
 CONSTRAINT [PK_huayao_fh] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[huayao_fhtemp]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[huayao_fhtemp](
	[id] [nvarchar](50) NOT NULL,
	[xs_sn] [nvarchar](50) NULL,
	[dw] [nvarchar](100) NULL,
	[division] [nvarchar](100) NULL,
	[customer_type] [nvarchar](50) NULL,
	[customer] [nvarchar](150) NULL,
	[zcsj] [datetime] NULL,
	[kcsj] [datetime] NULL,
	[carno] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[amount_mao] [numeric](18, 4) NULL,
	[amount_pi] [numeric](18, 4) NULL,
	[amount_jing] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[amount_hd] [numeric](18, 4) NULL,
	[hdrq] [datetime] NULL,
	[amount_pc] [numeric](18, 4) NULL,
	[notes] [nvarchar](100) NULL,
	[notes_hd] [nvarchar](200) NULL,
	[ys_qyyfdj] [numeric](18, 2) NULL,
	[ys_qyyfje] [numeric](18, 2) NULL,
	[price_material] [numeric](18, 2) NULL,
	[money_material] [numeric](18, 2) NULL,
	[yf_sjyfdj] [numeric](18, 2) NULL,
	[yf_sjyfje] [numeric](18, 2) NULL,
	[money_material_k] [numeric](18, 2) NULL,
	[writeoffState] [int] NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
	[yfjsfs] [nvarchar](50) NULL,
 CONSTRAINT [PK_huayao_fhtemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[huayao_invoiced]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[huayao_invoiced](
	[id] [nvarchar](50) NOT NULL,
	[dw] [nvarchar](100) NULL,
	[fhrq] [datetime] NULL,
	[customer_type] [nvarchar](50) NULL,
	[customer] [nvarchar](200) NULL,
	[customer_period] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[money_notax] [numeric](18, 2) NULL,
	[money_tax] [numeric](18, 2) NULL,
	[price_avg] [numeric](18, 2) NULL,
	[amount_pc] [numeric](18, 4) NULL,
	[money_pc] [numeric](18, 2) NULL,
	[xs_sn] [nvarchar](50) NULL,
	[kprq] [datetime] NULL,
	[kphm] [nvarchar](300) NULL,
	[kpdw] [nvarchar](100) NULL,
	[options] [nvarchar](50) NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
	[writeoffState] [int] NULL,
	[yfjsfs] [nvarchar](50) NULL,
 CONSTRAINT [PK_huayao_invoiced] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[huayao_invoicedtemp]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[huayao_invoicedtemp](
	[id] [nvarchar](50) NOT NULL,
	[dw] [nvarchar](100) NULL,
	[fhrq] [datetime] NULL,
	[customer_type] [nvarchar](50) NULL,
	[customer] [nvarchar](200) NULL,
	[customer_period] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[money_notax] [numeric](18, 2) NULL,
	[money_tax] [numeric](18, 2) NULL,
	[price_avg] [numeric](18, 2) NULL,
	[amount_pc] [numeric](18, 4) NULL,
	[money_pc] [numeric](18, 2) NULL,
	[xs_sn] [nvarchar](50) NULL,
	[kprq] [datetime] NULL,
	[kphm] [nvarchar](300) NULL,
	[kpdw] [nvarchar](100) NULL,
	[options] [nvarchar](50) NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
	[writeoffState] [int] NULL,
	[yfjsfs] [nvarchar](50) NULL,
 CONSTRAINT [PK_huayao_invoicedtemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[huayao_period]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[huayao_period](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer] [nvarchar](100) NULL,
	[startTime] [datetime] NULL,
	[endTime] [datetime] NULL,
	[notes] [nvarchar](50) NULL,
 CONSTRAINT [PK_huayao_period] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[luchang_period]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[luchang_period](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer] [nvarchar](100) NULL,
	[startTime] [datetime] NULL,
	[endTime] [datetime] NULL,
	[notes] [nvarchar](50) NULL,
 CONSTRAINT [PK_luchang_period] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sjs_fh]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sjs_fh](
	[id] [nvarchar](50) NOT NULL,
	[xs_sn] [nvarchar](50) NULL,
	[dw] [nvarchar](100) NULL,
	[division] [nvarchar](100) NULL,
	[customer_type] [nvarchar](50) NULL,
	[customer] [nvarchar](150) NULL,
	[zcsj] [datetime] NULL,
	[kcsj] [datetime] NULL,
	[carno] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[amount_mao] [numeric](18, 4) NULL,
	[amount_pi] [numeric](18, 4) NULL,
	[amount_jing] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[amount_hd] [numeric](18, 4) NULL,
	[hdrq] [datetime] NULL,
	[amount_pc] [numeric](18, 4) NULL,
	[notes] [nvarchar](100) NULL,
	[notes_hd] [nvarchar](200) NULL,
	[ys_qyyfdj] [numeric](18, 2) NULL,
	[ys_qyyfje] [numeric](18, 2) NULL,
	[price_material] [numeric](18, 2) NULL,
	[money_material] [numeric](18, 2) NULL,
	[yf_sjyfdj] [numeric](18, 2) NULL,
	[yf_sjyfje] [numeric](18, 2) NULL,
	[money_material_k] [numeric](18, 2) NULL,
	[writeoffState] [int] NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
	[yfjsfs] [nvarchar](50) NULL,
 CONSTRAINT [PK_sjs_fh] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sjs_fhtemp]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sjs_fhtemp](
	[id] [nvarchar](50) NOT NULL,
	[xs_sn] [nvarchar](50) NULL,
	[dw] [nvarchar](100) NULL,
	[division] [nvarchar](100) NULL,
	[customer_type] [nvarchar](50) NULL,
	[customer] [nvarchar](150) NULL,
	[zcsj] [datetime] NULL,
	[kcsj] [datetime] NULL,
	[carno] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[amount_mao] [numeric](18, 4) NULL,
	[amount_pi] [numeric](18, 4) NULL,
	[amount_jing] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[amount_hd] [numeric](18, 4) NULL,
	[hdrq] [datetime] NULL,
	[amount_pc] [numeric](18, 4) NULL,
	[notes] [nvarchar](100) NULL,
	[notes_hd] [nvarchar](200) NULL,
	[ys_qyyfdj] [numeric](18, 2) NULL,
	[ys_qyyfje] [numeric](18, 2) NULL,
	[price_material] [numeric](18, 2) NULL,
	[money_material] [numeric](18, 2) NULL,
	[yf_sjyfdj] [numeric](18, 2) NULL,
	[yf_sjyfje] [numeric](18, 2) NULL,
	[money_material_k] [numeric](18, 2) NULL,
	[writeoffState] [int] NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
	[yfjsfs] [nvarchar](50) NULL,
 CONSTRAINT [PK_sjs_fhtemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[test]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test](
	[id] [nvarchar](50) NOT NULL,
	[xs_sn] [nvarchar](50) NULL,
	[dw] [nvarchar](100) NULL,
	[division] [nvarchar](100) NULL,
	[customer_type] [nvarchar](50) NULL,
	[customer] [nvarchar](150) NULL,
	[zcsj] [datetime] NULL,
	[kcsj] [datetime] NULL,
	[carno] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[amount_mao] [numeric](18, 4) NULL,
	[amount_pi] [numeric](18, 4) NULL,
	[amount_jing] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[amount_hd] [numeric](18, 4) NULL,
	[hdrq] [datetime] NULL,
	[amount_pc] [numeric](18, 4) NULL,
	[notes] [nvarchar](50) NULL,
	[notes_hd] [nvarchar](50) NULL,
	[ys_qyyfdj] [numeric](18, 2) NULL,
	[ys_qyyfje] [numeric](18, 2) NULL,
	[price_material] [numeric](18, 2) NULL,
	[money_material] [numeric](18, 2) NULL,
	[yf_sjyfdj] [numeric](18, 2) NULL,
	[yf_sjyfje] [numeric](18, 2) NULL,
	[money_material_k] [numeric](18, 2) NULL,
	[writeoffState] [int] NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
	[yfjsfs] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[查询]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[查询](
	[id] [nvarchar](50) NOT NULL,
	[dw] [nvarchar](100) NULL,
	[fhrq] [datetime2](3) NULL,
	[customer_type] [nvarchar](50) NULL,
	[customer] [nvarchar](200) NULL,
	[customer_period] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[amount] [decimal](18, 4) NULL,
	[price] [decimal](18, 2) NULL,
	[money] [decimal](18, 2) NULL,
	[money_notax] [decimal](18, 2) NULL,
	[money_tax] [decimal](18, 2) NULL,
	[price_avg] [decimal](18, 2) NULL,
	[amount_pc] [decimal](18, 4) NULL,
	[money_pc] [decimal](18, 2) NULL,
	[xs_sn] [nvarchar](50) NULL,
	[kprq] [datetime2](3) NULL,
	[kphm] [nvarchar](300) NULL,
	[n_kprq] [datetime2](3) NULL,
	[n_kphm] [nvarchar](300) NULL,
	[kpdw] [nvarchar](100) NULL,
	[options] [nvarchar](50) NULL,
	[createTime] [datetime2](3) NULL,
	[updateTime] [datetime2](3) NULL,
	[writeoffState] [int] NULL,
	[yfjsfs] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[销售台账]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[销售台账](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[销售流水单号] [nvarchar](255) NULL,
	[日期时间] [datetime] NULL,
	[业务所在公司] [nvarchar](255) NULL,
	[客户名称] [nvarchar](255) NULL,
	[生产基地] [nvarchar](255) NULL,
	[货品名称] [nvarchar](255) NULL,
	[单位] [nvarchar](255) NULL,
	[数量] [float] NULL,
	[单价] [float] NULL,
	[金额合计] [float] NULL,
	[备注] [nvarchar](255) NULL,
	[车牌] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[DelRepeatStr]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-7
-- Description:	从SQL中的字符串中删除重复项
-- =============================================
CREATE FUNCTION [dbo].[DelRepeatStr]
(	
	@String varchar(max),
	@Delimiter varchar(10) 
)
RETURNS TABLE 
AS
Return (
select distinct RetVal from (
    Select RetSeq = Row_Number() over (Order By (Select null))
          ,RetVal = LTrim(RTrim(B.i.value('(./text())[1]', 'varchar(max)')))
    From  (Select x = Cast('<x>' + replace((Select replace(@String,@Delimiter,'§§Split§§') as [*] For XML Path('')),'§§Split§§','</x><x>')+'</x>' as xml).query('.')) as A 
    Cross Apply x.nodes('x') AS B(i)
	) t1
)
GO
/****** Object:  UserDefinedFunction [dbo].[tbSplit]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-7
-- Description:	从SQL中的字符串split拆分
-- =============================================
CREATE FUNCTION [dbo].[tbSplit]
(	
	@String varchar(max),
	@Delimiter varchar(10) 
)
RETURNS TABLE 
AS
Return (
    Select RetSeq = Row_Number() over (Order By (Select null))
          ,RetVal = LTrim(RTrim(B.i.value('(./text())[1]', 'varchar(max)')))
    From  (Select x = Cast('<x>' + replace((Select replace(@String,@Delimiter,'§§Split§§') as [*] For XML Path('')),'§§Split§§','</x><x>')+'</x>' as xml).query('.')) as A 
    Cross Apply x.nodes('x') AS B(i)
)
GO
/****** Object:  View [dbo].[v_huayao_fh]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_huayao_fh]
AS
SELECT   id, xs_sn, dw, division, customer_type, customer, zcsj, kcsj, carno, goodsname, amount_mao, amount_pi, amount_jing, 
                amount_hd, hdrq, amount_pc, notes, notes_hd, ys_qyyfdj, ys_qyyfje, price_material, money_material, yf_sjyfdj, 
                yf_sjyfje, money_material_k, writeoffState, flowState, createTime, updateTime, yfjsfs,
                CASE WHEN customer_type = '个人' THEN price ELSE price_material END AS price, 
                CASE WHEN customer_type = '个人' THEN [money] ELSE money_material END AS [money]
FROM      dbo.huayao_fh
GO
/****** Object:  StoredProcedure [dbo].[huayao_AddVoucherMaster]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	增加凭证主表，返回id
-- =============================================
CREATE PROCEDURE [dbo].[huayao_AddVoucherMaster] 
(
	@customer nvarchar(100),
	@summoney numeric(12,2),
	@currentYear int,
	@currentPeriod int,
	@invoiceType nvarchar(50),
	@idDocDTO int output
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @strDocOrderNum nvarchar(50),@strTemp nvarchar(200),@sql NVARCHAR(max)
	DECLARE @idPeriod int,@voucherdate varchar(10)

	--获取凭证唯一标示号
	exec huayao_GetDocOrderNum @currentYear,@currentPeriod,@strDocOrderNum output

	select @idPeriod=id FROM UFTData235382_400002.dbo.SM_Period where currentyear=@currentYear and currentperiod=@currentPeriod
	
	select @voucherdate=cast(@currentYear as varchar(10))+'-'+cast(@currentPeriod as varchar(10))+'-'+cast(day(getdate()) as varchar(10))--当天
	if Convert(DateTime,Convert(varchar(10),getdate(),120))>@voucherdate	
		SELECT  @voucherdate=convert(varchar(10),dateadd(month, datediff(month, -1, @voucherdate), -1),120) --当月最后一天
		
	select @sql=N'
		insert UFTData235382_400002.dbo.GL_Doc(code, [name], accuorigamountdr, accuorigamountcr, accuamountdr, accuamountcr, iscashieraudit
		,ispost, iserror, isinvalidate, iscashflowed, isquantitydoc, isforeigncurrencydoc 
		,accountingperiod, accountingyear, maker, iscarriedforwardout, iscarriedforwardin, ismodifiedcode
		,isCashierDoc, DocOrderNum, PrintCount, isCashflowByHand, iddoctype, cashflowedstate, docbusinesstype
		,invalidateState, makeErrorState, voucherstate, makerid, idperiod, voucherdate, madedate, createdtime)
		values('''+right(@strDocOrderNum,6)+''','''','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+',0,0,0,0,0,1
		,0,'+cast(@currentPeriod as varchar(10))+','+cast(@currentYear as varchar(10))+',''李静谊'',0,0,0
		,0,'''+@strDocOrderNum+''',0,0,5,655,621,682,679,181,35,'+cast(@idPeriod as varchar(30))+','''+@voucherdate+''',Convert(varchar(10),getdate(),120),getdate()) 
		select @idDocDTO=@@identity'
	
	--print @sql
	EXEC sp_executesql @sql,N'@idDocDTO int out',@idDocDTO OUT
END


GO
/****** Object:  StoredProcedure [dbo].[huayao_GetDocOrderNum]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-01
-- Description:	获取凭证唯一标示号
-- =============================================
CREATE PROCEDURE [dbo].[huayao_GetDocOrderNum]
(
	@currentYear int,
	@currentPeriod int,
	@strDocOrderNum nvarchar(50) output
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--凭证类别ID=5，AA_DocType.sequencenumber=4
	DECLARE @strNo nvarchar(50),@sql NVARCHAR(4000)
	set @strNo=cast(@currentYear as nvarchar(20))+isnull(replicate('0',2-len(@currentPeriod)),'')+cast(@currentPeriod as varchar(20))+'5004'
	select @sql=N'if exists(select 1 from UFTData235382_400002.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%'')
	begin
		select @strDocOrderNum=(right(max(DocOrderNum),6)+1) from UFTData235382_400002.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%''
		select @strDocOrderNum='''+@strNo+'''+replicate(''0'',18-len(@strDocOrderNum))+@strDocOrderNum
	end
	else
	begin
		set @strDocOrderNum='''+@strNo+'''+replicate(''0'',16)+''01''
	end'

	--print @sql
	EXEC sp_executesql @sql,N'@strDocOrderNum varchar(50) out',@strDocOrderNum OUT
END
GO
/****** Object:  StoredProcedure [dbo].[huayao_InsertVoucherJournal]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-02
-- Description:	从分录表获取数据，插入凭证明细表
-- =============================================
CREATE PROCEDURE [dbo].[huayao_InsertVoucherJournal] 
(
@idDocDTO int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @code nvarchar(30),@summary nvarchar(max),@origamountdr decimal(28,14),@origamountcr decimal(28,14),@amountdr decimal(28,14),@amountcr decimal(28,14)
		,@quantitycr decimal(28,14),@price decimal(28,14),@sequencenumber int,@AuxiliaryItems nvarchar(500),@idaccount int,@id int,@idUnit int
	declare @docno varchar(30),@currentYear int,@currentPeriod int,@idauxAccCustomer int,@idaccountingperiod int,@auxiliaryinfoid int,@direction int,@voucherdate DateTime

	select @docno=code,@currentYear=accountingyear,@currentPeriod=accountingperiod,@voucherdate=voucherdate from UFTData235382_400002.dbo.GL_Doc where id=@idDocDTO
	select @idaccountingperiod=id FROM UFTData235382_400002.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod --会计期间ID
	
	--删除所有
	delete from UFTData235382_400002.dbo.GL_AuxiliaryInfo where DocId=@idDocDTO
	delete from UFTData235382_400002.dbo.GL_Journal where DocId=@idDocDTO
	
	DECLARE Journal_Cursor CURSOR FOR select id,code,summary,origamountdr,origamountcr,amountdr,amountcr,quantitycr,price,sequencenumber,AuxiliaryItems,idaccount,idUnit 
	from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO order by code
	OPEN Journal_Cursor
    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    while @@fetch_status = 0
    begin	
		--插入辅助信息DTO
		set @idauxAccCustomer=null
		set @auxiliaryinfoid=null
		select @idUnit=idUnit from UFTData235382_400002.dbo.AA_Account where id=@idaccount
		if @AuxiliaryItems is not null or isnull(@idUnit,0)>0
		begin
			select @idauxAccCustomer=id from UFTData235382_400002.dbo.AA_Partner where [name]=@AuxiliaryItems and partnerType in(211,228) --客户：211,客户/供应商：228
			insert into UFTData235382_400002.[dbo].[GL_AuxiliaryInfo](exchangerate,idauxAccCustomer,DocId,idEntryDTO)
			values(1.0,@idauxAccCustomer,@idDocDTO,@id)
			select @auxiliaryinfoid=@@identity
		end

		--没有往来单位，反写分录表
		if @idauxAccCustomer is null
			update UFTData235382_400002.dbo.GL_Entry set AuxiliaryItems=null where id=@id and AuxiliaryItems is not null
		
		set @direction=652  --借方
		if @amountcr is not null
			set @direction=653  --贷方
		if not exists(select 1 from UFTData235382_400002.dbo.[GL_Journal] where docid=@idDocDTO and entryid=@id)
		begin
			insert into UFTData235382_400002.[dbo].[GL_Journal](docno, rowno, summary, maker, exchangerate, price
			,iscarriedforwardout, iscarriedforwardin, sequencenumber, ispost, [year], currentperiod, quantityCr
			,amountDr, amountCr, origAmountDr, OrigAmountCr, isPeriodBegin,DocDrCrType, idaccount, idcurrency, idDocType
			,idauxAccCustomer,direction, makerId, docid, entryid, auxiliaryinfoid, idaccountingperiod, madedate, idUnit)
			values(@docno,@code,@summary,'李静谊',1,@price,0,0,@sequencenumber,0,@currentYear,@currentPeriod,@quantitycr,@amountdr,@amountcr,@origamountdr,@origamountcr
			,0,22,@idaccount,4,5,@idauxAccCustomer,@direction,35,@idDocDTO,@id,@auxiliaryinfoid,@idaccountingperiod,@voucherdate,@idUnit)

		end
	    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    end
    CLOSE Journal_Cursor
    DEALLOCATE Journal_Cursor
END


GO
/****** Object:  StoredProcedure [dbo].[huayao_Invoice]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	已开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[huayao_Invoice] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方=含税金额，贷方金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@id nvarchar(50),@customer_period nvarchar(50),@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@options nvarchar(50),@moneyNotax numeric(18,2),@moneyTax numeric(18,2),@amountPc numeric(18,4),@moneyPc numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@customer_summary nvarchar(max)
	
	DECLARE @tb_goods TABLE(goodsname varchar(100), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)

    DECLARE tbgoods_Cursor CURSOR FOR select customer,kphm from huayao_invoiced where writeoffState=0 and isnull(options,'')='' and [money]>0  
	and year(fhrq)=year(kprq) and month(fhrq)=month(kprq) and year(kprq)=@currentYear and month(kprq)=@currentPeriod  
    group by customer,kphm
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@kphm
    while @@fetch_status = 0
    begin
		set @options=''
		set @customer_period=''
		select Top 1 @customer_period=customer_period,@options=options from huayao_invoiced where kphm=@kphm
		if @customer_period=''
		begin
			set @customer_period=cast(@currentPeriod as varchar(2))+'月'
		end
		else
		begin
			set @customer_period=right(@customer_period,11)
		end

		set @customer_summary=@Customer
		if dbo.GetSummaryKey(@Customer)<>''
		begin
			set @customer_summary=@Customer+'（'+dbo.GetSummaryKey(@Customer)+'）'
		end

		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec huayao_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'当月开票',@idDocDTO output
		--set @idDocDTO=8963
		if @idDocDTO>0
		begin
			--delete from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			--科目表
			select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='1122001' and accountingyear=@currentYear and isEndNode=1 and IsAux=1 --应收账款-1
			
			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'开票第一行',1,2,null,2,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from huayao_invoiced where kphm=@kphm
			group by goodsname,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where name=@goodsname and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='开票'+@customer_period+@customer_summary+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+'  '+@options+' '+@kphm
				set @amountcr_total=@amountcr_total+@moneyNotax  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
				
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@moneyNotax,null,@moneyNotax,@amount,@price/1.03,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)

				--print @row_summary
				insert into @tb_goods(goodsname,amount)values(@goodsname,@amount) --插入表变量
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			set @head_summary='开票'+@customer_period+@customer_summary
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_goods 
			group by goodsname order by goodsname
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@options+' '+@kphm --替换第一个'+'字符
			--print @head_summary
			--更新开票第一行摘要
			update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='开票第一行'

			set @foot_summary='开票'+@customer_period+@customer_summary+'  '+@kphm
			--print @foot_summary
			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='2221020' and accountingyear=@currentYear and isEndNode=1 order by depth --应交税费-简易计税
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			
			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--磅差
			set @money=0
			set @amount=0
			if exists(select 1 from huayao_invoiced where abs(amount_pc)>0 and kphm=@kphm)
			begin
				set @head_summary=@customer_period+@customer_summary+'磅差'
				--科目表-借方金额
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='6601012' and accountingyear=@currentYear --销售费用-运输途中合理损耗
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,'磅差第一行',1,null,null,null,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

				--明细
				DECLARE Entry_Cursor CURSOR FOR select goodsname,sum(amount_pc),sum(money_pc)
				from huayao_invoiced where abs(amount_pc)>0 and kphm=@kphm
				group by goodsname,price order by goodsname
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount,@money
				while @@fetch_status = 0
				begin
					--科目表
					select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where left(code,4)='1405' and name=@goodsname and accountingyear=@currentYear  --库存商品-水洗砂

					set @head_summary=@head_summary+'+'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
					set @row_summary=@customer_period+@customer_summary+'磅差'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
					set @price=@money/@amount
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
					insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount,@money
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'')
				--print @head_summary
				--更新合理损耗第一行摘要
				update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary where idDocDTO=@idDocDTO and summary='磅差第一行'
			end

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData235382_400002.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec huayao_InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update huayao_invoiced set writeoffState=1 where writeoffState=0 and xs_sn in(select xs_sn from huayao_invoiced where kphm=@kphm)
			update huayao_fh set writeoffState=1 from huayao_fh a inner join huayao_invoiced b on b.xs_sn=a.xs_sn
			where a.writeoffState<1 and a.xs_sn in(select xs_sn from huayao_invoiced where kphm=@kphm)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@kphm
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[huayao_Notinvoiced_gr]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	未开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[huayao_Notinvoiced_gr] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要为XX月未开票XXX产品XX吨客户名称,借方含税金额，贷方不含税金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@summoney numeric(12,2),@goodsname nvarchar(100),@price numeric(10,2),@amount numeric(18,4)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@strTemp nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2),@money numeric(12,2)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@th_id int, @amount_th numeric(18,4),@money_th numeric(18,2)

	DECLARE @tb_goods TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50),@customer_summary nvarchar(200)
	
	DECLARE customer_Cursor CURSOR FOR select customer,sum(money) from v_huayao_fh where writeoffState=0 and [money]>0 and year(zcsj)=@currentYear and month(zcsj)=@currentPeriod
	and (customer_type='个人' or (customer_type='企业' and yfjsfs not like'%华%'))
	group by customer order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    while @@fetch_status = 0
    begin
		select @customer_summary=dbo.GetAuxiliaryItems(@Customer,'未开票')

		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec huayao_AddVoucherMaster @customer_summary,@summoney,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=120
		if @idDocDTO>0
		begin
			set @sequencenumber=1
			set @code='0000'
			--科目表
			select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='1122001' and accountingyear=@currentYear and isEndNode=1 and IsAux=1 --应收账款-1

			delete from @tb_goods  --清空数据

			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'未开票第一行',1,@summoney,null,@summoney,null,null,null,@sequencenumber,@customer_summary,@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,sum(amount_jing),sum([money]) 
			from v_huayao_fh where writeoffState=0 and [money]>0 and customer=@Customer and year(zcsj)=@currentYear and month(zcsj)=@currentPeriod 
			and (customer_type='个人' or (customer_type='企业' and yfjsfs not like'%华%'))
			group by goodsname,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where name=@goodsname and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary=cast(@currentPeriod as varchar(10))+'月未开票'+@customer_summary+' '+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
				set @rowmoney=@money/1.03  --减去税额3%
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@rowmoney,null,@rowmoney,@amount,@price/1.03,@sequencenumber,@customer_summary,@idaccount,4,@idDocDTO,1)
				--print @row_summary
				insert into @tb_goods(goodsname,amount)values(@goodsname,@amount) --插入表变量
					
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor

			set @head_summary=cast(@currentPeriod as varchar(10))+'月未开票'+@customer_summary
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_goods group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor

			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') --替换第一个'+'字符
			--print @head_summary
			--更新第一行摘要
			update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='未开票第一行'

			--尾行汇总
			set @foot_summary=cast(@currentPeriod as varchar(10))+'月未开票'+@customer_summary 
			--print @foot_summary
			select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='2221020' and accountingyear=@currentYear and isEndNode=1 order by depth --应交税费-简易计税
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountcr_total,null,(@amountdr_total-@amountcr_total),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData235382_400002.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			, accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec huayao_InsertVoucherJournal @idDocDTO

			--反写销售出库
			update huayao_fh set writeoffState=-1 where writeoffState=0 and [money]>0 and customer=@Customer and year(zcsj)=@currentYear and month(zcsj)=@currentPeriod
			and (customer_type='个人' or (customer_type='企业' and yfjsfs not like'%华%'))
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[huayao_Notinvoiced_one]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	未开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[huayao_Notinvoiced_one] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要为XX月未开票XXX产品XX吨客户名称,借方含税金额，贷方不含税金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@summoney numeric(12,2),@goodsname nvarchar(100),@price numeric(10,2),@amount numeric(18,4)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@strTemp nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2),@money numeric(12,2)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@th_id int, @amount_th numeric(18,4),@money_th numeric(18,2)

	DECLARE @tb_goods TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50),@customer_summary nvarchar(200)
	
	DECLARE customer_Cursor CURSOR FOR select customer,sum(money) from v_huayao_fh where writeoffState=0 and [money]>0 and year(zcsj)=@currentYear and month(zcsj)=@currentPeriod
	and customer_type='企业' and yfjsfs like'%-1'
	group by customer order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    while @@fetch_status = 0
    begin
		select @customer_summary=dbo.GetAuxiliaryItems(@Customer,'未开票')

		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec huayao_AddVoucherMaster @Customer,@summoney,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=120
		if @idDocDTO>0
		begin
			set @sequencenumber=1
			set @code='0000'
			--科目表
			select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='1122001' and accountingyear=@currentYear and isEndNode=1 and IsAux=1 --应收账款-1

			delete from @tb_goods  --清空数据

			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'未开票第一行',1,@summoney,null,@summoney,null,null,null,@sequencenumber,@customer_summary,@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,sum(amount_jing),sum([money]) 
			from v_huayao_fh where writeoffState=0 and [money]>0 and customer=@Customer and year(zcsj)=@currentYear and month(zcsj)=@currentPeriod 
			and customer_type='企业' and yfjsfs like'%-1'
			group by goodsname,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where name=@goodsname and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary=cast(@currentPeriod as varchar(10))+'月未开票'+@customer_summary+' '+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
				set @rowmoney=@money/1.03  --减去税额3%
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.03,@sequencenumber,@customer_summary,@idaccount,4,@idDocDTO,1)
				--print @row_summary
				insert into @tb_goods(goodsname,amount)values(@goodsname,@amount) --插入表变量
					
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor

			set @head_summary=cast(@currentPeriod as varchar(10))+'月未开票'+@customer_summary
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_goods group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor

			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') --替换第一个'+'字符
			--print @head_summary
			--更新第一行摘要
			update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='未开票第一行'

			--尾行汇总
			set @foot_summary=cast(@currentPeriod as varchar(10))+'月未开票'+@Customer 
			--print @foot_summary
			select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='2221020' and accountingyear=@currentYear and isEndNode=1 order by depth --应交税费-简易计税
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,round((@amountdr_total-@amountcr_total),2),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--运输费用
			set @money=0
			select @money=sum(yf_sjyfje) from v_huayao_fh where writeoffState=0 and [money]>0 and customer=@Customer 
			and year(zcsj)=@currentYear and month(zcsj)=@currentPeriod and customer_type='企业' and yfjsfs like'%-1'
			if @money>0
			begin
				set @head_summary='计提'+cast(@currentPeriod as varchar(4))+'月未开票'+@customer_summary+'运费'
				--科目表
				select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='6601010' and accountingyear=@currentYear --销售费用-运输费
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
			
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,'运费第一行',1,@money,null,@money,null,null,null,@sequencenumber,@customer_summary,@idaccount,4,@idDocDTO,null)

				--明细
				DECLARE Entry_Cursor CURSOR FOR select goodsname,sum(amount_jing) from v_huayao_fh where writeoffState=0 and [money]>0 and customer=@Customer 
				and year(zcsj)=@currentYear and month(zcsj)=@currentPeriod and customer_type='企业' and yfjsfs like'%-1'
				group by goodsname order by goodsname
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
				while @@fetch_status = 0
				begin
					set @head_summary=@head_summary+'+'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'')
				--print @head_summary

				--科目表
				select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear --应付账款-暂估应付款
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
			
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@head_summary,1,null,@money,null,@money,null,null,@sequencenumber,'司机运费',@idaccount,4,@idDocDTO,null)
				--更新运费第一行摘要
				update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary where idDocDTO=@idDocDTO and summary='运费第一行'
			end

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData235382_400002.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			, accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec huayao_InsertVoucherJournal @idDocDTO

			--反写销售出库
			update huayao_fh set writeoffState=-1 where writeoffState=0 and [money]>0 and customer=@Customer and year(zcsj)=@currentYear and month(zcsj)=@currentPeriod
			and customer_type='企业' and yfjsfs like'%-1'
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[huayao_Notinvoiced_one_period]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: 2023-11-1
-- Description:	未开票凭证-一票制分段
-- =============================================
CREATE PROCEDURE [dbo].[huayao_Notinvoiced_one_period] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要为XX月未开票XXX产品XX吨客户名称,借方含税金额，贷方不含税金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@customer_period nvarchar(50),@summoney numeric(12,2),@goodsname nvarchar(100),@price numeric(10,2),@amount numeric(18,4)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2),@money numeric(12,2)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2)

	CREATE TABLE #tb_customer(xs_sn varchar(50),customer varchar(100),fhrq DateTime,goodsname varchar(50),price numeric(18,2),amount numeric(18,4),money numeric(18,2)
		,startTime DateTime,endTime DateTime)
	DECLARE @tb_goods TABLE(goodscategory varchar(50),goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	DECLARE @bigCustomer nvarchar(100),@startTime DateTime,@endTime DateTime
	
	DECLARE period_Cursor CURSOR FOR select customer,startTime,endTime from huayao_period 
	where customer='华宏'
	order by id
	OPEN period_Cursor
    FETCH NEXT FROM period_Cursor INTO @bigCustomer,@startTime,@endTime
    while @@fetch_status = 0
    begin
		insert into #tb_customer(xs_sn,customer,fhrq,goodsname,price,amount,money,startTime,endTime)
		select xs_sn,customer,zcsj,goodsname,price,amount_jing,money,@startTime,@endTime from v_huayao_fh 
		where writeoffState=0 and zcsj>=@startTime and zcsj<@endTime and customer like'%'+@bigCustomer+'%'
		and customer_type='企业' and yfjsfs like'%-1'
		order by customer,zcsj
	    FETCH NEXT FROM period_Cursor INTO @bigCustomer,@startTime,@endTime
    end
    CLOSE period_Cursor
    DEALLOCATE period_Cursor

	DECLARE customer_Cursor CURSOR FOR select customer,startTime,endTime from #tb_customer 
	group by customer,startTime,endTime order by customer,startTime
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@startTime,@endTime
    while @@fetch_status = 0
    begin
		select @customer_period=replace(right(convert(varchar(10),@startTime,23),5),'-','.')+'-'+replace(right(convert(varchar(10),@endTime,23),5),'-','.')

		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec huayao_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=120
		if @idDocDTO>0
		begin
			set @sequencenumber=1
			set @code='0000'
			--科目表
			select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='1122001' and accountingyear=@currentYear and isEndNode=1 and IsAux=1 --应收账款-1
			delete from @tb_goods  --清空数据

			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'未开票第一行',1,@summoney,null,@summoney,null,null,null,@sequencenumber,dbo.GetAuxiliaryItems(@Customer,'未开票'),@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,sum(amount),sum([money]) 
			from #tb_customer where customer=@Customer and startTime=@startTime and endTime=@endTime
			group by goodsname,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where name=@goodsname and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary=@customer_period+'未开票'+@Customer+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
				set @rowmoney=@money/1.03  --减去税额3%
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.03,@sequencenumber,dbo.GetAuxiliaryItems(@Customer,'未开票'),@idaccount,4,@idDocDTO,1)
				--print @row_summary
				insert into @tb_goods(goodscategory, goodsname,amount)values(replace(@goodsname,'(1)',''),@goodsname,@amount) --插入表变量
					
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor

			set @head_summary=@customer_period+'未开票'+@Customer
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodscategory,sum(amount) from @tb_goods group by goodscategory 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor

			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') --替换第一个'+'字符
			--print @head_summary
			--更新开票第一行摘要
			update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='未开票第一行'

			--尾行汇总
			set @foot_summary=@customer_period+'未开票'+@Customer
			--print @foot_summary
			select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='2221020' and accountingyear=@currentYear and isEndNode=1 order by depth --应交税费-简易计税
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			--运输费用
			set @money=0
			select @money=sum(yf_sjyfje) from v_huayao_fh where writeoffState=0 and zcsj>=@startTime and zcsj<@endTime and customer=@Customer
			and customer_type='企业' and yfjsfs like'%-1'
			if @money>0
			begin
				set @head_summary='计提'+@customer_period+'未开票'+@Customer+'运费'
				--科目表
				select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='6601010' and accountingyear=@currentYear --销售费用-运输费
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
			
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,'运费第一行',1,@money,null,@money,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

				--明细
				DECLARE Entry_Cursor CURSOR FOR select goodsname,sum(amount_jing) from v_huayao_fh where writeoffState=0 and zcsj>=@startTime and zcsj<@endTime and customer=@Customer
				and customer_type='企业' and yfjsfs like'%-1'
				group by goodsname order by goodsname
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
				while @@fetch_status = 0
				begin
					set @head_summary=@head_summary+'+'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'')
				--print @head_summary

				--科目表
				select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear --应付账款-暂估应付款
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
			
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@head_summary,1,null,@money,null,@money,null,null,@sequencenumber,'司机运费',@idaccount,4,@idDocDTO,null)
				--更新运费第一行摘要
				update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary where idDocDTO=@idDocDTO and summary='运费第一行'
			end

			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,round((@amountdr_total-@amountcr_total),2),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData235382_400002.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			, accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec huayao_InsertVoucherJournal @idDocDTO

			--反写销售出库
			update huayao_fh set writeoffState=-1 where writeoffState=0 and xs_sn in(select xs_sn from #tb_customer where customer=@Customer 
			and startTime=@startTime and endTime=@endTime)
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@startTime,@endTime
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

	drop table #tb_customer
END
GO
/****** Object:  StoredProcedure [dbo].[huayao_Notinvoiced_period]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: 2023-11-1
-- Description:	未开票凭证-对账期间
-- =============================================
CREATE PROCEDURE [dbo].[huayao_Notinvoiced_period] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要为XX月未开票XXX产品XX吨客户名称,借方含税金额，贷方不含税金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@summoney numeric(12,2),@goodsname nvarchar(100),@price numeric(10,2),@amount numeric(18,4)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2),@money numeric(12,2)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2)

	CREATE TABLE #tb_customer(xs_sn varchar(50),customer varchar(100),fhrq DateTime,goodsname varchar(50),price numeric(18,2),amount numeric(18,4),money numeric(18,2)
		,startTime DateTime,endTime DateTime)
	DECLARE @tb_goods TABLE(goodscategory varchar(50),goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	DECLARE @bigCustomer nvarchar(100),@startTime DateTime,@endTime DateTime
	
	DECLARE period_Cursor CURSOR FOR select customer,startTime,endTime from huayao_period 
	where isnull(customer,'')<>''
	order by id
	OPEN period_Cursor
    FETCH NEXT FROM period_Cursor INTO @bigCustomer,@startTime,@endTime
    while @@fetch_status = 0
    begin
		if @bigCustomer='华宏'
		begin
			insert into #tb_customer(xs_sn,customer,fhrq,goodsname,price,amount,money,startTime,endTime)
			select xs_sn,customer,zcsj,goodsname,price,amount_jing,money,@startTime,@endTime from v_huayao_fh 
			where writeoffState=0 and zcsj>=@startTime and zcsj<@endTime and customer like'%'+@bigCustomer+'%'
			order by customer,zcsj
		end
		--else if @bigCustomer='中建西部建设'
		--begin
		--	insert into #tb_customer(xs_sn,customer,fhrq,goodsname,price,amount,money,startTime,endTime)
		--	select xs_sn,customer,hdrq,goodsname,price,amount_jing,money,@startTime,@endTime from v_huayao_fh 
		--	where writeoffState=0 and hdrq>=@startTime and hdrq<@endTime and customer like'%'+@bigCustomer+'%'
		--	order by customer,zcsj
		--end
	    FETCH NEXT FROM period_Cursor INTO @bigCustomer,@startTime,@endTime
    end
    CLOSE period_Cursor
    DEALLOCATE period_Cursor

	DECLARE customer_Cursor CURSOR FOR select customer,startTime,endTime from #tb_customer 
	group by customer,startTime,endTime order by customer,startTime
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@startTime,@endTime
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec huayao_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=120
		if @idDocDTO>0
		begin
			set @sequencenumber=1
			set @code='0000'
			--科目表
			select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='1122001' and accountingyear=@currentYear and isEndNode=1 and IsAux=1 --应收账款-1
			delete from @tb_goods  --清空数据

			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'未开票第一行',1,@summoney,null,@summoney,null,null,null,@sequencenumber,dbo.GetAuxiliaryItems(@Customer,'未开票'),@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,sum(amount),sum([money]) 
			from #tb_customer where customer=@Customer and startTime=@startTime and endTime=@endTime
			group by goodsname,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where name=@goodsname and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary=replace(right(convert(varchar(10),@startTime,23),5),'-','.')+'-'+replace(right(convert(varchar(10),@endTime,23),5),'-','.')+'未开票'+@Customer+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
				set @rowmoney=@money/1.03  --减去税额3%
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.03,@sequencenumber,dbo.GetAuxiliaryItems(@Customer,'未开票'),@idaccount,4,@idDocDTO,1)
				--print @row_summary
				insert into @tb_goods(goodscategory, goodsname,amount)values(replace(@goodsname,'(1)',''),@goodsname,@amount) --插入表变量
					
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor

			set @head_summary=replace(right(convert(varchar(10),@startTime,23),5),'-','.')+'-'+replace(right(convert(varchar(10),@endTime,23),5),'-','.')+'未开票'+@Customer
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodscategory,sum(amount) from @tb_goods group by goodscategory 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor

			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') --替换第一个'+'字符
			--print @head_summary
			--更新开票第一行摘要
			update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='未开票第一行'

			--尾行汇总
			set @foot_summary=replace(right(convert(varchar(10),@startTime,23),5),'-','.')+'-'+replace(right(convert(varchar(10),@endTime,23),5),'-','.')+'未开票'+@Customer
			--print @foot_summary
			select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='2221020' and accountingyear=@currentYear and isEndNode=1 order by depth --应交税费-简易计税
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,round((@amountdr_total-@amountcr_total),2),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData235382_400002.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			, accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec huayao_InsertVoucherJournal @idDocDTO

			--反写销售出库
			update huayao_fh set writeoffState=-1 where writeoffState=0 and xs_sn in(select xs_sn from #tb_customer where customer=@Customer 
			and startTime=@startTime and endTime=@endTime)
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@startTime,@endTime
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

	drop table #tb_customer
END
GO
/****** Object:  StoredProcedure [dbo].[huayao_Notinvoiced_two]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	未开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[huayao_Notinvoiced_two] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要为XX月未开票XXX产品XX吨客户名称,借方含税金额，贷方不含税金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@summoney numeric(12,2),@goodsname nvarchar(100),@price numeric(10,2),@amount numeric(18,4)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@strTemp nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2),@money numeric(12,2)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@th_id int, @amount_th numeric(18,4),@money_th numeric(18,2)

	DECLARE @tb_goods TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50),@customer_summary nvarchar(200)
	
	DECLARE customer_Cursor CURSOR FOR select customer,sum(money) from v_huayao_fh where writeoffState=0 and [money]>0 and year(zcsj)=@currentYear and month(zcsj)=@currentPeriod
	and customer_type='企业' and yfjsfs like'%-2' and (customer not like'%华宏%' and customer not like'%中建西部建设%')
	group by customer order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    while @@fetch_status = 0
    begin
		select @customer_summary=dbo.GetAuxiliaryItems(@Customer,'未开票')

		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec huayao_AddVoucherMaster @Customer,@summoney,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=120
		if @idDocDTO>0
		begin
			set @sequencenumber=1
			set @code='0000'
			--科目表
			select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='1122001' and accountingyear=@currentYear and isEndNode=1 and IsAux=1 --应收账款-1

			delete from @tb_goods  --清空数据

			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'未开票第一行',1,@summoney,null,@summoney,null,null,null,@sequencenumber,@customer_summary,@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,sum(amount_jing),sum([money]) 
			from v_huayao_fh where writeoffState=0 and [money]>0 and customer=@Customer and year(zcsj)=@currentYear and month(zcsj)=@currentPeriod 
			and customer_type='企业' and yfjsfs like'%-2' and (customer not like'%华宏%' and customer not like'%中建西部建设%')
			group by goodsname,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where name=@goodsname and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary=cast(@currentPeriod as varchar(10))+'月未开票'+@customer_summary+' '+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
				set @rowmoney=@money/1.03  --减去税额3%
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.03,@sequencenumber,@customer_summary,@idaccount,4,@idDocDTO,1)
				--print @row_summary
				insert into @tb_goods(goodsname,amount)values(@goodsname,@amount) --插入表变量
					
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor

			set @head_summary=cast(@currentPeriod as varchar(10))+'月未开票'+@customer_summary
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_goods group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor

			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') --替换第一个'+'字符
			--print @head_summary
			--更新第一行摘要
			update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='未开票第一行'

			--尾行汇总
			set @foot_summary=cast(@currentPeriod as varchar(10))+'月未开票'+@Customer 
			--print @foot_summary
			select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='2221020' and accountingyear=@currentYear and isEndNode=1 order by depth --应交税费-简易计税
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,round((@amountdr_total-@amountcr_total),2),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData235382_400002.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			, accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec huayao_InsertVoucherJournal @idDocDTO

			--反写销售出库
			update huayao_fh set writeoffState=-1 where writeoffState=0 and [money]>0 and customer=@Customer and year(zcsj)=@currentYear and month(zcsj)=@currentPeriod
			and customer_type='企业' and yfjsfs like'%-2' and (customer not like'%华宏%' and customer not like'%中建西部建设%')

			--生成路畅运费凭证
			exec luchang_Notinvoiced @Customer,@currentYear,@currentPeriod
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[huayao_WriteOffNotinvoiced_endMonth]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销月底09.28-09.30未开票
-- =============================================
CREATE PROCEDURE [dbo].[huayao_WriteOffNotinvoiced_endMonth] 
(
	@currentYear int,
	@currentPeriod int,
	@customer nvarchar(100),
	@customer_period nvarchar(50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方=含税金额，贷方金额=含税金额/1.03
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@sequencenumber int,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int
	DECLARE @summoney numeric(18,2),@row_summary nvarchar(max),@idaccount int,@idDocDTO int,@voucher_id int,@doccode nvarchar(30),@voucherdate datetime
	
	declare @summary_keyword varchar(50),@startDate varchar(10),@endDate varchar(10)
	set @startDate=replace(left(@customer_period,11),'.','-')
	select @endDate=convert(varchar(10),dateadd(month, datediff(month, -1, @startDate), -1),120) --当月最后一天
	
	select @summary_keyword=replace(right(@startDate,5),'-','.') + '-' + replace(right(@endDate,5),'-','.')

	set @voucher_id=0
	select Top 1 @voucher_id=b.id from UFTData235382_400002.dbo.GL_Doc b inner join UFTData235382_400002.dbo.GL_Entry a on a.idDocDTO=b.id
	where accountingyear=year(@endDate) and accountingperiod=month(@endDate) and iddoctype=5 
	and a.summary like @summary_keyword+'未开票%'+dbo.GetSummaryKey(@Customer)+'%' and a.AuxiliaryItems like dbo.GetAuxiliaryItems(@Customer,'未开票')+'%'
	order by b.voucherdate
	if @voucher_id>0
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec huayao_AddVoucherMaster @customer,0,@currentYear,@currentPeriod,'冲销月底',@idDocDTO output
		--set @idDocDTO=9988
		if @idDocDTO>0
		begin
			--delete from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO

			--获取要冲红的之前凭证
			select @doccode=code,@voucherdate=voucherdate from UFTData235382_400002.dbo.GL_Doc where id=@voucher_id
			DECLARE Entry_Cursor CURSOR FOR select code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitycr,price,sequencenumber,AuxiliaryItems,idaccount,idcurrency,idUnit
			from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@voucher_id
			order by idDocDTO,code
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
			while @@fetch_status = 0
			begin
				set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转1-'+@doccode+'号凭证]'+@Entrysummary
				--科目
				select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code in(select code from UFTData235382_400002.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear

				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@Entrycode,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData235382_400002.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec huayao_InsertVoucherJournal @idDocDTO
		end
	end

END
GO
/****** Object:  StoredProcedure [dbo].[huayao_WriteOffNotinvoiced_gr]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[huayao_WriteOffNotinvoiced_gr] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方=含税金额，贷方金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@id nvarchar(50),@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@options nvarchar(50),@moneyNotax numeric(18,2),@moneyTax numeric(18,2),@amountPc numeric(18,4),@moneyPc numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@lastMonthDate DateTime
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),xs_sn varchar(50),fhrq DateTime,customer varchar(100),goodsname varchar(50),price numeric(18,2),amount numeric(18,4)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50),amount_pc numeric(18,4),money_pc numeric(18,2))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)

	--上月
	select @lastMonthDate=DateAdd(month,-1,cast(@currentYear as varchar(4))+'-'+cast(@currentPeriod as varchar(2))+'-01')

	DECLARE customer_Cursor CURSOR FOR select id,customer,xs_sn,fhrq,goodsname,price,amount,[money],kphm,options,money_notax,money_tax,amount_pc,money_pc from huayao_invoiced 
	where writeoffState=0 and money>0 and options<>'冲红' and convert(int,(DATENAME(year,kprq)+DATENAME(month,kprq)))>convert(int,(DATENAME(year,fhrq)+DATENAME(month,fhrq)))
	and year(kprq)=@currentYear and month(kprq)=@currentPeriod and (customer_type='个人' or (customer_type='企业' and yfjsfs not like'%华%'))
	and isnull(kpdw,'')='' and dw='广西华耀石材有限公司'
	order by customer,kphm,fhrq,goodsname
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@options,@moneyNotax,@moneyTax,@amountPc,@moneyPc
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select Top 1 @voucher_id=b.id from UFTData235382_400002.dbo.GL_Doc b inner join UFTData235382_400002.dbo.GL_Entry a on a.idDocDTO=b.id
		where accountingyear=year(@lastMonthDate) and accountingperiod=month(@lastMonthDate) and iddoctype=5 
		and a.summary like CAST(accountingperiod as varchar(10))+'月%未开票%' and a.AuxiliaryItems like dbo.GetAuxiliaryItems(@Customer,'开票')+'%'
		order by b.voucherdate
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm,options,amount_pc,money_pc)
			values(@voucher_id,@id,@xs_sn,@Customer,@fhrq,@goodsname,@price,@amount,@money,@moneyNotax,@moneyTax,@kphm,@options,@amountPc,@moneyPc)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@options,@moneyNotax,@moneyTax,@amountPc,@moneyPc
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
    DECLARE tbgoods_Cursor CURSOR FOR select customer,kphm from @tb_goods 
    group by customer,kphm order by customer
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec huayao_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=9545
		if @idDocDTO>0
		begin
			--delete from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO
			select Top 1 @options=options from @tb_goods where customer=@Customer and kphm=@kphm
			set @sequencenumber=1
			set @code='0000'

			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where kphm=@kphm 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				--获取要冲红的之前凭证
				select @doccode=code,@voucherdate=voucherdate from UFTData235382_400002.dbo.GL_Doc where id=@voucher_id
				DECLARE Entry_Cursor CURSOR FOR select code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitycr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@voucher_id
				order by idDocDTO,code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转1-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code in(select code from UFTData235382_400002.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear

					insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)

					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					set @sequencenumber=@sequencenumber+1
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm,amount_pc,money_pc)
			select '0',id,xs_sn,@Customer,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm,amount_pc,money_pc 
			from huayao_invoiced b where kphm=@kphm and ISNULL(options,'')='' and id not in(select id from @tb_goods where kphm=@kphm)
			and not exists(select 1 from @tb_goods where id=b.id)

			--科目表
			select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='1122001' and accountingyear=@currentYear and isEndNode=1 and IsAux=1 --应收账款-1
			
			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'开票第一行',1,2,null,2,null,null,null,@sequencenumber,dbo.GetAuxiliaryItems(@Customer,'开票'),@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from @tb_goods where kphm=@kphm
			group by goodsname,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where name=@goodsname and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='开票'+cast(month(@lastMonthDate) as varchar(4))+'月'+@Customer+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+' '+@options+' '+@kphm
				set @amountcr_total=@amountcr_total+@moneyNotax  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
				
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@moneyNotax,null,@moneyNotax,@amount,@price/1.03,@sequencenumber,dbo.GetAuxiliaryItems(@Customer,'开票'),@idaccount,4,@idDocDTO,1)

				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			set @head_summary='开票'+cast(month(@lastMonthDate) as varchar(4))+'月'+@Customer
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_goods 
			where kphm=@kphm 
			group by goodsname order by goodsname
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +' '+@options+' '+@kphm --替换第一个'+'字符
			--print @head_summary
			--更新开票第一行摘要
			update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='开票第一行'

			--尾行汇总
			set @foot_summary='开票'+cast(month(@lastMonthDate) as varchar(4))+'月'+@Customer +'  '+@options+' '+@kphm
			--print @foot_summary
			select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='2221020' and accountingyear=@currentYear and isEndNode=1 order by depth --应交税费-简易计税
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			
			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--磅差
			set @money=0
			set @amount=0
			if exists(select 1 from @tb_goods where abs(amount_pc)>0 and kphm=@kphm)
			begin
				set @head_summary=cast(month(@lastMonthDate) as varchar(4))+'月'+@Customer+'磅差'
				--科目表-借方金额
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='6601012' and accountingyear=@currentYear --销售费用-运输途中合理损耗
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,'磅差第一行',1,null,null,null,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

				--明细
				DECLARE Entry_Cursor CURSOR FOR select goodsname,sum(amount_pc),sum(money_pc)
				from @tb_goods where abs(amount_pc)>0 and kphm=@kphm
				group by goodsname,price order by goodsname
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount,@money
				while @@fetch_status = 0
				begin
					--科目表
					select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where left(code,4)='1405' and name=@goodsname and accountingyear=@currentYear  --库存商品-水洗砂

					set @head_summary=@head_summary+'+'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
					set @row_summary=cast(month(@lastMonthDate) as varchar(4))+'月'+@Customer+'磅差'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
					set @price=@money/@amount
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
					insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount,@money
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'')
				--print @head_summary
				--更新合理损耗第一行摘要
				update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary where idDocDTO=@idDocDTO and summary='磅差第一行'
			end

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData235382_400002.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec huayao_InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update huayao_invoiced set writeoffState=1 where writeoffState=0 and options<>'冲红' and xs_sn in(select xs_sn from @tb_goods where kphm=@kphm)
			update huayao_fh set writeoffState=1 from huayao_fh a inner join huayao_invoiced b on b.xs_sn=a.xs_sn
			where a.writeoffState<1 and a.xs_sn in(select xs_sn from @tb_goods where kphm=@kphm)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@kphm
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[huayao_WriteOffNotinvoiced_one]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[huayao_WriteOffNotinvoiced_one] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方=含税金额，贷方金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@id nvarchar(50),@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@options nvarchar(50),@moneyNotax numeric(18,2),@moneyTax numeric(18,2),@amountPc numeric(18,4),@moneyPc numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@lastMonthDate DateTime
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),xs_sn varchar(50),fhrq DateTime,customer varchar(100),goodsname varchar(50),price numeric(18,2),amount numeric(18,4)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50),amount_pc numeric(18,4),money_pc numeric(18,2))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)

	--上月
	select @lastMonthDate=DateAdd(month,-1,cast(@currentYear as varchar(4))+'-'+cast(@currentPeriod as varchar(2))+'-01')

	DECLARE customer_Cursor CURSOR FOR select id,customer,xs_sn,fhrq,goodsname,price,amount,[money],kphm,options,money_notax,money_tax,amount_pc,money_pc from huayao_invoiced 
	where writeoffState=0 and money>0 and convert(int,(DATENAME(year,kprq)+DATENAME(month,kprq)))>convert(int,(DATENAME(year,fhrq)+DATENAME(month,fhrq)))
	and year(kprq)=@currentYear and month(kprq)=@currentPeriod and customer_type='企业' and yfjsfs like'%-1'
	and isnull(kpdw,'')='' and dw='广西华耀石材有限公司'
	order by customer,kphm,fhrq,goodsname
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@options,@moneyNotax,@moneyTax,@amountPc,@moneyPc
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select Top 1 @voucher_id=b.id from UFTData235382_400002.dbo.GL_Doc b inner join UFTData235382_400002.dbo.GL_Entry a on a.idDocDTO=b.id
		where accountingyear=year(@lastMonthDate) and accountingperiod=month(@lastMonthDate) and iddoctype=5 
		and a.summary like CAST(accountingperiod as varchar(10))+'月%未开票%' and a.AuxiliaryItems like dbo.GetAuxiliaryItems(@Customer,'开票')+'%'
		order by b.voucherdate
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm,options,amount_pc,money_pc)
			values(@voucher_id,@id,@xs_sn,@Customer,@fhrq,@goodsname,@price,@amount,@money,@moneyNotax,@moneyTax,@kphm,@options,@amountPc,@moneyPc)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@options,@moneyNotax,@moneyTax,@amountPc,@moneyPc
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
    DECLARE tbgoods_Cursor CURSOR FOR select customer,kphm from @tb_goods 
    group by customer,kphm order by customer
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec huayao_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=79294
		if @idDocDTO>0
		begin
			select Top 1 @options=options from @tb_goods where customer=@Customer and kphm=@kphm
			set @sequencenumber=1
			set @code='0000'

			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where customer=@Customer and kphm=@kphm 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				--获取要冲红的之前凭证
				select @doccode=code,@voucherdate=voucherdate from UFTData235382_400002.dbo.GL_Doc where id=@voucher_id
				DECLARE Entry_Cursor CURSOR FOR select code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitycr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@voucher_id
				order by idDocDTO,code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转1-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code in(select code from UFTData235382_400002.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear

					insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)

					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					set @sequencenumber=@sequencenumber+1
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm,amount_pc,money_pc)
			select '0',id,xs_sn,customer,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm,amount_pc,money_pc 
			from huayao_invoiced b where kphm=@kphm and ISNULL(options,'')='' and id not in(select id from @tb_goods where kphm=@kphm)
			and not exists(select 1 from @tb_goods where id=b.id)

			--科目表
			select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='1122001' and accountingyear=@currentYear --应收账款-1
			
			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'开票第一行',1,2,null,2,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from @tb_goods where kphm=@kphm
			group by goodsname,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where name=@goodsname and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='开票'+cast(month(@lastMonthDate) as varchar(4))+@Customer+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+' '+@options+' '+@kphm
				set @amountcr_total=@amountcr_total+@moneyNotax  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
				
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@moneyNotax,null,@moneyNotax,@amount,@price/1.03,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)

				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			set @head_summary='开票'+cast(month(@lastMonthDate) as varchar(4))+'月'+@Customer
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_goods 
			where kphm=@kphm 
			group by goodsname order by goodsname
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+' '+@options+' '+@kphm --替换第一个'+'字符
			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='2221020' and accountingyear=@currentYear --应交税费-简易计税
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			
			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--print @foot_summary
			--print @updateRow
			--更新开票第一行摘要
			update UFTData235382_400002.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='开票第一行'

			--运输费用
			set @money=0
			select @money=sum(money) from huayao_invoiced 
			where kphm in(select distinct kphm from huayao_invoiced where dw='南宁市武鸣区路畅运输有限公司'
			and xs_sn in(select xs_sn from huayao_invoiced where kphm=@kphm))
			if @money>0
			begin
				set @head_summary=cast(month(@lastMonthDate) as varchar(4))+'月'+@Customer+'运费'
				--科目表
				select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='6601010' and accountingyear=@currentYear --销售费用-运输费
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
			
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,'运费第一行',1,@money,null,@money,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

				--明细
				DECLARE Entry_Cursor CURSOR FOR select goodsname,sum(amount) from huayao_invoiced
				where kphm in(select distinct kphm from huayao_invoiced where dw='南宁市武鸣区路畅运输有限公司'
				and xs_sn in(select xs_sn from huayao_invoiced where kphm=@kphm))
				group by goodsname order by goodsname
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
				while @@fetch_status = 0
				begin
					set @head_summary=@head_summary+'+'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'')
				--print @head_summary

				--科目表
				select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='2202004' and accountingyear=@currentYear --应付账款-应付账款1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
			
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@head_summary,1,null,@money,null,@money,null,null,@sequencenumber,'南宁市武鸣区路畅运输有限公司',@idaccount,4,@idDocDTO,null)
				--更新运费第一行摘要
				update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary where idDocDTO=@idDocDTO and summary='运费第一行'
			end

			--磅差
			set @money=0
			set @amount=0
			if exists(select 1 from @tb_goods where abs(amount_pc)>0 and kphm=@kphm)
			begin
				set @head_summary=cast((@currentPeriod-1) as varchar(4))+'月'+@Customer+'磅差'
				--科目表-借方金额
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='6601012' and accountingyear=@currentYear --销售费用-运输途中合理损耗
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,'磅差第一行',1,null,null,null,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

				--明细
				DECLARE Entry_Cursor CURSOR FOR select goodsname,sum(amount_pc),sum(money_pc)
				from @tb_goods where kphm=@kphm
				group by goodsname,price order by goodsname
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount,@money
				while @@fetch_status = 0
				begin
					--科目表
					select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where left(code,4)='1405' and name=@goodsname and accountingyear=@currentYear  --库存商品-水洗砂

					set @head_summary=@head_summary+'+'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
					set @row_summary=cast(month(@lastMonthDate) as varchar(4))+'月'+@Customer+'磅差'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
					set @price=@money/@amount
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
					insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount,@money
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'')
				--print @head_summary
				--更新合理损耗第一行摘要
				update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary where idDocDTO=@idDocDTO and summary='磅差第一行'
			end

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData235382_400002.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec huayao_InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update huayao_invoiced set writeoffState=1 where writeoffState=0 and xs_sn in(select xs_sn from @tb_goods where kphm=@kphm)
			update huayao_fh set writeoffState=1 from huayao_fh a inner join huayao_invoiced b on b.xs_sn=a.xs_sn
			where a.writeoffState<1 and a.xs_sn in(select xs_sn from @tb_goods where kphm=@kphm)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@kphm
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[huayao_WriteOffNotinvoiced_two]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[huayao_WriteOffNotinvoiced_two] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方=含税金额，贷方金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@id nvarchar(50),@customer_period nvarchar(50),@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@options nvarchar(50),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@lastMonthDate DateTime
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),xs_sn varchar(50),fhrq DateTime,customer varchar(100),customer_period varchar(50),goodsname varchar(50)
		,price numeric(18,2),amount numeric(18,4),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)

	select @lastMonthDate=DateAdd(day,-1,Convert(DateTime,(cast(@currentYear as varchar(4))+'-'+cast(@currentPeriod as varchar(4))+'-1')))

	DECLARE customer_Cursor CURSOR FOR select id,customer,customer_period,xs_sn,fhrq,goodsname,price,amount,[money],kphm,options,money_notax,money_tax 
	from huayao_invoiced where writeoffState=0 and money>0 and convert(int,(DATENAME(year,kprq)+DATENAME(month,kprq)))>convert(int,(DATENAME(year,fhrq)+DATENAME(month,fhrq)))
	and year(kprq)=@currentYear and month(kprq)=@currentPeriod and customer_type='企业' and yfjsfs like'%-2'
	and isnull(kpdw,'')='' and dw='广西华耀石材有限公司' 
	and customer_period=''
	order by customer,kphm,fhrq,goodsname
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@customer_period,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@options,@moneyNotax,@moneyTax
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select Top 1 @voucher_id=b.id from UFTData235382_400002.dbo.GL_Doc b inner join UFTData235382_400002.dbo.GL_Entry a on a.idDocDTO=b.id
		where accountingyear=year(@lastMonthDate) and accountingperiod=month(@lastMonthDate) and iddoctype=5 
		and a.summary like dbo.GetCustomerPeriod(@lastMonthDate,@customer_period)+'未开票%'+dbo.GetSummaryKey(@Customer)+'%' and a.AuxiliaryItems like @Customer+'%'
		order by b.voucherdate
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,xs_sn,customer,customer_period,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@xs_sn,@Customer,@customer_period,@fhrq,@goodsname,@price,@amount,@money,@moneyNotax,@moneyTax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@customer_period,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@options,@moneyNotax,@moneyTax
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
    DECLARE tbgoods_Cursor CURSOR FOR select kphm,customer_period from @tb_goods group by kphm,customer_period
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @kphm,@customer_period
    while @@fetch_status = 0
    begin
		--先冲销月底的未开票凭证，华宏屯里11月开票冲销：09.28-09.30未开票
		if CHARINDEX('-',@customer_period)>0
		begin
			select Top 1 @Customer=customer from @tb_goods where kphm=@kphm
			exec huayao_WriteOffNotinvoiced_endMonth @currentYear,@currentPeriod,@Customer,@customer_period
		end

		if @customer_period=''
		begin
			set @customer_period=cast(month(@lastMonthDate) as varchar(2))+'月'
			select Top 1 @Customer=customer from @tb_goods where kphm=@kphm
		end
		else
		begin
			select Top 1 @Customer=customer,@customer_period=right(customer_period,11) from @tb_goods where isnull(customer_period,'')<>'' and kphm=@kphm
		end

		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec huayao_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=79294
		if @idDocDTO>0
		begin
			select Top 1 @options=options from @tb_goods where kphm=@kphm
			set @sequencenumber=1
			set @code='0000'

			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where kphm=@kphm 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				--获取要冲红的之前凭证
				select @doccode=code,@voucherdate=voucherdate from UFTData235382_400002.dbo.GL_Doc where id=@voucher_id
				DECLARE Entry_Cursor CURSOR FOR select code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitycr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@voucher_id
				order by idDocDTO,code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转1-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code in(select code from UFTData235382_400002.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear

					insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)

					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					set @sequencenumber=@sequencenumber+1
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm)
			select '0',id,xs_sn,customer,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm 
			from huayao_invoiced b where kphm=@kphm and ISNULL(options,'')='' and id not in(select id from @tb_goods where kphm=@kphm)
			and not exists(select 1 from @tb_goods where id=b.id)

			--科目表
			select @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='1122001' and accountingyear=@currentYear --应收账款-1
			
			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'开票第一行',1,2,null,2,null,null,null,@sequencenumber,dbo.GetAuxiliaryItems(@Customer,'开票'),@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from @tb_goods where kphm=@kphm
			group by goodsname,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where name=@goodsname and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='开票'+@customer_period+@Customer+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+' '+@options+' '+@kphm
				set @amountcr_total=@amountcr_total+@moneyNotax  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
				
				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@moneyNotax,null,@moneyNotax,@amount,@price/1.03,@sequencenumber,dbo.GetAuxiliaryItems(@Customer,'开票'),@idaccount,4,@idDocDTO,1)

				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			set @head_summary='开票'+@customer_period+@Customer
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_goods 
			where kphm=@kphm 
			group by goodsname order by goodsname
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+' '+@options+' '+@kphm --替换第一个'+'字符
			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='2221020' and accountingyear=@currentYear --应交税费-简易计税
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			
			insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--print @foot_summary
			--更新开票第一行摘要
			update UFTData235382_400002.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='开票第一行'

			--磅差
			set @money=0
			set @amount=0
			if exists(select 1 from huayao_invoiced where abs(amount_pc)>0 and kphm=@kphm)
			begin
				set @head_summary=@customer_period+@Customer+'磅差'
				--科目表-借方金额
				select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where code='6601012' and accountingyear=@currentYear --销售费用-运输途中合理损耗
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,'磅差第一行',1,null,null,null,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

				--明细
				DECLARE Entry_Cursor CURSOR FOR select goodsname,sum(amount_pc),sum(money_pc)
				from huayao_invoiced where abs(amount_pc)>0 and kphm=@kphm
				group by goodsname,price order by goodsname
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount,@money
				while @@fetch_status = 0
				begin
					--科目表
					select Top 1 @idaccount=id FROM UFTData235382_400002.[dbo].[AA_Account] where left(code,4)='1405' and name=@goodsname and accountingyear=@currentYear  --库存商品-水洗砂

					set @head_summary=@head_summary+'+'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
					set @row_summary=@customer_period+@Customer+'磅差'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'
					set @price=@money/@amount
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
					insert into UFTData235382_400002.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount,@money
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'')
				--print @head_summary
				--更新合理损耗第一行摘要
				update UFTData235382_400002.dbo.GL_Entry set summary=@head_summary where idDocDTO=@idDocDTO and summary='磅差第一行'
			end

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData235382_400002.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData235382_400002.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec huayao_InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update huayao_invoiced set writeoffState=1 where writeoffState=0 and xs_sn in(select xs_sn from @tb_goods where kphm=@kphm)
			update huayao_fh set writeoffState=1 from huayao_fh a inner join huayao_invoiced b on b.xs_sn=a.xs_sn
			where a.writeoffState<1 and a.xs_sn in(select xs_sn from @tb_goods where kphm=@kphm)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @kphm,@customer_period
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[luchang_AddVoucherMaster]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	增加凭证主表，返回id
-- =============================================
CREATE PROCEDURE [dbo].[luchang_AddVoucherMaster] 
(
	@customer nvarchar(100),
	@summoney numeric(12,2),
	@currentYear int,
	@currentPeriod int,
	@invoiceType nvarchar(50),
	@idDocDTO int output
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @strDocOrderNum nvarchar(50),@strTemp nvarchar(200),@sql NVARCHAR(max)
	DECLARE @idPeriod int,@voucherdate varchar(10)

	--获取凭证唯一标示号
	exec luchang_GetDocOrderNum @currentYear,@currentPeriod,@strDocOrderNum output

	select @idPeriod=id FROM UFTData131589_400003.dbo.SM_Period where currentyear=@currentYear and currentperiod=@currentPeriod
	
	select @voucherdate=cast(@currentYear as varchar(10))+'-'+cast(@currentPeriod as varchar(10))+'-'+cast(day(getdate()) as varchar(10))--当天
	if Convert(DateTime,Convert(varchar(10),getdate(),120))>@voucherdate	
		SELECT  @voucherdate=convert(varchar(10),dateadd(month, datediff(month, -1, @voucherdate), -1),120) --当月最后一天
		
	select @sql=N'
		insert UFTData131589_400003.dbo.GL_Doc(code, [name], accuorigamountdr, accuorigamountcr, accuamountdr, accuamountcr, iscashieraudit
		,ispost, iserror, isinvalidate, iscashflowed, isquantitydoc, isforeigncurrencydoc 
		,accountingperiod, accountingyear, maker, iscarriedforwardout, iscarriedforwardin, ismodifiedcode
		,isCashierDoc, DocOrderNum, PrintCount, isCashflowByHand, iddoctype, cashflowedstate, docbusinesstype
		,invalidateState, makeErrorState, voucherstate, makerid, idperiod, voucherdate, madedate, createdtime)
		values('''+right(@strDocOrderNum,6)+''','''','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+',0,0,0,0,0,1
		,0,'+cast(@currentPeriod as varchar(10))+','+cast(@currentYear as varchar(10))+',''梁美处'',0,0,0
		,0,'''+@strDocOrderNum+''',0,0,1,655,625,682,679,181,38,'+cast(@idPeriod as varchar(30))+','''+@voucherdate+''',Convert(varchar(10),getdate(),120),getdate()) 
		select @idDocDTO=@@identity'
	
	--print @sql
	EXEC sp_executesql @sql,N'@idDocDTO int out',@idDocDTO OUT
END


GO
/****** Object:  StoredProcedure [dbo].[luchang_GetDocOrderNum]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-01
-- Description:	获取凭证唯一标示号
-- =============================================
CREATE PROCEDURE [dbo].[luchang_GetDocOrderNum]
(
	@currentYear int,
	@currentPeriod int,
	@strDocOrderNum nvarchar(50) output
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--凭证类别ID=1，AA_DocType.sequencenumber=4
	DECLARE @strNo nvarchar(50),@sql NVARCHAR(4000)
	set @strNo=cast(@currentYear as nvarchar(20))+isnull(replicate('0',2-len(@currentPeriod)),'')+cast(@currentPeriod as varchar(20))+'5000'
	select @sql=N'if exists(select 1 from UFTData131589_400003.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%'')
	begin
		select @strDocOrderNum=(right(max(DocOrderNum),6)+1) from UFTData131589_400003.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%''
		select @strDocOrderNum='''+@strNo+'''+replicate(''0'',18-len(@strDocOrderNum))+@strDocOrderNum
	end
	else
	begin
		set @strDocOrderNum='''+@strNo+'''+replicate(''0'',16)+''01''
	end'

	--print @sql
	EXEC sp_executesql @sql,N'@strDocOrderNum varchar(50) out',@strDocOrderNum OUT
END
GO
/****** Object:  StoredProcedure [dbo].[luchang_InsertVoucherJournal]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-02
-- Description:	从分录表获取数据，插入凭证明细表
-- =============================================
CREATE PROCEDURE [dbo].[luchang_InsertVoucherJournal] 
(
@idDocDTO int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @code nvarchar(30),@summary nvarchar(max),@origamountdr decimal(28,14),@origamountcr decimal(28,14),@amountdr decimal(28,14),@amountcr decimal(28,14)
		,@quantitycr decimal(28,14),@price decimal(28,14),@sequencenumber int,@AuxiliaryItems nvarchar(500),@idaccount int,@id int,@idUnit int
	declare @docno varchar(30),@currentYear int,@currentPeriod int,@idauxAccCustomer int,@idaccountingperiod int,@auxiliaryinfoid int,@direction int,@voucherdate DateTime

	select @docno=code,@currentYear=accountingyear,@currentPeriod=accountingperiod,@voucherdate=voucherdate from UFTData131589_400003.dbo.GL_Doc where id=@idDocDTO
	select @idaccountingperiod=id FROM UFTData131589_400003.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod --会计期间ID
	
	--删除所有
	delete from UFTData131589_400003.dbo.GL_AuxiliaryInfo where DocId=@idDocDTO
	delete from UFTData131589_400003.dbo.GL_Journal where DocId=@idDocDTO
	
	DECLARE Journal_Cursor CURSOR FOR select id,code,summary,origamountdr,origamountcr,amountdr,amountcr,quantitycr,price,sequencenumber,AuxiliaryItems,idaccount,idUnit 
	from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@idDocDTO order by code
	OPEN Journal_Cursor
    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    while @@fetch_status = 0
    begin	
		--插入辅助信息DTO
		set @idauxAccCustomer=null
		set @auxiliaryinfoid=null
		select @idUnit=idUnit from UFTData131589_400003.dbo.AA_Account where id=@idaccount
		if @AuxiliaryItems is not null or isnull(@idUnit,0)>0
		begin
			select @idauxAccCustomer=id from UFTData131589_400003.dbo.AA_Partner where [name]=@AuxiliaryItems
			insert into UFTData131589_400003.[dbo].[GL_AuxiliaryInfo](exchangerate,idauxAccCustomer,DocId,idEntryDTO)
			values(1.0,@idauxAccCustomer,@idDocDTO,@id)
			select @auxiliaryinfoid=@@identity
		end

		--没有往来单位，反写分录表
		if @idauxAccCustomer is null
			update UFTData131589_400003.dbo.GL_Entry set AuxiliaryItems=null where id=@id and AuxiliaryItems is not null
		
		set @direction=652  --借方
		if @amountcr is not null
			set @direction=653  --贷方
		if not exists(select 1 from UFTData131589_400003.dbo.[GL_Journal] where docid=@idDocDTO and entryid=@id)
		begin
			insert into UFTData131589_400003.[dbo].[GL_Journal](docno, rowno, summary, maker, exchangerate, price
			,iscarriedforwardout, iscarriedforwardin, sequencenumber, ispost, [year], currentperiod, quantityCr
			,amountDr, amountCr, origAmountDr, OrigAmountCr, isPeriodBegin,DocDrCrType, idaccount, idcurrency, idDocType
			,idauxAccCustomer,direction, makerId, docid, entryid, auxiliaryinfoid, idaccountingperiod, madedate, idUnit)
			values(@docno,@code,@summary,'梁美处',1,@price,0,0,@sequencenumber,0,@currentYear,@currentPeriod,@quantitycr,@amountdr,@amountcr,@origamountdr,@origamountcr
			,0,12,@idaccount,4,1,@idauxAccCustomer,@direction,38,@idDocDTO,@id,@auxiliaryinfoid,@idaccountingperiod,@voucherdate,@idUnit)

		end
	    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    end
    CLOSE Journal_Cursor
    DEALLOCATE Journal_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[luchang_Invoiced]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[luchang_Invoiced] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方=含税金额，贷方金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@id nvarchar(50),@customer_period nvarchar(50),@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int
	DECLARE @doccode nvarchar(30),@voucherdate datetime
	
	set @amountcr_total=0  --贷方金额
	set @amountdr_total=0  --借方金额
	set @moneyTax_total=0  --销项税额
	DECLARE tbgoods_Cursor CURSOR FOR select customer,customer_period,sum([money]),sum(money_notax),sum(money_tax) 
	from huayao_invoiced where writeoffState=0 and money>0 and options<>'冲红' and customer_type='企业' and yfjsfs like'%-2' 
	and year(fhrq)=year(kprq) and month(fhrq)=month(kprq) and year(kprq)=@currentYear and month(kprq)=@currentPeriod  
	and dw='南宁市武鸣区路畅运输有限公司' 
	group by customer,customer_period order by customer
	OPEN tbgoods_Cursor
	FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@customer_period,@amountdr_total,@amountcr_total,@moneyTax_total
	while @@fetch_status = 0
	begin
		if @customer_period<>''
			set @customer_period=right(@customer_period,11)
		else
			set @customer_period=cast(@currentPeriod as varchar(2))+'月'

		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec luchang_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'开票',@idDocDTO output
		--set @idDocDTO=1777
		if @idDocDTO>0
		begin
			--delete from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'

			select @kphm=stuff((select distinct ','+kphm from huayao_invoiced 
			where writeoffState=0 and money>0 and options<>'冲红' and customer_type='企业' and yfjsfs like'%-2'
			and year(fhrq)=year(kprq) and month(fhrq)=month(kprq) and year(kprq)=@currentYear and month(kprq)=@currentPeriod  
			and customer=@Customer
			and dw='南宁市武鸣区路畅运输有限公司' 
			for xml path('')),1,1,'')

			set @head_summary=@customer_period+'运费收入-'+@Customer+'  普票:'+@kphm
			--科目表
			select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and name=@Customer and code like'1122001%' --应收账款-蒙陇山
			
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'运费第一行',1,2,null,2,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and code='6001001' --主营业务收入-运输收入
				
			set @row_summary=@head_summary
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
			price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@moneyNotax,null,@moneyNotax,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

			--更新第一行
			update UFTData131589_400003.dbo.GL_Entry set origamountdr=@amountdr_total,amountdr=@amountdr_total,summary=@head_summary 
			where idDocDTO=@idDocDTO and summary='运费第一行'

			set @foot_summary=@head_summary
			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and code='2221001001'  --应交税费-应交增值税-销项税
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountcr_total,null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData131589_400003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec luchang_InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update huayao_invoiced set writeoffState=1 
			where writeoffState=0 and money>0 and options<>'冲红' and customer_type='企业' and yfjsfs like'%-2' 
			and year(fhrq)=year(kprq) and month(fhrq)=month(kprq) and year(kprq)=@currentYear and month(kprq)=@currentPeriod  
			and customer=@Customer
			and dw='南宁市武鸣区路畅运输有限公司'
		end
		FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@customer_period,@amountdr_total,@amountcr_total,@moneyTax_total
	end
	CLOSE tbgoods_Cursor
	DEALLOCATE tbgoods_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[luchang_Invoiced_zj]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	开票凭证-中建
-- =============================================
CREATE PROCEDURE [dbo].[luchang_Invoiced_zj] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方=含税金额，贷方金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@id nvarchar(50),@customer_period nvarchar(50),@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@lastMonthDate DateTime
	
	select @lastMonthDate=DateAdd(day,-1,Convert(DateTime,(cast(@currentYear as varchar(4))+'-'+cast(@currentPeriod as varchar(4))+'-1')))

	set @amountcr_total=0  --贷方金额
	set @amountdr_total=0  --借方金额
	set @moneyTax_total=0  --销项税额
	DECLARE tbgoods_Cursor CURSOR FOR select kpdw,customer_period,sum([money]),sum(money_notax),sum(money_tax) 
	from huayao_invoiced where writeoffState=0 and money>0 and options<>'冲红' and convert(int,(DATENAME(year,kprq)+DATENAME(month,kprq)))>convert(int,(DATENAME(year,fhrq)+DATENAME(month,fhrq)))
	and year(kprq)=@currentYear and month(kprq)=@currentPeriod and customer_type='企业' and yfjsfs='陇蒙山-2' and customer like'%中建西部%'
	and dw='南宁市武鸣区路畅运输有限公司' 
	group by kpdw,customer_period order by kpdw
	OPEN tbgoods_Cursor
	FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@customer_period,@amountdr_total,@amountcr_total,@moneyTax_total
	while @@fetch_status = 0
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec luchang_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=1618
		if @idDocDTO>0
		begin
			set @customer_period=right(@customer_period,11)
			set @sequencenumber=1
			set @code='0000'

			select @kphm=stuff((select distinct ','+kphm from huayao_invoiced 
			where money>0 and options<>'冲红' and convert(int,(DATENAME(year,kprq)+DATENAME(month,kprq)))>convert(int,(DATENAME(year,fhrq)+DATENAME(month,fhrq)))
			and year(kprq)=@currentYear and month(kprq)=@currentPeriod and customer_type='企业' and yfjsfs='陇蒙山-2' and kpdw=@Customer
			and dw='南宁市武鸣区路畅运输有限公司'
			for xml path('')),1,1,'')

			set @head_summary=@customer_period+'运费收入-'+@Customer+'  专票:'+@kphm
			--科目表
			select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and name=@Customer and code like'1122001%' --应收账款-蒙陇山
			
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'运费第一行',1,2,null,2,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and code='6001001' --主营业务收入-运输收入
				
			set @row_summary=@head_summary
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
			price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@amountcr_total,null,@amountcr_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

			--更新第一行
			update UFTData131589_400003.dbo.GL_Entry set origamountdr=@amountdr_total,amountdr=@amountdr_total,summary=@head_summary 
			where idDocDTO=@idDocDTO and summary='运费第一行'

			set @foot_summary=@head_summary
			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and code='2221001001'  --应交税费-应交增值税-销项税
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountcr_total,null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData131589_400003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec luchang_InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update huayao_invoiced set writeoffState=1 
			where writeoffState=0 and money>0 and options<>'冲红' and convert(int,(DATENAME(year,kprq)+DATENAME(month,kprq)))>convert(int,(DATENAME(year,fhrq)+DATENAME(month,fhrq)))
			and year(kprq)=@currentYear and month(kprq)=@currentPeriod and customer_type='企业' and yfjsfs='陇蒙山-2' and kpdw=@Customer
			and dw='南宁市武鸣区路畅运输有限公司'
		end
		FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@customer_period,@amountdr_total,@amountcr_total,@moneyTax_total
	end
	CLOSE tbgoods_Cursor
	DEALLOCATE tbgoods_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[luchang_Notinvoiced]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	未开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[luchang_Notinvoiced] 
(
	@customer nvarchar(100),
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方=含税金额，贷方金额=含税金额/1.03
	DECLARE @money numeric(18,2),@rowmoney numeric(18,2),@row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@idaccount int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	
	set @money=0
	select @money=sum(amount_hd*ys_qyyfdj) from huayao_fh where year(hdrq)=@currentYear and month(hdrq)=@currentPeriod and customer=@customer
	if @money>0
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec luchang_AddVoucherMaster @customer,0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=79294
		if @idDocDTO>0
		begin
			set @sequencenumber=1
			set @code='0000'
			set @head_summary='暂估'+cast(@currentPeriod as varchar(10))+'月运费收入-'+@customer
			--科目表
			select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and name=@Customer and code like'1122001%' --应收账款-蒙陇山
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@head_summary,1,@money,null,@money,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and code='6001001' --主营业务收入-运输收入

			
			set @amountdr_total=@money  --借方金额
			set @rowmoney=@money/1.09  --减去税额9%
			set @amountcr_total=@rowmoney  --贷方金额主营业务收入
			set @row_summary=@head_summary

			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

			set @foot_summary=@head_summary
			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and code='2221001001'  --应交税费-应交增值税-销项税
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountcr_total,null,round((@amountdr_total-@amountcr_total),2),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData131589_400003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec luchang_InsertVoucherJournal @idDocDTO
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[luchang_Notinvoiced_period]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		唐毓师
-- Create date: 2023-11-1
-- Description:	未开票凭证-对账期间
-- =============================================
CREATE PROCEDURE [dbo].[luchang_Notinvoiced_period] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Customer nvarchar(100),@row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2),@money numeric(12,2),@summoney numeric(12,2)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2)

	CREATE TABLE #tb_customer(xs_sn varchar(50),customer varchar(100),fhrq DateTime,goodsname varchar(50),price numeric(18,2),amount numeric(18,4),money numeric(18,2)
		,startTime DateTime,endTime DateTime)
	DECLARE @bigCustomer nvarchar(100),@startTime DateTime,@endTime DateTime,@sDate varchar(10),@eDate varchar(10),@period_summary nvarchar(50)
	
	DECLARE period_Cursor CURSOR FOR select customer,startTime,endTime from luchang_period 
	where isnull(customer,'')<>''
	order by id
	OPEN period_Cursor
    FETCH NEXT FROM period_Cursor INTO @bigCustomer,@startTime,@endTime
    while @@fetch_status = 0
    begin
		insert into #tb_customer(xs_sn,customer,fhrq,goodsname,price,amount,money,startTime,endTime)
		select xs_sn,dbo.GetAuxiliaryItems(customer,'开票'),zcsj,goodsname,ys_qyyfdj,amount_hd,money,@startTime,@endTime from v_huayao_fh 
		where hdrq>=@startTime and hdrq<@endTime and customer like'%'+@bigCustomer+'%'
		order by customer,zcsj
	    FETCH NEXT FROM period_Cursor INTO @bigCustomer,@startTime,@endTime
    end
    CLOSE period_Cursor
    DEALLOCATE period_Cursor

	DECLARE customer_Cursor CURSOR FOR select customer,startTime,endTime,sum(amount*price) from #tb_customer 
	group by customer,startTime,endTime order by customer,startTime
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@startTime,@endTime,@money
    while @@fetch_status = 0
    begin
		select @period_summary=replace(right(Convert(varchar(10),@startTime,120),5),'-','.')+'-'+replace(right(Convert(varchar(10),@endTime,120),5),'-','.')
		if @money>0
		begin
			--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
			exec luchang_AddVoucherMaster @customer,@money,@currentYear,@currentPeriod,'未开票',@idDocDTO output
			--set @idDocDTO=79294
			if @idDocDTO>0
			begin
				set @sequencenumber=1
				set @code='0000'
				set @head_summary='暂估'+cast(@currentPeriod as varchar(10))+'月运费收入-'+@customer+'，'+@period_summary+'日'
				--科目表
				select Top 1 @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and name=@Customer and code like'1122001%' --应收账款-蒙陇山
				insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@head_summary,1,@money,null,@money,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
				select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and code='6001001' --主营业务收入-运输收入

			
				set @amountdr_total=@money  --借方金额
				set @rowmoney=@money/1.09  --减去税额9%
				set @amountcr_total=@rowmoney  --贷方金额主营业务收入
				set @row_summary=@head_summary

				insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

				set @foot_summary=@head_summary
				--尾行汇总
				select Top 1 @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and code='2221001001'  --应交税费-应交增值税-销项税
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
			
				insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,null,@amountcr_total,null,round((@amountdr_total-@amountcr_total),2),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

				--更新主表金额
				select @summoney=sum(isnull(origamountdr,0)) from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@idDocDTO
				update UFTData131589_400003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
				,accuamountcr=@summoney where id=@idDocDTO

				--导入明细表
				exec luchang_InsertVoucherJournal @idDocDTO

				--更新发货
				update huayao_fh set writeoffState=-1 where writeoffState=0 and xs_sn in(select xs_sn from #tb_customer where customer=@Customer and startTime=@startTime and endTime=@endTime)
			end
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@startTime,@endTime,@money
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

	drop table #tb_customer
END
GO
/****** Object:  StoredProcedure [dbo].[luchang_WriteOffNotinvoiced]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[luchang_WriteOffNotinvoiced] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方=含税金额，贷方金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@id nvarchar(50),@customer_period nvarchar(50),@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@lastMonthDate DateTime
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),xs_sn varchar(50),fhrq DateTime,customer varchar(100),customer_period varchar(50),goodsname varchar(50)
		,price numeric(18,2),amount numeric(18,4),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))

	select @lastMonthDate=DateAdd(day,-1,Convert(DateTime,(cast(@currentYear as varchar(4))+'-'+cast(@currentPeriod as varchar(4))+'-1')))

	DECLARE customer_Cursor CURSOR FOR select id,customer,customer_period,xs_sn,fhrq,goodsname,price,amount,[money],kphm,money_notax,money_tax,options 
	from huayao_invoiced where writeoffState=0 and money>0 and options<>'冲红' and convert(int,(DATENAME(year,kprq)+DATENAME(month,kprq)))>convert(int,(DATENAME(year,fhrq)+DATENAME(month,fhrq)))
	and year(kprq)=@currentYear and month(kprq)=@currentPeriod and customer_type='企业' and yfjsfs like'%-2'
	and dw='南宁市武鸣区路畅运输有限公司'
	--and customer_period=''
	--and customer='广西华宏甘圩混凝土有限公司'
	order by customer,kphm,fhrq,goodsname
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@customer_period,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@moneyNotax,@moneyTax,@options
    while @@fetch_status = 0
    begin
		select @row_summary=right(@customer_period,11)
		
		set @voucher_id=0
		select Top 1 @voucher_id=b.id from UFTData131589_400003.dbo.GL_Doc b inner join UFTData131589_400003.dbo.GL_Entry a on a.idDocDTO=b.id
		where accountingyear=year(@lastMonthDate) and accountingperiod=month(@lastMonthDate) and iddoctype=1 
		and a.summary like '暂估'+cast(month(@lastMonthDate) as varchar(4))+'月运费收入%'
		--and a.summary like '暂估'+cast(month(@lastMonthDate) as varchar(4))+'月运费收入%08.01-08.31%'
		and idaccount in (select id from UFTData131589_400003.dbo.AA_Account where accountingyear=year(@lastMonthDate) and name like @Customer+'%' and code like'1122001%') --应收账款-陇蒙山
		order by b.voucherdate
		if @voucher_id>0
		begin
			if not exists(select 1 from @tb_goods where id=@id)
			begin
				insert into @tb_goods(voucher_id,id,xs_sn,customer,customer_period,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm,options)
				values(@voucher_id,@id,@xs_sn,@Customer,@customer_period,@fhrq,@goodsname,@price,@amount,@money,@moneyNotax,@moneyTax,@kphm,@options)
			end
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@customer_period,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@moneyNotax,@moneyTax,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
	--select * from @tb_goods
    
    DECLARE tbgoods_Cursor CURSOR FOR select voucher_id,customer_period from @tb_goods group by voucher_id,customer_period
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @voucher_id,@customer_period
    while @@fetch_status = 0
    begin
		select Top 1 @Customer=customer,@options=options from @tb_goods where voucher_id=@voucher_id
		
		--先冲销月底的未开票凭证，华宏屯里11月开票冲销：09.28-09.30未开票
		if CHARINDEX('-',@customer_period)>0
		begin
			exec luchang_WriteOffNotinvoiced_endMonth @currentYear,@currentPeriod,@Customer,@customer_period
		end

		if @customer_period=''
		begin
			set @customer_period=cast(month(@lastMonthDate) as varchar(2))+'月'
		end
		else
		begin
			set @customer_period=right(@customer_period,11)
		end

		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec luchang_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=1615
		if @idDocDTO>0
		begin
			set @sequencenumber=1
			set @code='0000'

			--获取要冲红的之前凭证
			select @doccode=code,@voucherdate=voucherdate from UFTData131589_400003.dbo.GL_Doc where id=@voucher_id
			DECLARE Entry_Cursor CURSOR FOR select code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitycr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
			from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@voucher_id
			order by idDocDTO,code
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
			while @@fetch_status = 0
			begin
				set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日记-'+@doccode+'号凭证]'+@Entrysummary
				--科目
				select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where code in(select code from UFTData131589_400003.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear

				insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)

				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm)
			select '0',id,xs_sn,customer,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm 
			from huayao_invoiced b where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
			and dw='南宁市武鸣区路畅运输有限公司' and not exists(select 1 from @tb_goods where id=b.id)

			select @kphm=stuff((select distinct ','+kphm from @tb_goods where voucher_id=@voucher_id for xml path('')),1,1,'')
			set @head_summary=@customer_period+'运费收入-'+@Customer+'  '+@options+':'+@kphm
			--科目表
			select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and name=@Customer and code like'1122001%' --应收账款-蒙陇山
			
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'运费第一行',1,2,null,2,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and code='6001001' --主营业务收入-运输收入

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			select @amountdr_total=sum([money]),@amountcr_total=sum(money_notax),@moneyTax_total=sum(money_tax) from @tb_goods where voucher_id=@voucher_id
			set @row_summary=@head_summary
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@amountcr_total,null,@amountcr_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

			--更新第一行
			update UFTData131589_400003.dbo.GL_Entry set origamountdr=@amountdr_total,amountdr=@amountdr_total,summary=@head_summary 
			where idDocDTO=@idDocDTO and summary='运费第一行'

			set @foot_summary=@head_summary
			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and code='2221001001'  --应交税费-应交增值税-销项税
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountcr_total,null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData131589_400003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec luchang_InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update huayao_invoiced set writeoffState=1 where writeoffState=0 and xs_sn in(select xs_sn from @tb_goods where voucher_id=@voucher_id)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @voucher_id,@customer_period
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[luchang_WriteOffNotinvoiced_endMonth]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销月底09.28-09.30未开票
-- =============================================
CREATE PROCEDURE [dbo].[luchang_WriteOffNotinvoiced_endMonth] 
(
	@currentYear int,
	@currentPeriod int,
	@customer nvarchar(100),
	@customer_period nvarchar(50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方=含税金额，贷方金额=含税金额/1.03
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@sequencenumber int,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int
	DECLARE @summoney numeric(18,2),@row_summary nvarchar(max),@idaccount int,@idDocDTO int,@voucher_id int,@doccode nvarchar(30),@voucherdate datetime
	
	declare @summary_keyword varchar(50),@startDate varchar(10),@endDate varchar(10)
	set @startDate=replace(left(@customer_period,11),'.','-')
	select @endDate=convert(varchar(10),dateadd(month, datediff(month, -1, @startDate), -1),120) --当月最后一天

	select @summary_keyword=replace(right(@startDate,5),'-','.') + '-' + replace(right(@endDate,5),'-','.')
	
	set @voucher_id=0
	select Top 1 @voucher_id=b.id from UFTData131589_400003.dbo.GL_Doc b inner join UFTData131589_400003.dbo.GL_Entry a on a.idDocDTO=b.id
	where accountingyear=year(@endDate) and accountingperiod=month(@endDate) and iddoctype=1 
	and a.summary like '暂估%运费收入%'+@summary_keyword+'%' 
	and idaccount in (select id from UFTData131589_400003.dbo.AA_Account where accountingyear=year(@endDate) and name like @Customer+'%' and code like'1122001%') --应收账款-陇蒙山
	order by b.voucherdate
	if @voucher_id>0
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec luchang_AddVoucherMaster @customer,0,@currentYear,@currentPeriod,'冲销月底',@idDocDTO output
		--set @idDocDTO=120
		if @idDocDTO>0
		begin
			--获取要冲红的之前凭证
			select @doccode=code,@voucherdate=voucherdate from UFTData131589_400003.dbo.GL_Doc where id=@voucher_id
			DECLARE Entry_Cursor CURSOR FOR select code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitycr,price,sequencenumber,AuxiliaryItems,idaccount,idcurrency,idUnit
			from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@voucher_id
			order by idDocDTO,sequencenumber
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
			while @@fetch_status = 0
			begin
				set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日记-'+@doccode+'号凭证]'+@Entrysummary
				--科目
				select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where code in(select code from UFTData131589_400003.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear

				insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@Entrycode,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData131589_400003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec luchang_InsertVoucherJournal @idDocDTO
		end
	end

END
GO
/****** Object:  StoredProcedure [dbo].[luchang_WriteOffNotinvoiced_zj]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-中建西部建设
-- =============================================
CREATE PROCEDURE [dbo].[luchang_WriteOffNotinvoiced_zj]
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
    --生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方=含税金额，贷方金额=含税金额/1.03
	DECLARE @Customer nvarchar(100),@id nvarchar(50),@customer_period nvarchar(50),@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@lastMonthDate DateTime
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),xs_sn varchar(50),fhrq DateTime,customer varchar(100),customer_period varchar(50),goodsname varchar(50)
		,price numeric(18,2),amount numeric(18,4),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options nvarchar(50))

	select @lastMonthDate=DateAdd(day,-1,Convert(DateTime,(cast(@currentYear as varchar(4))+'-'+cast(@currentPeriod as varchar(4))+'-1')))

	DECLARE customer_Cursor CURSOR FOR select id,kpdw,customer_period,xs_sn,fhrq,goodsname,price,amount,[money],kphm,money_notax,money_tax,options 
	from huayao_invoiced where writeoffState=0 and money>0 and options<>'冲红' and convert(int,(DATENAME(year,kprq)+DATENAME(month,kprq)))>convert(int,(DATENAME(year,fhrq)+DATENAME(month,fhrq)))
	and year(kprq)=@currentYear and month(kprq)=@currentPeriod and customer_type='企业' and yfjsfs='陇蒙山-2' and customer like'%中建西部%'
	and dw='南宁市武鸣区路畅运输有限公司' 
	--and kpdw='广西中建西部建设有限公司'
	order by kpdw,kphm,fhrq,goodsname
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@customer_period,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@moneyNotax,@moneyTax,@options
    while @@fetch_status = 0
    begin
		select @row_summary='暂估'+cast(month(@lastMonthDate) as varchar(2))+'月运费收入-'+@Customer
		if charindex('-',@customer_period)>0
		begin
			select @row_summary='暂估'+cast(month(@lastMonthDate) as varchar(2))+'月运费收入-'+@Customer+'%'+right(@customer_period,11)+'%'
			--select @row_summary='暂估'+cast(month(@lastMonthDate) as varchar(2))+'月运费收入-'+@Customer+'%04.01-04.30%'
		end
		
		set @voucher_id=0
		select Top 1 @voucher_id=b.id from UFTData131589_400003.dbo.GL_Doc b inner join UFTData131589_400003.dbo.GL_Entry a on a.idDocDTO=b.id
		where accountingyear=year(@lastMonthDate) and accountingperiod=month(@lastMonthDate) and iddoctype=1 
		and a.summary like @row_summary and idaccount in (select id from UFTData131589_400003.dbo.AA_Account where accountingyear=year(@lastMonthDate) and name like +@Customer+'%' and code like'1122001%') --应收账款-陇蒙山
		order by b.voucherdate
		if @voucher_id>0
		begin
			if not exists(select 1 from @tb_goods where id=@id)
			begin
				insert into @tb_goods(voucher_id,id,xs_sn,customer,customer_period,fhrq,goodsname,price,amount,[money],money_notax,money_tax,kphm,options)
				values(@voucher_id,@id,@xs_sn,@Customer,@customer_period,@fhrq,@goodsname,@price,@amount,@money,@moneyNotax,@moneyTax,@kphm,@options)
			end
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@customer_period,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@moneyNotax,@moneyTax,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
	
	--有对应冲销凭证
    DECLARE tbgoods_Cursor CURSOR FOR select customer from @tb_goods 
    group by customer order by customer
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @Customer
    while @@fetch_status = 0
    begin
		select Top 1 @customer_period=customer_period,@options=options from @tb_goods where customer=@Customer
		----先冲销月底的未开票凭证，华宏屯里11月开票冲销：09.28-09.30未开票
		--if CHARINDEX('-',@customer_period)>0
		--begin
		--	exec luchang_WriteOffNotinvoiced_endMonth @currentYear,@currentPeriod,@Customer,@customer_period
		--end

		select @customer_period=right(@customer_period,11)
		
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec luchang_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=2304
		if @idDocDTO>0
		begin
			--delete from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'

			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where customer=@Customer 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				--获取要冲红的之前凭证
				select @doccode=code,@voucherdate=voucherdate from UFTData131589_400003.dbo.GL_Doc where id=@voucher_id
				DECLARE Entry_Cursor CURSOR FOR select code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitycr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@voucher_id
				order by idDocDTO,sequencenumber
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日记-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where code in(select code from UFTData131589_400003.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear

					insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)

					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					set @sequencenumber=@sequencenumber+1
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor

			select @kphm=stuff((select distinct ','+kphm from @tb_goods where customer=@Customer for xml path('')),1,1,'')

			set @head_summary=@customer_period+'运费收入-'+@Customer+'  '+@options+':'+@kphm
			--科目表
			select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and name=@Customer and code like'1122001%' --应收账款-蒙陇山
			
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'运费第一行',1,2,null,2,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			select @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and code='6001001' --主营业务收入-运输收入

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			select @amountdr_total=sum([money]),@amountcr_total=sum(money_notax),@moneyTax_total=sum(money_tax) from @tb_goods where customer=@Customer
			set @row_summary=@head_summary
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@amountcr_total,null,@amountcr_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

			--更新第一行
			update UFTData131589_400003.dbo.GL_Entry set origamountdr=@amountdr_total,amountdr=@amountdr_total,summary=@head_summary 
			where idDocDTO=@idDocDTO and summary='运费第一行'

			set @foot_summary=@head_summary
			--print @foot_summary
			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData131589_400003.[dbo].[AA_Account] where accountingyear=@currentYear and code='2221001001'  --应交税费-应交增值税-销项税
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			set @sequencenumber=@sequencenumber+1
			
			insert into UFTData131589_400003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountcr_total,null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData131589_400003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData131589_400003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec luchang_InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update huayao_invoiced set writeoffState=1 where writeoffState=0 and xs_sn in(select xs_sn from @tb_goods where customer=@Customer)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @Customer
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[sjs_AddVoucherMaster]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	增加凭证主表，返回id
-- =============================================
CREATE PROCEDURE [dbo].[sjs_AddVoucherMaster] 
(
	@customer nvarchar(100),
	@summoney numeric(12,2),
	@currentYear int,
	@currentPeriod int,
	@invoiceType nvarchar(50),
	@idDocDTO int output
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @strDocOrderNum nvarchar(50),@strTemp nvarchar(200),@sql NVARCHAR(max)
	DECLARE @idPeriod int,@voucherdate varchar(10)

	--获取凭证唯一标示号
	exec huayao_GetDocOrderNum @currentYear,@currentPeriod,@strDocOrderNum output

	select @idPeriod=id FROM UFTData558514_400016.dbo.SM_Period where currentyear=@currentYear and currentperiod=@currentPeriod
	
	select @voucherdate=cast(@currentYear as varchar(10))+'-'+cast(@currentPeriod as varchar(10))+'-'+cast(day(getdate()) as varchar(10))--当天
	if Convert(DateTime,Convert(varchar(10),getdate(),120))>@voucherdate	
		SELECT  @voucherdate=convert(varchar(10),dateadd(month, datediff(month, -1, @voucherdate), -1),120) --当月最后一天
		
	select @sql=N'
		insert UFTData558514_400016.dbo.GL_Doc(code, [name], accuorigamountdr, accuorigamountcr, accuamountdr, accuamountcr, iscashieraudit
		,ispost, iserror, isinvalidate, iscashflowed, isquantitydoc, isforeigncurrencydoc 
		,accountingperiod, accountingyear, maker, iscarriedforwardout, iscarriedforwardin, ismodifiedcode
		,isCashierDoc, DocOrderNum, PrintCount, isCashflowByHand, iddoctype, cashflowedstate, docbusinesstype
		,invalidateState, makeErrorState, voucherstate, makerid, idperiod, voucherdate, madedate, createdtime)
		values('''+right(@strDocOrderNum,6)+''','''','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+',0,0,0,0,0,1
		,0,'+cast(@currentPeriod as varchar(10))+','+cast(@currentYear as varchar(10))+',''李静谊'',0,0,0
		,0,'''+@strDocOrderNum+''',0,0,6,655,621,682,679,181,35,'+cast(@idPeriod as varchar(30))+','''+@voucherdate+''',Convert(varchar(10),getdate(),120),getdate()) 
		select @idDocDTO=@@identity'
	
	--print @sql
	EXEC sp_executesql @sql,N'@idDocDTO int out',@idDocDTO OUT
END


GO
/****** Object:  StoredProcedure [dbo].[sjs_GetDocOrderNum]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-01
-- Description:	获取凭证唯一标示号
-- =============================================
CREATE PROCEDURE [dbo].[sjs_GetDocOrderNum]
(
	@currentYear int,
	@currentPeriod int,
	@strDocOrderNum nvarchar(50) output
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--凭证类别ID=5，AA_DocType.sequencenumber=4
	DECLARE @strNo nvarchar(50),@sql NVARCHAR(4000)
	set @strNo=cast(@currentYear as nvarchar(20))+isnull(replicate('0',2-len(@currentPeriod)),'')+cast(@currentPeriod as varchar(20))+'0005'
	select @sql=N'if exists(select 1 from UFTData558514_400016.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%'')
	begin
		select @strDocOrderNum=(right(max(DocOrderNum),6)+1) from UFTData558514_400016.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%''
		select @strDocOrderNum='''+@strNo+'''+replicate(''0'',18-len(@strDocOrderNum))+@strDocOrderNum
	end
	else
	begin
		set @strDocOrderNum='''+@strNo+'''+replicate(''0'',16)+''01''
	end'

	--print @sql
	EXEC sp_executesql @sql,N'@strDocOrderNum varchar(50) out',@strDocOrderNum OUT
END
GO
/****** Object:  StoredProcedure [dbo].[sjs_InsertVoucherJournal]    Script Date: 2025/3/26 16:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-02
-- Description:	从分录表获取数据，插入凭证明细表
-- =============================================
CREATE PROCEDURE [dbo].[sjs_InsertVoucherJournal] 
(
@idDocDTO int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @code nvarchar(30),@summary nvarchar(max),@origamountdr decimal(28,14),@origamountcr decimal(28,14),@amountdr decimal(28,14),@amountcr decimal(28,14)
		,@quantitycr decimal(28,14),@price decimal(28,14),@sequencenumber int,@AuxiliaryItems nvarchar(500),@idaccount int,@id int,@idUnit int
	declare @docno varchar(30),@currentYear int,@currentPeriod int,@idauxAccCustomer int,@idaccountingperiod int,@auxiliaryinfoid int,@direction int,@voucherdate DateTime

	select @docno=code,@currentYear=accountingyear,@currentPeriod=accountingperiod,@voucherdate=voucherdate from UFTData558514_400016.dbo.GL_Doc where id=@idDocDTO
	select @idaccountingperiod=id FROM UFTData558514_400016.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod --会计期间ID
	
	--删除所有
	delete from UFTData558514_400016.dbo.GL_AuxiliaryInfo where DocId=@idDocDTO
	delete from UFTData558514_400016.dbo.GL_Journal where DocId=@idDocDTO
	
	DECLARE Journal_Cursor CURSOR FOR select id,code,summary,origamountdr,origamountcr,amountdr,amountcr,quantitycr,price,sequencenumber,AuxiliaryItems,idaccount,idUnit 
	from UFTData558514_400016.dbo.GL_Entry where idDocDTO=@idDocDTO order by code
	OPEN Journal_Cursor
    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    while @@fetch_status = 0
    begin	
		--插入辅助信息DTO
		set @idauxAccCustomer=null
		set @auxiliaryinfoid=null
		select @idUnit=idUnit from UFTData558514_400016.dbo.AA_Account where id=@idaccount
		if @AuxiliaryItems is not null or isnull(@idUnit,0)>0
		begin
			select @idauxAccCustomer=id from UFTData558514_400016.dbo.AA_Partner where [name]=@AuxiliaryItems and partnerType in(211,228) --客户：211,客户/供应商：228
			insert into UFTData558514_400016.[dbo].[GL_AuxiliaryInfo](exchangerate,idauxAccCustomer,DocId,idEntryDTO)
			values(1.0,@idauxAccCustomer,@idDocDTO,@id)
			select @auxiliaryinfoid=@@identity
		end

		--没有往来单位，反写分录表
		if @idauxAccCustomer is null
			update UFTData558514_400016.dbo.GL_Entry set AuxiliaryItems=null where id=@id and AuxiliaryItems is not null
		
		set @direction=652  --借方
		if @amountcr is not null
			set @direction=653  --贷方
		if not exists(select 1 from UFTData558514_400016.dbo.[GL_Journal] where docid=@idDocDTO and entryid=@id)
		begin
			insert into UFTData558514_400016.[dbo].[GL_Journal](docno, rowno, summary, maker, exchangerate, price
			,iscarriedforwardout, iscarriedforwardin, sequencenumber, ispost, [year], currentperiod, quantityCr
			,amountDr, amountCr, origAmountDr, OrigAmountCr, isPeriodBegin,DocDrCrType, idaccount, idcurrency, idDocType
			,idauxAccCustomer,direction, makerId, docid, entryid, auxiliaryinfoid, idaccountingperiod, madedate, idUnit)
			values(@docno,@code,@summary,'李静谊',1,@price,0,0,@sequencenumber,0,@currentYear,@currentPeriod,@quantitycr,@amountdr,@amountcr,@origamountdr,@origamountcr
			,0,22,@idaccount,4,5,@idauxAccCustomer,@direction,35,@idDocDTO,@id,@auxiliaryinfoid,@idaccountingperiod,@voucherdate,@idUnit)

		end
	    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    end
    CLOSE Journal_Cursor
    DEALLOCATE Journal_Cursor
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'销售流水单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对应开票信息的出库单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'xs_sn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'石场账套' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'dw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'区分石场' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'division'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'customer_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'customer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'重车时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'zcsj'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'空车时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'kcsj'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'carno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货物名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'goodsname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'毛重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'amount_mao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'皮重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'amount_pi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'净重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'amount_jing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'money'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回单数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'amount_hd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回单日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'hdrq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'磅差(回单数-净重)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'amount_pc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'notes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回单备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'notes_hd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应收企业运费单价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'ys_qyyfdj'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应收企业运费金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'ys_qyyfje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料单价(自动)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'price_material'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料金额(自动)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'money_material'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应付司机运费单价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'yf_sjyfdj'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料金额(快报)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'money_material_k'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应付司机运费金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'flowState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'运费结算方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_fh', @level2type=N'COLUMN',@level2name=N'yfjsfs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库平均单价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_invoiced', @level2type=N'COLUMN',@level2name=N'price_avg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实际收货单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'huayao_invoiced', @level2type=N'COLUMN',@level2name=N'kpdw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'销售流水单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对应开票信息的出库单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'xs_sn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'石场账套' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'dw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'区分石场' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'division'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'customer_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'customer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'重车时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'zcsj'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'空车时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'kcsj'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'carno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货物名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'goodsname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'毛重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'amount_mao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'皮重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'amount_pi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'净重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'amount_jing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'money'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回单数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'amount_hd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回单日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'hdrq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'磅差(回单数-净重)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'amount_pc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'notes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回单备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'notes_hd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应收企业运费单价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'ys_qyyfdj'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应收企业运费金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'ys_qyyfje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料单价(自动)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'price_material'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料金额(自动)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'money_material'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应付司机运费单价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'yf_sjyfdj'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料金额(快报)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'money_material_k'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应付司机运费金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'flowState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'运费结算方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sjs_fh', @level2type=N'COLUMN',@level2name=N'yfjsfs'
GO
USE [master]
GO
ALTER DATABASE [MakeT+Voucher] SET  READ_WRITE 
GO
