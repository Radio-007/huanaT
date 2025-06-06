USE [master]
GO
/****** Object:  Database [MakeT+Voucher]    Script Date: 2025/4/2 14:42:44 ******/
CREATE DATABASE [MakeT+Voucher] ON  PRIMARY 
( NAME = N'MakeT+Voucher', FILENAME = N'D:\MakeT+\db\MakeT+Voucher.mdf' , SIZE = 22528KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MakeT+Voucher_log', FILENAME = N'D:\MakeT+\db\MakeT+Voucher_log.ldf' , SIZE = 1792KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
ALTER DATABASE [MakeT+Voucher] SET RECOVERY FULL 
GO
ALTER DATABASE [MakeT+Voucher] SET  MULTI_USER 
GO
ALTER DATABASE [MakeT+Voucher] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MakeT+Voucher] SET DB_CHAINING OFF 
GO
USE [MakeT+Voucher]
GO
/****** Object:  UserDefinedFunction [dbo].[ClearZero]    Script Date: 2025/4/2 14:42:45 ******/
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
/****** Object:  UserDefinedFunction [dbo].[DelChinese]    Script Date: 2025/4/2 14:42:45 ******/
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
/****** Object:  UserDefinedFunction [dbo].[GetAccountname]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date, ,>
-- Description:	获取简写的科目
-- =============================================
CREATE FUNCTION [dbo].[GetAccountname] 
(
	@strAccountname varchar(50)
)
RETURNS varchar(50)
AS
BEGIN
	declare @ret varchar(50),@pos int
	set @strAccountname=UPPER(@strAccountname)
	set @ret=replace(@strAccountname,' ','')
	set @ret=replace(@ret,'+','')
	
	return @ret
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetAccountname_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date, ,>
-- Description:	获取简写的科目
-- =============================================
CREATE FUNCTION [dbo].[GetAccountname_ah] 
(
	@strAccountname varchar(50)
)
RETURNS varchar(50)
AS
BEGIN
	declare @ret varchar(50),@pos int
	set @strAccountname=UPPER(@strAccountname)
	set @ret=replace(@strAccountname,' ','')
	set @ret=replace(@ret,'+','')
	set @ret=replace(@ret,'（','')
	set @ret=replace(@ret,'）','')
	set @ret=replace(@ret,'1000KG','')
	select @pos=PATINDEX('%KG%',@ret)
	if @pos>4
	begin
		select @ret=substring(@ret,1,@pos-4)
	end
	
	if @ret='CCR-1'
	begin
		select @ret='纳米碳酸钙'
	end
		
	return @ret
END
GO
/****** Object:  UserDefinedFunction [dbo].[Getcg_accountcode]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-3-8
-- Description:	根据货品、仓库，获取T+科目代码
-- =============================================
CREATE FUNCTION [dbo].[Getcg_accountcode] 
(
	@goodsname nvarchar(100),
	@dw nvarchar(100)
)
RETURNS varchar(50)
AS
BEGIN
	DECLARE @result varchar(50),@warehouse nvarchar(50)
	if patindex('%大片石%',@goodsname)>0
		set @goodsname='片石'
		
	set @result=''
	set @warehouse='空'
	if @goodsname='包装袋'
	begin
		set @warehouse='包装袋仓'
	end
	else
	begin
		select Top 1 @warehouse=warehouse from purchase_in where goodsname=@goodsname and dw like '%'+@dw+'%' order by cg_sn desc
	end
	
	select @result=accountcode from goods_account where ISNULL(goodsname,'')='' and warehouse=@warehouse and dw like '%'+@dw+'%'
	if @result<>''
	begin
		return @result
	end
	else
	begin
		select Top 1 @result=accountcode from goods_account where goodsname like '%'+@goodsname+'%' and dw like '%'+@dw+'%'
	end
	
	RETURN @result

END
GO
/****** Object:  UserDefinedFunction [dbo].[Getcg_amountConvert]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date, ,>
-- Description:	数量转换：升、吨
-- =============================================
CREATE FUNCTION [dbo].[Getcg_amountConvert] 
(
	@goodsname nvarchar(100),
	@amount numeric(18,5),
	@dw nvarchar(100)
)
RETURNS numeric(18,5)
AS
BEGIN
	declare @result numeric(18,5),@warehouse nvarchar(50)
	set @result=@amount
	if patindex('%广西华纳%',@dw)>0
	begin
		if patindex('%成品油%',@goodsname)>0 or patindex('%汽油%',@goodsname)>0
			set @result=@amount/1378.35977
		else if patindex('%柴油%',@goodsname)>0
			set @result=@amount/1176.471
	end
		
	return @result
END
GO
/****** Object:  UserDefinedFunction [dbo].[Getcg_partner]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date, ,>
-- Description:	T+没有的往来单位归到零星采购
-- =============================================
CREATE FUNCTION [dbo].[Getcg_partner] 
(
	@supplier nvarchar(100),
	@dw nvarchar(50)
)
RETURNS nvarchar(100)
AS
BEGIN
	DECLARE @result nvarchar(100)
	
	if patindex('%广西华纳%',@dw)>0
	begin
		if not exists(select 1 from UFTData328464_300011.dbo.AA_partner where name like +'%'+@supplier+'%')
			set @result='零星采购'
		else
			set @result = @supplier
	end
	else if patindex('%安徽%',@dw)>0
	begin
		if not exists(select 1 from UFTData305193_300004.dbo.AA_partner where name like +'%'+@supplier+'%')
			set @result='零星采购'
		else
			set @result = @supplier
	end
	else if patindex('%合山%',@dw)>0
	begin
		if not exists(select 1 from UFTData585087_300003.dbo.AA_partner where name like +'%'+@supplier+'%')
			set @result='个体工商户'
		else
			set @result = @supplier
	end
	else
	begin
		set @result = @supplier
	end
		
	RETURN @result
END
GO
/****** Object:  UserDefinedFunction [dbo].[Getcg_voucherid]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-03-07
-- Description:	根据货品名称，获取对应的T+凭证id
-- =============================================
CREATE FUNCTION [dbo].[Getcg_voucherid] 
(
	@supplier nvarchar(100),
	@partner nvarchar(100),
	@indate DateTime,
	@dw nvarchar(100)
)
RETURNS int
AS
BEGIN
	DECLARE @result int

	set @result=0
	if patindex('%广西华纳%',@dw)>0
	begin
		if @partner='零星采购'
		begin
			select Top 1 @result=b.id from UFTData328464_300011.dbo.GL_Doc b inner join UFTData328464_300011.dbo.GL_Entry a on a.idDocDTO=b.id
			where accountingyear=YEAR(@indate) and accountingperiod=MONTH(@indate) and iddoctype=8 
			and a.summary like+'%暂估入%'+@supplier+'%零星采购%' and a.summary not like'%冲销%' and a.summary not like'%购进%'
			order by b.code desc
		end
		else
		begin
			select Top 1 @result=b.id from UFTData328464_300011.dbo.GL_Doc b inner join UFTData328464_300011.dbo.GL_Entry a on a.idDocDTO=b.id
			where accountingyear=YEAR(@indate) and accountingperiod=MONTH(@indate) and iddoctype=8 
			and a.summary like+'%暂估入%'+@supplier+'%' and a.summary not like'%冲销%' and a.summary not like'%购进%'
			--and a.summary like+'%暂估入%彭城%' and a.summary not like'%冲销%' and a.summary not like'%购进%'
			order by b.code desc
		end
	end
	else if patindex('%安徽%',@dw)>0
	begin
		if @partner='零星采购'
		begin
			select Top 1 @result=b.id from UFTData305193_300004.dbo.GL_Doc b inner join UFTData305193_300004.dbo.GL_Entry a on a.idDocDTO=b.id
			where accountingyear=YEAR(@indate) and accountingperiod=MONTH(@indate) and iddoctype=7 
			and a.summary like+'%暂估入%'+@supplier+'%零星采购%' and a.summary not like'%冲销%' and a.summary not like'%购进%'
			order by b.code desc
		end
		else
		begin
			select Top 1 @result=b.id from UFTData305193_300004.dbo.GL_Doc b inner join UFTData305193_300004.dbo.GL_Entry a on a.idDocDTO=b.id
			where accountingyear=YEAR(@indate) and accountingperiod=MONTH(@indate) and iddoctype=7 
			and a.summary like+'%暂估入%'+@supplier+'%' and a.summary not like'%冲销%' and a.summary not like'%购进%'
			order by b.code desc
		end
	end
	else if patindex('%合山%',@dw)>0
	begin
		if @partner='个体工商户'
		begin
			select Top 1 @result=b.id from UFTData585087_300003.dbo.GL_Doc b inner join UFTData585087_300003.dbo.GL_Entry a on a.idDocDTO=b.id
			where accountingyear=YEAR(@indate) and accountingperiod=MONTH(@indate) and iddoctype=6 
			and a.summary like+'%暂估入%'+@supplier+'%个体工商户%' and a.summary not like'%冲%' and a.summary not like'%购进%' 
			order by b.code desc
		end
		else
		begin
			select Top 1 @result=b.id from UFTData585087_300003.dbo.GL_Doc b inner join UFTData585087_300003.dbo.GL_Entry a on a.idDocDTO=b.id
			where accountingyear=YEAR(@indate) and accountingperiod=MONTH(@indate) and iddoctype=6 
			and a.summary like+'%暂估入%'+@supplier+'%' and a.summary not like'%冲销%' and a.summary not like'%购进%' 
			order by b.code desc
		end
	end

	RETURN @result

END
GO
/****** Object:  UserDefinedFunction [dbo].[Getcgyl_goodsname]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date, ,>
-- Description:	获取原料统一名称
-- =============================================
CREATE FUNCTION [dbo].[Getcgyl_goodsname] 
(
	@goodsname nvarchar(100),
	@dw nvarchar(100)
)
RETURNS nvarchar(100)
AS
BEGIN
	declare @result nvarchar(100),@warehouse nvarchar(50)
	set @result=''
	set @warehouse=''
	select Top 1 @warehouse=warehouse from purchase_in where goodsname=@goodsname and dw like+'%'+@dw+'%' order by cg_sn desc
	if @warehouse<>''
	begin
		select @result=replace(warehouse,'仓','') from goods_account where isnull(goodsname,'')='' and warehouse=@warehouse and dw like+'%'+@dw+'%'
		if @result='油料'
		begin
			set @result=@goodsname
		end
		else if @result='碳酸钙粉'
		begin
			set @result=@goodsname
		end
		
		if @result=''
		begin
			set @result=@goodsname
		end
	end
	else
	begin
		set @result=@goodsname
	end
	
	if patindex('%木托盘%',@goodsname)>0
		set @result=@goodsname
	else if patindex('%缠绕膜%',@goodsname)>0
		set @result=@goodsname
	
	return @result
END
GO
/****** Object:  UserDefinedFunction [dbo].[Getcgyl_price]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date, ,>
-- Description:	获取原料T+单位
-- =============================================
CREATE FUNCTION [dbo].[Getcgyl_price] 
(
	@id int,
	@tablename nvarchar(50)
)
RETURNS numeric(18,2)
AS
BEGIN
	declare @result numeric(18,2),@price numeric(18,2),@warehouse nvarchar(50),@amount numeric(18,5),@money numeric(18,2)
	set @result=0
	set @warehouse=null
	if @tablename='开票'
		select @price=price,@warehouse=warehouse,@amount=amount,@money=[money] from purchase_invoiced where id=@id
	else
		select @price=price,@warehouse=warehouse,@amount=amount,@money=[money] from purchase_in where id=@id
		
	if @warehouse is not null
	begin
		if @warehouse='包装袋仓'
			set @result=0
		else if @amount=0 and @price>0 and @money>0
		begin
			set @result=0
		end
		else
			set @result=@price
	end
	return @result
END
GO
/****** Object:  UserDefinedFunction [dbo].[Getcgyl_Unit]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date, ,>
-- Description:	获取原料T+单位
-- =============================================
CREATE FUNCTION [dbo].[Getcgyl_Unit] 
(
	@goodsname nvarchar(100),
	@goodsunit nvarchar(30),
	@dw nvarchar(100)
)
RETURNS nvarchar(100)
AS
BEGIN
	declare @result nvarchar(100),@warehouse nvarchar(50)
	set @result=@goodsunit
	set @warehouse=''
	select Top 1 @warehouse=warehouse from purchase_in where goodsname=@goodsname and dw like+'%'+@dw+'%' order by cg_sn desc
	if @warehouse='包装袋仓'
	begin
		if patindex('%广西华纳%',@dw)>0
			set @result='条'
		else if patindex('%安徽%',@dw)>0
			set @result='条'
		else
			set @result=@goodsunit
	end
	else
	begin
		if patindex('%广西华纳%',@dw)>0
		begin
			if @goodsunit='升'
				set @result='吨'
		end
	end
	
	if patindex('%立方%',@goodsunit)>0
		set @result='立方米'
	
	return @result
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetFirstRowAccName_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date, ,>
-- Description:	获取第一行科目名称
-- =============================================
CREATE FUNCTION [dbo].[GetFirstRowAccName_hs] 
(
	@customer nvarchar(100)
)
RETURNS varchar(50)
AS
BEGIN
	declare @ret varchar(50)
	set @ret='1122'  --应收账款
	--if @customer='广西华纳新材料股份有限公司'
	--	set @ret='2241002'  --其他应付款-单位往来
	
	return @ret	
END
GO
/****** Object:  Table [dbo].[goods_account]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[goods_account](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[accountcode] [nvarchar](50) NULL,
	[accountname] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[warehouse] [nvarchar](50) NULL,
	[dw] [nvarchar](50) NULL,
 CONSTRAINT [PK_goods_account] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[purchase_in]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[purchase_in](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cg_sn] [nvarchar](50) NOT NULL,
	[sno] [nvarchar](10) NOT NULL,
	[dw] [nvarchar](150) NULL,
	[indate] [datetime] NULL,
	[supplier_no] [nvarchar](50) NULL,
	[supplier] [nvarchar](150) NULL,
	[warehouse_no] [nvarchar](50) NULL,
	[warehouse] [nvarchar](50) NULL,
	[goodsno] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[goodsspec] [nvarchar](200) NULL,
	[goodsunit] [nvarchar](50) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[money_notax] [numeric](18, 2) NULL,
	[money_tax] [numeric](18, 2) NULL,
	[notes] [nvarchar](200) NULL,
	[useto] [nvarchar](100) NULL,
	[writeoffState] [int] NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
 CONSTRAINT [PK_purchase_in] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[purchase_intemp]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[purchase_intemp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cg_sn] [nvarchar](50) NOT NULL,
	[sno] [nvarchar](10) NOT NULL,
	[dw] [nvarchar](150) NULL,
	[indate] [datetime] NULL,
	[supplier_no] [nvarchar](50) NULL,
	[supplier] [nvarchar](150) NULL,
	[warehouse_no] [nvarchar](50) NULL,
	[warehouse] [nvarchar](50) NULL,
	[goodsno] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[goodsspec] [nvarchar](200) NULL,
	[goodsunit] [nvarchar](50) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[money_notax] [numeric](18, 2) NULL,
	[money_tax] [numeric](18, 2) NULL,
	[notes] [nvarchar](200) NULL,
	[useto] [nvarchar](100) NULL,
	[writeoffState] [int] NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
 CONSTRAINT [PK_purchase_intemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[purchase_invoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[purchase_invoiced](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sid] [nvarchar](50) NOT NULL,
	[sno] [nvarchar](10) NOT NULL,
	[cg_sn] [nvarchar](50) NULL,
	[dw] [nvarchar](100) NULL,
	[jsrq] [datetime] NULL,
	[supplier] [nvarchar](200) NULL,
	[indate] [datetime] NULL,
	[warehouse] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[goodsunit] [nvarchar](50) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[money_notax] [numeric](18, 2) NULL,
	[money_tax] [numeric](18, 2) NULL,
	[kprq] [datetime] NULL,
	[kphm] [nvarchar](400) NULL,
	[fplx] [nvarchar](50) NULL,
	[options] [nvarchar](50) NULL,
	[writeoffState] [int] NULL,
	[notes] [nvarchar](200) NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
 CONSTRAINT [PK_purchase_invoiced] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[purchase_invoicedtemp]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[purchase_invoicedtemp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sid] [nvarchar](50) NOT NULL,
	[sno] [nvarchar](10) NOT NULL,
	[cg_sn] [nvarchar](50) NULL,
	[dw] [nvarchar](100) NULL,
	[jsrq] [datetime] NULL,
	[supplier] [nvarchar](200) NULL,
	[indate] [datetime] NULL,
	[warehouse] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[goodsunit] [nvarchar](50) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[money_notax] [numeric](18, 2) NULL,
	[money_tax] [numeric](18, 2) NULL,
	[kprq] [datetime] NULL,
	[kphm] [nvarchar](400) NULL,
	[fplx] [nvarchar](50) NULL,
	[options] [nvarchar](50) NULL,
	[writeoffState] [int] NULL,
	[notes] [nvarchar](100) NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
 CONSTRAINT [PK_purchase_invoicedtemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[purchase_th]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[purchase_th](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sid] [nvarchar](50) NULL,
	[sno] [nvarchar](10) NOT NULL,
	[options] [nvarchar](50) NULL,
	[cg_sn] [nvarchar](250) NOT NULL,
	[dw] [nvarchar](150) NULL,
	[thdate] [datetime] NULL,
	[indate] [datetime] NULL,
	[supplier_no] [nvarchar](50) NULL,
	[supplier] [nvarchar](150) NULL,
	[warehouse_no] [nvarchar](50) NULL,
	[warehouse] [nvarchar](50) NULL,
	[goodsno] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[goodsspec] [nvarchar](200) NULL,
	[goodsunit] [nvarchar](50) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[money_notax] [numeric](18, 2) NULL,
	[money_tax] [numeric](18, 2) NULL,
	[notes] [nvarchar](200) NULL,
	[writeoffState] [int] NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
 CONSTRAINT [PK_purchase_th] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sale_fh]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sale_fh](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[xs_sn] [nvarchar](50) NULL,
	[randomcode] [nvarchar](50) NULL,
	[carno] [nvarchar](30) NULL,
	[bill_date] [datetime] NULL,
	[dw] [nvarchar](100) NULL,
	[production] [nvarchar](100) NULL,
	[customer] [nvarchar](200) NULL,
	[dealer] [nvarchar](50) NULL,
	[salesman] [nvarchar](30) NULL,
	[fhrq] [datetime] NULL,
	[goodsno] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[goodsspec] [nvarchar](30) NULL,
	[goodsunit] [nvarchar](20) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[writeoffState] [int] NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
 CONSTRAINT [PK_sale_fh] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sale_fhtemp]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sale_fhtemp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[xs_sn] [nvarchar](50) NULL,
	[randomcode] [nvarchar](50) NULL,
	[carno] [nvarchar](30) NULL,
	[bill_date] [datetime] NULL,
	[dw] [nvarchar](100) NULL,
	[production] [nvarchar](100) NULL,
	[customer] [nvarchar](200) NULL,
	[dealer] [nvarchar](50) NULL,
	[salesman] [nvarchar](30) NULL,
	[fhrq] [datetime] NULL,
	[goodsno] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[goodsspec] [nvarchar](30) NULL,
	[goodsunit] [nvarchar](20) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[writeoffState] [int] NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
 CONSTRAINT [PK_sale_fhtemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sale_pc]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sale_pc](
	[id] [nvarchar](50) NOT NULL,
	[xs_sn] [nvarchar](50) NULL,
	[sno] [int] NULL,
	[dw] [nvarchar](100) NULL,
	[production] [nvarchar](100) NULL,
	[customer] [nvarchar](200) NULL,
	[fhrq] [datetime] NULL,
	[goodsname] [nvarchar](50) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[reason] [nvarchar](50) NULL,
	[handleway] [nvarchar](50) NULL,
	[writeoffState] [int] NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
 CONSTRAINT [PK_sale_pc] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sale_stockprice]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sale_stockprice](
	[sid] [nvarchar](50) NOT NULL,
	[dw] [nvarchar](100) NULL,
	[jsrq] [datetime] NULL,
	[accountcode] [nvarchar](50) NULL,
	[goodsname] [nvarchar](100) NULL,
	[price] [numeric](18, 5) NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
 CONSTRAINT [PK_sale_stockprice] PRIMARY KEY CLUSTERED 
(
	[sid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sale_th]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sale_th](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[th_sn] [nvarchar](50) NULL,
	[randomcode] [nvarchar](50) NULL,
	[xs_sn] [nvarchar](50) NULL,
	[carno] [nvarchar](50) NULL,
	[dw] [nvarchar](100) NULL,
	[bill_date] [datetime] NULL,
	[customer] [nvarchar](100) NULL,
	[salesman] [nvarchar](50) NULL,
	[dealer] [nvarchar](50) NULL,
	[reason] [nvarchar](100) NULL,
	[thrq] [datetime] NULL,
	[goodsno] [nvarchar](50) NULL,
	[goodsname] [nvarchar](50) NULL,
	[goodsspec] [nvarchar](30) NULL,
	[goodsunit] [nvarchar](20) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[notes] [nvarchar](100) NULL,
	[writeoffState] [int] NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
 CONSTRAINT [PK_sale_th] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_invoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_invoiced](
	[id] [nvarchar](50) NOT NULL,
	[fhrq] [datetime] NULL,
	[customer] [nvarchar](200) NULL,
	[goodsname] [nvarchar](50) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[money_notax] [numeric](18, 2) NULL,
	[money_tax] [numeric](18, 2) NULL,
	[dw] [nvarchar](100) NULL,
	[production] [nvarchar](100) NULL,
	[xs_sn] [nvarchar](50) NULL,
	[kprq] [datetime] NULL,
	[kphm] [nvarchar](400) NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
	[writeoffState] [int] NULL,
	[options] [nvarchar](50) NULL,
 CONSTRAINT [PK_tb_invoiced] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_invoicedtemp]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_invoicedtemp](
	[id] [nvarchar](50) NOT NULL,
	[fhrq] [datetime] NULL,
	[customer] [nvarchar](200) NULL,
	[goodsname] [nvarchar](50) NULL,
	[amount] [numeric](18, 4) NULL,
	[price] [numeric](18, 2) NULL,
	[money] [numeric](18, 2) NULL,
	[money_notax] [numeric](18, 2) NULL,
	[money_tax] [numeric](18, 2) NULL,
	[dw] [nvarchar](100) NULL,
	[production] [nvarchar](100) NULL,
	[xs_sn] [nvarchar](50) NULL,
	[kprq] [datetime] NULL,
	[kphm] [nvarchar](400) NULL,
	[flowState] [int] NULL,
	[createTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
	[writeoffState] [int] NULL,
	[options] [nvarchar](50) NULL,
 CONSTRAINT [PK_tb_invoicedtemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[DelRepeatStr]    Script Date: 2025/4/2 14:42:45 ******/
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
/****** Object:  UserDefinedFunction [dbo].[tbSplit]    Script Date: 2025/4/2 14:42:45 ******/
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
/****** Object:  View [dbo].[v_Invoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_Invoiced]
as
SELECT case when dw='广西华纳新材料股份有限公司' then 
(case when production=dw then dbo.DelChinese(goodsname) else dbo.DelChinese(goodsname)+'(1)' end)  
else dbo.DelChinese(goodsname) end as goodscategory,
id, fhrq, customer, goodsname, amount, price, money,
money_notax, money_tax, dw, production, xs_sn, kprq, kphm,  
flowState, createTime, updateTime, writeoffState, options
FROM tb_invoiced
GO
/****** Object:  View [dbo].[v_sale_fh]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_sale_fh]
as
SELECT case when dw='广西华纳新材料股份有限公司' then 
(case when production=dw then dbo.DelChinese(goodsname) else dbo.DelChinese(goodsname)+'(1)' end)  
else dbo.DelChinese(goodsname) end as goodscategory, *
FROM sale_fh
GO
/****** Object:  StoredProcedure [dbo].[AddVoucherMaster]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	增加凭证主表，返回id
-- =============================================
CREATE PROCEDURE [dbo].[AddVoucherMaster] 
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
	exec GetDocOrderNum @currentYear,@currentPeriod,@strDocOrderNum output

	select @idPeriod=id FROM UFTData328464_300011.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod
	
	select @voucherdate=cast(@currentYear as varchar(10))+'-'+cast(@currentPeriod as varchar(10))+'-'+cast(day(getdate()) as varchar(10))--当天
	if Convert(DateTime,Convert(varchar(10),getdate(),120))>@voucherdate	
		SELECT  @voucherdate=convert(varchar(10),dateadd(month, datediff(month, -1, @voucherdate), -1),120) --当月最后一天
		
	select @sql=N'
		insert UFTData328464_300011.dbo.GL_Doc(code, [name], accuorigamountdr, accuorigamountcr, accuamountdr, accuamountcr, iscashieraudit
		,ispost, iserror, isinvalidate, iscashflowed, isquantitydoc, isforeigncurrencydoc 
		,accountingperiod, accountingyear, maker, iscarriedforwardout, iscarriedforwardin, ismodifiedcode
		,isCashierDoc, DocOrderNum, PrintCount, isCashflowByHand, iddoctype, cashflowedstate, docbusinesstype
		,invalidateState, makeErrorState, voucherstate, makerid, idperiod, voucherdate, madedate, createdtime,IdMarketingOrgan)
		values('''+right(@strDocOrderNum,6)+''','''','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+',0,0,0,0,0,1
		,0,'+cast(@currentPeriod as varchar(10))+','+cast(@currentYear as varchar(10))+',''赵健廷'',0,0,0
		,0,'''+@strDocOrderNum+''',0,0,9,655,625,682,679,181,124,'+cast(@idPeriod as varchar(30))+','''+@voucherdate+''',Convert(varchar(10),getdate(),120),getdate(),1) 
		select @idDocDTO=@@identity'
	
	--print @sql
	EXEC sp_executesql @sql,N'@idDocDTO int out',@idDocDTO OUT
END
GO
/****** Object:  StoredProcedure [dbo].[ah_AddVoucherMaster]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	增加凭证主表，返回id
-- =============================================
CREATE PROCEDURE [dbo].[ah_AddVoucherMaster] 
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
	exec ah_GetDocOrderNum @currentYear,@currentPeriod,@strDocOrderNum output

	select @idPeriod=id FROM UFTData305193_300004.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod
	
	select @voucherdate=cast(@currentYear as varchar(10))+'-'+cast(@currentPeriod as varchar(10))+'-'+cast(day(getdate()) as varchar(10))--当天
	if Convert(DateTime,Convert(varchar(10),getdate(),120))>@voucherdate	
		SELECT  @voucherdate=convert(varchar(10),dateadd(month, datediff(month, -1, @voucherdate), -1),120) --当月最后一天
		
	select @sql=N'
		insert UFTData305193_300004.dbo.GL_Doc(code, [name], accuorigamountdr, accuorigamountcr, accuamountdr, accuamountcr, iscashieraudit
		,ispost, iserror, isinvalidate, iscashflowed, isquantitydoc, isforeigncurrencydoc 
		,accountingperiod, accountingyear, maker, iscarriedforwardout, iscarriedforwardin, ismodifiedcode
		,isCashierDoc, DocOrderNum, PrintCount, isCashflowByHand, iddoctype, cashflowedstate, docbusinesstype
		,invalidateState, makeErrorState, voucherstate, makerid, idperiod, voucherdate, madedate, createdtime,IdMarketingOrgan)
		values('''+right(@strDocOrderNum,6)+''','''','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+',0,0,0,0,0,1
		,0,'+cast(@currentPeriod as varchar(10))+','+cast(@currentYear as varchar(10))+',''陈冬梅'',0,0,0
		,0,'''+@strDocOrderNum+''',0,0,6,655,625,682,679,181,23,'+cast(@idPeriod as varchar(30))+','''+@voucherdate+''',Convert(varchar(10),getdate(),120),getdate(),1) 
		select @idDocDTO=@@identity'
	
	--print @sql
	EXEC sp_executesql @sql,N'@idDocDTO int out',@idDocDTO OUT
END
GO
/****** Object:  StoredProcedure [dbo].[ah_GetDocOrderNum]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-01
-- Description:	获取凭证唯一标示号
-- =============================================
CREATE PROCEDURE [dbo].[ah_GetDocOrderNum]
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

	--凭证类别ID=9，AA_DocType.sequencenumber=8
	DECLARE @strNo nvarchar(50),@sql NVARCHAR(4000)
	set @strNo='0001'+cast(@currentYear as nvarchar(20))+isnull(replicate('0',2-len(@currentPeriod)),'')+cast(@currentPeriod as varchar(20))+'0005'
	select @sql=N'if exists(select 1 from UFTData305193_300004.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%'')
	begin
		select @strDocOrderNum=(right(max(DocOrderNum),6)+1) from UFTData305193_300004.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%''
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
/****** Object:  StoredProcedure [dbo].[ah_InsertGiveAndPc]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	赠送、磅差
-- =============================================
CREATE PROCEDURE [dbo].[ah_InsertGiveAndPc] 
(
	@idDocDTO int,   --凭证id
	@kphm nvarchar(400), --发票号码
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	declare @code nvarchar(10),@sequencenumber int,@idaccount int,@Customer nvarchar(100)
	declare @goodsname nvarchar(100),@amount numeric(18,4),@money numeric(18,2)
		,@row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max)
		
	select TOP 1 @code=a.code,@sequencenumber=a.sequencenumber from UFTData305193_300004.dbo.GL_Doc b inner join UFTData305193_300004.dbo.GL_Entry a on a.idDocDTO=b.id
	where a.idDocDTO=@idDocDTO order by a.code desc
	
	if @idDocDTO>0 and @kphm<>''
	begin
		select Top 1 @Customer=customer from tb_invoiced where kphm=@kphm
		--赠送
		if exists(select 1 from sale_fh where writeoffState=0 and amount>0 and money=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm))
		begin
			set @head_summary='赠送'
			--销售费用-其他
			select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='6601099' and accountingyear=@currentYear
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'赠送第一行',1,0,null,0,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--明细
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,sum(amount) from v_sale_fh 
			where amount>0 and money=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
			group by goodscategory order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where name like'%'+@goodsname+'%' and code like'1405%' and accountingyear=@currentYear --库存商品-CCS系列-P180

				set @row_summary='赠送'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer
				set @head_summary=@head_summary+'+'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
						
			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@customer
			set @foot_summary=@head_summary
			select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2221001003' and accountingyear=@currentYear --应交税费-应交增值税-销项税额
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,null,null,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新第一行摘要
			update UFTData305193_300004.dbo.GL_Entry set summary=@head_summary,origamountdr=null,amountdr=null 
			where idDocDTO=@idDocDTO and summary='赠送第一行'
		
			--反更新销售出库单
			update sale_fh set writeoffState=1 where writeoffState=0 and amount>0 and money=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
		end

		--磅差
		if exists(select 1 from sale_pc where writeoffState=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm))
		begin
			set @head_summary='磅差'
			--销售费用-其他
			select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='6601099' and accountingyear=@currentYear
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'磅差第一行',1,0,null,0,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--明细
			DECLARE Entry_Cursor CURSOR FOR select dbo.DelChinese(goodsname) goodsname,sum(amount) from sale_pc 
			where writeoffState=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
			group by dbo.DelChinese(goodsname) order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where name like'%'+@goodsname+'%' and code like'1405%' and accountingyear=@currentYear --库存商品-CCS系列-P180

				set @row_summary='磅差'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer
				set @head_summary=@head_summary+'+'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			
			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer
			--更新第一行摘要
			update UFTData305193_300004.dbo.GL_Entry set summary=@head_summary,origamountdr=null,amountdr=null 
			where idDocDTO=@idDocDTO and summary='磅差第一行'
		
			--反更新磅差处理单
			update sale_pc set writeoffState=1 where writeoffState=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
		end
	end
	else if @kphm=''
	begin
		select @Customer=replace(AuxiliaryItems,'01','') from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO and AuxiliaryItems is not null
		set @head_summary='磅差'
		--销售费用-其他
		select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='6601099' and accountingyear=@currentYear
		set @sequencenumber=@sequencenumber+1
		set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
		insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
		, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
		values(@code,'磅差第一行',1,0,null,0,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

		--明细
		DECLARE Entry_Cursor CURSOR FOR select dbo.DelChinese(goodsname) goodsname,sum(amount) from sale_pc 
		where writeoffState=0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod and dw='安徽省宣城市华纳新材料科技有限公司'
		group by dbo.DelChinese(goodsname) order by goodsname
		OPEN Entry_Cursor
		FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
		while @@fetch_status = 0
		begin
			--分录表
			select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where name like'%'+@goodsname+'%' and code like'1405%' and accountingyear=@currentYear --库存商品-CCS系列-P180

			set @row_summary='磅差'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer
			set @head_summary=@head_summary+'+'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

			--print @row_summary
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
		end
		CLOSE Entry_Cursor
		DEALLOCATE Entry_Cursor
			
		set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer
		--更新第一行摘要
		update UFTData305193_300004.dbo.GL_Entry set summary=@head_summary,origamountdr=null,amountdr=null 
		where idDocDTO=@idDocDTO and summary='磅差第一行'
		
		--反更新磅差处理单
		update sale_pc set writeoffState=1 where writeoffState=0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod and dw='安徽省宣城市华纳新材料科技有限公司'
	end
END
GO
/****** Object:  StoredProcedure [dbo].[ah_InsertVoucherJournal]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-02
-- Description:	从分录表获取数据，插入凭证明细表
-- =============================================
CREATE PROCEDURE [dbo].[ah_InsertVoucherJournal] 
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

	select @docno=code,@currentYear=accountingyear,@currentPeriod=accountingperiod,@voucherdate=voucherdate from UFTData305193_300004.dbo.GL_Doc where id=@idDocDTO
	select @idaccountingperiod=id FROM UFTData305193_300004.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod --会计期间ID
	
	--删除所有
	delete from UFTData305193_300004.dbo.GL_AuxiliaryInfo where DocId=@idDocDTO
	delete from UFTData305193_300004.dbo.GL_Journal where DocId=@idDocDTO
	
	DECLARE Journal_Cursor CURSOR FOR select id,code,summary,origamountdr,origamountcr,amountdr,amountcr,quantitycr,price,sequencenumber,AuxiliaryItems,idaccount,idUnit 
	from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO order by sequencenumber
	OPEN Journal_Cursor
    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    while @@fetch_status = 0
    begin		
		--插入辅助信息DTO
		if @AuxiliaryItems is not null or @idUnit is not null
		begin
			select @idauxAccCustomer=id from UFTData305193_300004.dbo.AA_Partner where [name]=@AuxiliaryItems
			insert into UFTData305193_300004.[dbo].[GL_AuxiliaryInfo](exchangerate,idauxAccCustomer,DocId,idEntryDTO)
			values(1.0,@idauxAccCustomer,@idDocDTO,@id)
			select @auxiliaryinfoid=@@identity
		end
		set @direction=652  --借方
		if @amountcr is not null
			set @direction=653  --贷方
		if not exists(select 1 from UFTData305193_300004.dbo.[GL_Journal] where docid=@idDocDTO and entryid=@id)
		begin
			insert into UFTData305193_300004.[dbo].[GL_Journal](docno, rowno, summary, maker, exchangerate, price
			,iscarriedforwardout, iscarriedforwardin, sequencenumber, ispost, [year], currentperiod, quantityCr
			,amountDr, amountCr, origAmountDr, OrigAmountCr, isPeriodBegin,DocDrCrType, idaccount, idcurrency, idDocType
			,idauxAccCustomer,direction, makerId, docid, entryid, auxiliaryinfoid, idaccountingperiod, madedate, idUnit,IdMarketingOrgan)
			values(@docno,@code,@summary,'陈冬梅',1,@price,0,0,@sequencenumber,0,@currentYear,@currentPeriod,@quantitycr,@amountdr,@amountcr,@origamountdr,@origamountcr
			,0,22,@idaccount,4,6,@idauxAccCustomer,@direction,23,@idDocDTO,@id,@auxiliaryinfoid,@idaccountingperiod,@voucherdate,@idUnit,1)

		end
	    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    end
    CLOSE Journal_Cursor
    DEALLOCATE Journal_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[ah_Invoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	已开票凭证，每隔3天执行
-- =============================================
CREATE PROCEDURE [dbo].[ah_Invoiced] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：销售CCS-25  28.4T  保光（天津）  01184714,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4),@money numeric(18,2)
		,@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2),@docTitle nvarchar(60)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	
	DECLARE @tb_goods TABLE(name varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)

	DECLARE customer_Cursor CURSOR FOR select customer,kphm from v_invoiced where writeoffState=0 and isnull(options,'')='' and [money]>0 and kprq is not null 
	and year(fhrq)=year(kprq) and month(fhrq)=month(kprq) and year(kprq)=@currentYear and month(kprq)=@currentPeriod 
	and dw='安徽省宣城市华纳新材料科技有限公司'
	group by customer,kphm order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@kphm
    while @@fetch_status = 0
    begin
		set @docTitle='已开票'
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec ah_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,@docTitle,@idDocDTO output
		--print @idDocDTO
		if @idDocDTO>0
		begin
			set @sequencenumber=1
			set @code='0000'
			set @head_summary='销售' --第一行汇总
			--科目表
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1

			delete from @tb_goods  --清空数据

			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@head_summary,1,0,null,0,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) from v_invoiced 
			where writeoffState=0 and isnull(options,'')='' and [money]>0  and customer=@Customer and kphm=@kphm 
			and kprq is not null and year(fhrq)=year(kprq) and month(fhrq)=month(kprq) and year(kprq)=@currentYear and month(kprq)=@currentPeriod
			and dw='安徽省宣城市华纳新材料科技有限公司'
			group by goodscategory,price order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where name=dbo.GetAccountname_ah(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)

				--print @row_summary
				insert into @tb_goods([name],amount)values(replace(@goodsname,'(1)',''),@amount) --插入表变量

				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣,返利
			set @money=0
			set @moneyNotax=0
			set @moneyTax=0
			select @money=SUM([money]),@moneyNotax=SUM(money_notax),@moneyTax=SUM(money_tax) from tb_invoiced 
			where options in('折扣','返利') and dw='安徽省宣城市华纳新材料科技有限公司' and kphm=@kphm
			if ABS(@money)>0 or ABS(@moneyNotax)>0
			begin
				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T折扣'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --减去税额13%
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				
				update tb_invoiced set writeoffState=1 where options in('折扣','返利') and dw='安徽省宣城市华纳新材料科技有限公司' and kphm=@kphm
			end
			
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select [name],sum(amount) from @tb_goods group by [name] 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			--尾行汇总
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+'  '+@kphm --替换第一个'+'字符
			select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新第一行摘要
			update UFTData305193_300004.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and sequencenumber=1

			--赠送
			exec ah_InsertGiveAndPc @idDocDTO,@kphm,@currentYear,@currentPeriod

			update UFTData305193_300004.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO
				and exists(select 1 from UFTData305193_300004.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')
				if @Customer='广西华纳新材料股份有限公司'
				begin
					select @idaccount=id from UFTData305193_300004.dbo.AA_Account where code='2241002' and accountingyear=@currentYear			
					update UFTData305193_300004.dbo.GL_Entry set AuxiliaryItems=@Customer where idDocDTO=@idDocDTO and AuxiliaryItems is not null 
					update UFTData305193_300004.dbo.GL_Entry set idaccount=@idaccount where idDocDTO=@idDocDTO and origamountdr is not null and AuxiliaryItems is not null 
				end
			
			--更新主表金额
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@amountdr_total, accuorigamountcr=@amountdr_total, accuamountdr=@amountdr_total
			, accuamountcr=@amountdr_total where id=@idDocDTO

			--导入明细表
			exec ah_InsertVoucherJournal @idDocDTO

			--反更新简道云销售发货表
			update tb_invoiced set writeoffState=1 where writeoffState=0 and customer=@Customer and kphm=@kphm 
			and dw='安徽省宣城市华纳新材料科技有限公司'
			update sale_fh set writeoffState=1 from sale_fh a inner join tb_invoiced b on b.xs_sn=a.xs_sn
			where a.writeoffState=0 and a.customer=@Customer and a.xs_sn in(select xs_sn from tb_invoiced where customer=@Customer and kphm=@kphm)
			and a.dw='安徽省宣城市华纳新材料科技有限公司'
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[ah_Notinvoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	上月未开票凭证，每月最后一天或次月1号执行
-- =============================================
CREATE PROCEDURE [dbo].[ah_Notinvoiced] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要为XX月未开票XXX产品XX吨客户名称,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@summoney numeric(12,2),@goodsname nvarchar(100),@price numeric(10,2),@amount numeric(18,4),@money numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@strTemp nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@th_id int, @amount_th numeric(18,4),@money_th numeric(18,2)

	DECLARE @tb_goods TABLE(goodscategory varchar(50),goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	DECLARE customer_Cursor CURSOR FOR select customer,sum(money) from v_sale_fh where writeoffState=0 and [money]>0 
	and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod
	and dw='安徽省宣城市华纳新材料科技有限公司'
	group by customer order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    while @@fetch_status = 0
    begin
		if not exists(select 1 from UFTData305193_300004.dbo.GL_Entry a inner join UFTData305193_300004.dbo.GL_Doc b on b.id=a.idDocDTO 
			where b.accountingyear=@currentYear and b.accountingperiod=@currentPeriod and b.iddoctype=6  
			and a.summary like cast(@currentPeriod as varchar(2))+'月未开票' and a.AuxiliaryItems like @Customer +'%')
		begin
			--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
			exec ah_AddVoucherMaster @Customer,@summoney,@currentYear,@currentPeriod,'未开票',@idDocDTO output
			--print @idDocDTO
			if @idDocDTO>0
			begin
				set @sequencenumber=1
				set @code='0000'
				set @head_summary=cast(@currentPeriod as varchar(10))+'月未开票' --第一行汇总
				--科目表
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1

				delete from @tb_goods  --清空数据

				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@head_summary,1,@summoney,null,@summoney,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

				set @amountcr_total=0  --贷方金额
				set @amountdr_total=0  --借方金额
				DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,sum(amount),sum([money]) 
				from v_sale_fh where writeoffState=0 and [money]>0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod 
				and dw='安徽省宣城市华纳新材料科技有限公司'
				group by goodscategory,price order by goodscategory
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
				while @@fetch_status = 0
				begin
					--分录表
					select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where name=dbo.GetAccountname_ah(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

					DECLARE th_Cursor CURSOR FOR select id,amount,[money]
					from sale_th where writeoffState=0 and customer=@Customer and dbo.DelChinese(goodsname)=dbo.DelChinese(@goodsname) and price=@price and year(thrq)=@currentYear and month(thrq)=@currentPeriod 
					order by thrq
					OPEN th_Cursor
					FETCH NEXT FROM th_Cursor INTO @th_id,@amount_th,@money_th
					while @@fetch_status = 0
					begin
						if @amount>0
						begin
							set @amount=@amount-@amount_th
							set @money=@money-@money_th
							update sale_th set writeoffState=1 where id=@th_id
						end
						FETCH NEXT FROM th_Cursor INTO @th_id,@amount_th,@money_th
					end
					CLOSE th_Cursor
					DEALLOCATE th_Cursor
					
					set @row_summary=cast(@currentPeriod as varchar(10))+'月未开票'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer
					set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
					set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
					set @amountdr_total=@amountdr_total+@money  --借方金额
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)

					insert into @tb_goods(goodscategory, goodsname,amount)values(@goodsname,@goodsname,@amount) --插入表变量

					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

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

				set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer --替换第一个'+'字符
				--尾行汇总
				select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,round((@amountdr_total-@amountcr_total),2),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				--print @head_summary
				--更新第一行摘要
				update UFTData305193_300004.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
				where idDocDTO=@idDocDTO and sequencenumber=1

				--赠送
				exec ah_InsertGiveAndPc @idDocDTO,'',@currentYear,@currentPeriod

				update UFTData305193_300004.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO
				and exists(select 1 from UFTData305193_300004.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')
				if @Customer='广西华纳新材料股份有限公司'
				begin
					select @idaccount=id from UFTData305193_300004.dbo.AA_Account where code='2241002' and accountingyear=@currentYear			
					update UFTData305193_300004.dbo.GL_Entry set AuxiliaryItems=@Customer where idDocDTO=@idDocDTO and AuxiliaryItems is not null 
					update UFTData305193_300004.dbo.GL_Entry set idaccount=@idaccount where idDocDTO=@idDocDTO and origamountdr is not null and AuxiliaryItems is not null 
				end

				--更新主表金额
				update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@amountdr_total, accuorigamountcr=@amountdr_total, accuamountdr=@amountdr_total
				, accuamountcr=@amountdr_total where id=@idDocDTO

				--导入明细表
				exec ah_InsertVoucherJournal @idDocDTO
				
				--反写销售出库
				update sale_fh set writeoffState=-1 where writeoffState=0 and [money]>0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod
				and dw='安徽省宣城市华纳新材料科技有限公司'
			end
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[ah_WriteOffNotinvoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[ah_WriteOffNotinvoiced] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@id nvarchar(50),@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@updateRow int,@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@rowmoney numeric(12,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@accountyear int,@accountperiod int
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),xs_sn varchar(50),fhrq DateTime,customer varchar(100),goodscategory varchar(50),goodsname varchar(50)
		,price numeric(18,2),amount numeric(18,4),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400))
	DECLARE @tb_voucherid TABLE(voucher_id int)
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50),@entry_summary nvarchar(max),@goodscategory varchar(50)

	DECLARE customer_Cursor CURSOR FOR select id,Customer,xs_sn,fhrq,goodscategory,price,amount,[money],kphm,money_notax,money_tax from v_invoiced 
	where writeoffState=0 and money>0 and options<>'冲红' and convert(int,(DATENAME(year,kprq)+DATENAME(month,kprq)))>convert(int,(DATENAME(year,fhrq)+DATENAME(month,fhrq)))
	and year(kprq)=@currentYear and month(kprq)=@currentPeriod and dw='安徽省宣城市华纳新材料科技有限公司'
	order by customer,kphm,fhrq,goodscategory
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@moneyNotax,@moneyTax
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select Top 1 @voucher_id=b.id from UFTData305193_300004.dbo.GL_Doc b inner join UFTData305193_300004.dbo.GL_Entry a on a.idDocDTO=b.id
		where accountingyear=year(@fhrq) and accountingperiod=month(@fhrq) and iddoctype=6 
		and a.summary like CAST(accountingperiod as varchar(10))+'月%未开票%' and a.AuxiliaryItems like @Customer+'%'
		--and a.summary like '%未开票%' and (a.summary not like'红冲%' and a.summary not like'冲销%' and a.summary not like'冲红%') and a.AuxiliaryItems like @Customer+'%'
		order by b.madedate
		if @voucher_id>0
		begin
			if not exists(select 1 from @tb_goods where id=@id)
			begin
				insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodscategory,goodsname,price,amount,[money],money_notax,money_tax,kphm)
				values(@voucher_id,@id,@xs_sn,@Customer,@fhrq,replace(@goodsname,'(1)',''),@goodsname,@price,@amount,@money,@moneyNotax,@moneyTax,@kphm)
			end
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@moneyNotax,@moneyTax
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
    DECLARE tbgoods_Cursor CURSOR FOR select customer,kphm from @tb_goods 
    group by customer,kphm order by customer
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec ah_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=79294
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			
			--获取要冲红的之前凭证
			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where customer=@Customer and kphm=@kphm 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				delete from @tb_voucherid  --清除
				select @accountyear=accountingyear,@accountperiod=accountingperiod from UFTData305193_300004.dbo.GL_Doc where id=@voucher_id
				insert into @tb_voucherid(voucher_id)
				select distinct b.id from UFTData305193_300004.dbo.GL_Doc b inner join UFTData305193_300004.dbo.GL_Entry a on a.idDocDTO=b.id
				where accountingyear=@accountyear and accountingperiod=@accountperiod and iddoctype=6 
				and a.summary like CAST(accountingperiod as varchar(10))+'月%未开票%' and a.AuxiliaryItems like @Customer+'%'
				--and a.summary like '%未开票%' and (a.summary not like'红冲%' and a.summary not like'冲销%' and a.summary not like'冲红%') and a.AuxiliaryItems like @Customer+'%'
				--select * from @tb_voucherid
				
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitycr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData305193_300004.dbo.GL_Entry where idDocDTO in(select voucher_id from @tb_voucherid) 
				order by idDocDTO,code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					select @doccode=code,@voucherdate=voucherdate from UFTData305193_300004.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转字1-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code in(select code from UFTData305193_300004.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear
				
					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)

					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					set @sequencenumber=@sequencenumber+1
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodscategory,goodsname,price,amount,[money],money_notax,money_tax,kphm)
			select '0',id,xs_sn,Customer,fhrq,replace(goodscategory,'(1)',''),goodscategory,price,amount,[money],money_notax,money_tax,kphm 
			from v_invoiced b where kphm=@kphm and ISNULL(options,'')='' and id not in(select id from @tb_goods where kphm=@kphm)
			and not exists(select 1 from @tb_goods where id=b.id)
			
			set @updateRow=@sequencenumber		
			set @head_summary='销售' --第一行汇总
			--科目表
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1
			
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@head_summary,1,2,null,2,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from @tb_goods where customer=@Customer and kphm=@kphm
			group by goodsname,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where name=dbo.GetAccountname_ah(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='销售'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣,返利
			set @money=0
			set @moneyNotax=0
			set @moneyTax=0
			select @money=SUM([money]),@moneyNotax=SUM(money_notax),@moneyTax=SUM(money_tax) from tb_invoiced 
			where options in('折扣','返利') and dw='安徽省宣城市华纳新材料科技有限公司' and kphm=@kphm
			if ABS(@money)>0 or ABS(@moneyNotax)>0
			begin
				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T折扣'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --减去税额13%
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				
				update tb_invoiced set writeoffState=1 where options in('折扣','返利') and dw='安徽省宣城市华纳新材料科技有限公司' and kphm=@kphm
			end
			
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodscategory,sum(amount) from @tb_goods 
			where customer=@Customer and kphm=@kphm 
			group by goodscategory order by goodscategory
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+'  '+@kphm --替换第一个'+'字符
			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,@moneyTax_total,null,null,@sequencenumber+1,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新销售第一行摘要
			update UFTData305193_300004.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and sequencenumber=@updateRow

			--赠送
			exec ah_InsertGiveAndPc @idDocDTO,@kphm,@currentYear,@currentPeriod

			update UFTData305193_300004.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO
			and exists(select 1 from UFTData305193_300004.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')
			if @Customer='广西华纳新材料股份有限公司'
			begin
				select @idaccount=id from UFTData305193_300004.dbo.AA_Account where code='2241002' and accountingyear=@currentYear
				update UFTData305193_300004.dbo.GL_Entry set idaccount=@idaccount where idDocDTO=@idDocDTO and origamountcr is null
				and AuxiliaryItems is not null 
				update UFTData305193_300004.dbo.GL_Entry set AuxiliaryItems=@Customer where idDocDTO=@idDocDTO and AuxiliaryItems is not null 
			end

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec ah_InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update tb_invoiced set writeoffState=1 where writeoffState=0 and options<>'冲红' and xs_sn in(select xs_sn from @tb_goods where kphm=@kphm)
			update sale_fh set writeoffState=1 from sale_fh a inner join tb_invoiced b on b.xs_sn=a.xs_sn
			where a.writeoffState<1 and a.xs_sn in(select xs_sn from @tb_goods where kphm=@kphm)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@kphm
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[cg_AddVoucherMaster]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-3-1
-- Description:	增加凭证主表，返回id
-- =============================================
CREATE PROCEDURE [dbo].[cg_AddVoucherMaster] 
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
	exec cg_GetDocOrderNum @currentYear,@currentPeriod,@strDocOrderNum output

	select @idPeriod=id FROM UFTData328464_300011.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod
	
	select @voucherdate=cast(@currentYear as varchar(10))+'-'+cast(@currentPeriod as varchar(10))+'-'+cast(day(getdate()) as varchar(10))--当天
	if Convert(DateTime,Convert(varchar(10),getdate(),120))>@voucherdate	
		SELECT  @voucherdate=convert(varchar(10),dateadd(month, datediff(month, -1, @voucherdate), -1),120) --当月最后一天
		
	select @sql=N'
		insert UFTData328464_300011.dbo.GL_Doc(code, [name], accuorigamountdr, accuorigamountcr, accuamountdr, accuamountcr, iscashieraudit
		,ispost, iserror, isinvalidate, iscashflowed, isquantitydoc, isforeigncurrencydoc 
		,accountingperiod, accountingyear, maker, iscarriedforwardout, iscarriedforwardin, ismodifiedcode
		,isCashierDoc, DocOrderNum, PrintCount, isCashflowByHand, iddoctype, cashflowedstate, docbusinesstype
		,invalidateState, makeErrorState, voucherstate, makerid, idperiod, voucherdate, madedate, createdtime,IdMarketingOrgan)
		values('''+right(@strDocOrderNum,6)+''','''','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+',0,0,0,0,0,1
		,0,'+cast(@currentPeriod as varchar(10))+','+cast(@currentYear as varchar(10))+',''吴明丽'',0,0,0
		,0,'''+@strDocOrderNum+''',0,0,8,655,625,682,679,181,63,'+cast(@idPeriod as varchar(30))+','''+@voucherdate+''',Convert(varchar(10),getdate(),120),getdate(),1) 
		select @idDocDTO=@@identity'
	
	--print @sql
	EXEC sp_executesql @sql,N'@idDocDTO int out',@idDocDTO OUT
END
GO
/****** Object:  StoredProcedure [dbo].[cg_AddVoucherMaster_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-3-1
-- Description:	增加凭证主表，返回id
-- =============================================
CREATE PROCEDURE [dbo].[cg_AddVoucherMaster_ah] 
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
	exec cg_GetDocOrderNum_ah @currentYear,@currentPeriod,@strDocOrderNum output

	select @idPeriod=id FROM UFTData305193_300004.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod
	
	select @voucherdate=cast(@currentYear as varchar(10))+'-'+cast(@currentPeriod as varchar(10))+'-'+cast(day(getdate()) as varchar(10))--当天
	if Convert(DateTime,Convert(varchar(10),getdate(),120))>@voucherdate	
		SELECT  @voucherdate=convert(varchar(10),dateadd(month, datediff(month, -1, @voucherdate), -1),120) --当月最后一天
		
	select @sql=N'
		insert UFTData305193_300004.dbo.GL_Doc(code, [name], accuorigamountdr, accuorigamountcr, accuamountdr, accuamountcr, iscashieraudit
		,ispost, iserror, isinvalidate, iscashflowed, isquantitydoc, isforeigncurrencydoc 
		,accountingperiod, accountingyear, maker, iscarriedforwardout, iscarriedforwardin, ismodifiedcode
		,isCashierDoc, DocOrderNum, PrintCount, isCashflowByHand, iddoctype, cashflowedstate, docbusinesstype
		,invalidateState, makeErrorState, voucherstate, makerid, idperiod, voucherdate, madedate, createdtime,IdMarketingOrgan)
		values('''+right(@strDocOrderNum,6)+''','''','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+',0,0,0,0,0,1
		,0,'+cast(@currentPeriod as varchar(10))+','+cast(@currentYear as varchar(10))+',''陈冬梅'',0,0,0
		,0,'''+@strDocOrderNum+''',0,0,7,655,625,682,679,181,23,'+cast(@idPeriod as varchar(30))+','''+@voucherdate+''',Convert(varchar(10),getdate(),120),getdate(),1) 
		select @idDocDTO=@@identity'
	
	--print @sql
	EXEC sp_executesql @sql,N'@idDocDTO int out',@idDocDTO OUT
END
GO
/****** Object:  StoredProcedure [dbo].[cg_AddVoucherMaster_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-3-1
-- Description:	增加凭证主表，返回id
-- =============================================
CREATE PROCEDURE [dbo].[cg_AddVoucherMaster_hs] 
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
	exec cg_GetDocOrderNum_hs @currentYear,@currentPeriod,@strDocOrderNum output

	select @idPeriod=id FROM UFTData585087_300003.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod
	
	select @voucherdate=cast(@currentYear as varchar(10))+'-'+cast(@currentPeriod as varchar(10))+'-'+cast(day(getdate()) as varchar(10))--当天
	if Convert(DateTime,Convert(varchar(10),getdate(),120))>@voucherdate	
		SELECT  @voucherdate=convert(varchar(10),dateadd(month, datediff(month, -1, @voucherdate), -1),120) --当月最后一天
		
	select @sql=N'
		insert UFTData585087_300003.dbo.GL_Doc(code, [name], accuorigamountdr, accuorigamountcr, accuamountdr, accuamountcr, iscashieraudit
		,ispost, iserror, isinvalidate, iscashflowed, isquantitydoc, isforeigncurrencydoc 
		,accountingperiod, accountingyear, maker, iscarriedforwardout, iscarriedforwardin, ismodifiedcode
		,isCashierDoc, DocOrderNum, PrintCount, isCashflowByHand, iddoctype, cashflowedstate, docbusinesstype
		,invalidateState, makeErrorState, voucherstate, makerid, idperiod, voucherdate, madedate, createdtime,IdMarketingOrgan)
		values('''+right(@strDocOrderNum,6)+''','''','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+',0,0,0,0,0,1
		,0,'+cast(@currentPeriod as varchar(10))+','+cast(@currentYear as varchar(10))+',''马情情'',0,0,0
		,0,'''+@strDocOrderNum+''',0,0,6,655,625,682,679,181,88,'+cast(@idPeriod as varchar(30))+','''+@voucherdate+''',Convert(varchar(10),getdate(),120),getdate(),1) 
		select @idDocDTO=@@identity'
	
	--print @sql
	EXEC sp_executesql @sql,N'@idDocDTO int out',@idDocDTO OUT
END
GO
/****** Object:  StoredProcedure [dbo].[cg_GetDocOrderNum]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-01
-- Description:	获取凭证唯一标示号
-- =============================================
CREATE PROCEDURE [dbo].[cg_GetDocOrderNum]
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

	--凭证类别ID=9，AA_DocType.sequencenumber=8
	DECLARE @strNo nvarchar(50),@sql NVARCHAR(4000)
	set @strNo='0001'+cast(@currentYear as nvarchar(20))+isnull(replicate('0',2-len(@currentPeriod)),'')+cast(@currentPeriod as varchar(20))+'0007'
	select @sql=N'if exists(select 1 from UFTData328464_300011.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%'')
	begin
		select @strDocOrderNum=(right(max(DocOrderNum),6)+1) from UFTData328464_300011.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%''
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
/****** Object:  StoredProcedure [dbo].[cg_GetDocOrderNum_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-01
-- Description:	获取凭证唯一标示号
-- =============================================
CREATE PROCEDURE [dbo].[cg_GetDocOrderNum_ah]
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

	--凭证类别ID=7，AA_DocType.sequencenumber=6
	DECLARE @strNo nvarchar(50),@sql NVARCHAR(4000)
	set @strNo='0001'+cast(@currentYear as nvarchar(20))+isnull(replicate('0',2-len(@currentPeriod)),'')+cast(@currentPeriod as varchar(20))+'0006'
	select @sql=N'if exists(select 1 from UFTData305193_300004.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%'')
	begin
		select @strDocOrderNum=(right(max(DocOrderNum),6)+1) from UFTData305193_300004.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%''
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
/****** Object:  StoredProcedure [dbo].[cg_GetDocOrderNum_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-01
-- Description:	获取凭证唯一标示号
-- =============================================
CREATE PROCEDURE [dbo].[cg_GetDocOrderNum_hs]
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

	--凭证类别ID=6，AA_DocType.sequencenumber=5
	DECLARE @strNo nvarchar(50),@sql NVARCHAR(4000)
	set @strNo='0001'+cast(@currentYear as nvarchar(20))+isnull(replicate('0',2-len(@currentPeriod)),'')+cast(@currentPeriod as varchar(20))+'0005'
	select @sql=N'if exists(select 1 from UFTData585087_300003.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%'')
	begin
		select @strDocOrderNum=(right(max(DocOrderNum),6)+1) from UFTData585087_300003.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%''
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
/****** Object:  StoredProcedure [dbo].[cg_InsertVoucherJournal]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-03-02
-- Description:	从分录表获取数据，插入凭证明细表
-- =============================================
CREATE PROCEDURE [dbo].[cg_InsertVoucherJournal] 
(
@idDocDTO int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @code nvarchar(30),@summary nvarchar(max),@origamountdr decimal(28,14),@origamountcr decimal(28,14),@amountdr decimal(28,14),@amountcr decimal(28,14)
		,@quantitydr decimal(28,14),@price decimal(28,14),@sequencenumber int,@AuxiliaryItems nvarchar(500),@idaccount int,@id int,@idUnit int
	declare @docno varchar(30),@currentYear int,@currentPeriod int,@idauxAccCustomer int,@idaccountingperiod int,@auxiliaryinfoid int,@direction int,@voucherdate DateTime

	select @docno=code,@currentYear=accountingyear,@currentPeriod=accountingperiod,@voucherdate=voucherdate from UFTData328464_300011.dbo.GL_Doc where id=@idDocDTO
	select @idaccountingperiod=id FROM UFTData328464_300011.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod --会计期间ID
	
	--删除所有
	delete from UFTData328464_300011.dbo.GL_AuxiliaryInfo where DocId=@idDocDTO
	delete from UFTData328464_300011.dbo.GL_Journal where DocId=@idDocDTO
	
	DECLARE Journal_Cursor CURSOR FOR select id,code,summary,origamountdr,origamountcr,amountdr,amountcr,quantitydr,price,sequencenumber,AuxiliaryItems,idaccount,idUnit 
	from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO order by sequencenumber
	OPEN Journal_Cursor
    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    while @@fetch_status = 0
    begin	
		--插入辅助信息DTO
		if @AuxiliaryItems is not null or @idUnit is not null
		begin
			select @idauxAccCustomer=id from UFTData328464_300011.dbo.AA_Partner where [name]=@AuxiliaryItems
			insert into UFTData328464_300011.[dbo].[GL_AuxiliaryInfo](exchangerate,idauxAccCustomer,DocId,idEntryDTO)
			values(1.0,@idauxAccCustomer,@idDocDTO,@id)
			select @auxiliaryinfoid=@@identity
		end

		set @direction=652  --借方
		if @amountcr is not null
			set @direction=653  --贷方
		if not exists(select 1 from UFTData328464_300011.dbo.[GL_Journal] where docid=@idDocDTO and entryid=@id)
		begin
			insert into UFTData328464_300011.[dbo].[GL_Journal](docno, rowno, summary, maker, exchangerate, price
			,iscarriedforwardout, iscarriedforwardin, sequencenumber, ispost, [year], currentperiod, quantitydr
			,amountDr, amountCr, origAmountDr, OrigAmountCr, isPeriodBegin,DocDrCrType, idaccount, idcurrency, idDocType
			,idauxAccCustomer,direction, makerId, docid, entryid, auxiliaryinfoid, idaccountingperiod, madedate, idUnit,IdMarketingOrgan)
			values(@docno,@code,@summary,'吴明丽',1,@price,0,0,@sequencenumber,0,@currentYear,@currentPeriod,@quantitydr,@amountdr,@amountcr,@origamountdr,@origamountcr
			,0,22,@idaccount,4,8,@idauxAccCustomer,@direction,63,@idDocDTO,@id,@auxiliaryinfoid,@idaccountingperiod,@voucherdate,@idUnit,1)

		end
	    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    end
    CLOSE Journal_Cursor
    DEALLOCATE Journal_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[cg_InsertVoucherJournal_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-03-02
-- Description:	从分录表获取数据，插入凭证明细表
-- =============================================
CREATE PROCEDURE [dbo].[cg_InsertVoucherJournal_ah] 
(
@idDocDTO int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @code nvarchar(30),@summary nvarchar(max),@origamountdr decimal(28,14),@origamountcr decimal(28,14),@amountdr decimal(28,14),@amountcr decimal(28,14)
		,@quantitydr decimal(28,14),@price decimal(28,14),@sequencenumber int,@AuxiliaryItems nvarchar(500),@idaccount int,@id int,@idUnit int
	declare @docno varchar(30),@currentYear int,@currentPeriod int,@idauxAccCustomer int,@idaccountingperiod int,@auxiliaryinfoid int,@direction int,@voucherdate DateTime

	select @docno=code,@currentYear=accountingyear,@currentPeriod=accountingperiod,@voucherdate=voucherdate from UFTData305193_300004.dbo.GL_Doc where id=@idDocDTO
	select @idaccountingperiod=id FROM UFTData305193_300004.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod --会计期间ID
	
	--删除所有
	delete from UFTData305193_300004.dbo.GL_AuxiliaryInfo where DocId=@idDocDTO
	delete from UFTData305193_300004.dbo.GL_Journal where DocId=@idDocDTO
	
	DECLARE Journal_Cursor CURSOR FOR select id,code,summary,origamountdr,origamountcr,amountdr,amountcr,quantitydr,price,sequencenumber,AuxiliaryItems,idaccount,idUnit 
	from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO order by sequencenumber
	OPEN Journal_Cursor
    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    while @@fetch_status = 0
    begin	
		--插入辅助信息DTO
		if @AuxiliaryItems is not null or @idUnit is not null
		begin
			select @idauxAccCustomer=id from UFTData305193_300004.dbo.AA_Partner where [name]=@AuxiliaryItems
			insert into UFTData305193_300004.[dbo].[GL_AuxiliaryInfo](exchangerate,idauxAccCustomer,DocId,idEntryDTO)
			values(1.0,@idauxAccCustomer,@idDocDTO,@id)
			select @auxiliaryinfoid=@@identity
		end
		
		set @direction=652  --借方
		if @amountcr is not null
			set @direction=653  --贷方
		if not exists(select 1 from UFTData305193_300004.dbo.[GL_Journal] where docid=@idDocDTO and entryid=@id)
		begin
			insert into UFTData305193_300004.[dbo].[GL_Journal](docno, rowno, summary, maker, exchangerate, price
			,iscarriedforwardout, iscarriedforwardin, sequencenumber, ispost, [year], currentperiod, quantityDr
			,amountDr, amountCr, origAmountDr, OrigAmountCr, isPeriodBegin,DocDrCrType, idaccount, idcurrency, idDocType
			,idauxAccCustomer,direction, makerId, docid, entryid, auxiliaryinfoid, idaccountingperiod, madedate, idUnit,IdMarketingOrgan)
			values(@docno,@code,@summary,'陈冬梅',1,@price,0,0,@sequencenumber,0,@currentYear,@currentPeriod,@quantitydr,@amountdr,@amountcr,@origamountdr,@origamountcr
			,0,22,@idaccount,4,8,@idauxAccCustomer,@direction,23,@idDocDTO,@id,@auxiliaryinfoid,@idaccountingperiod,@voucherdate,@idUnit,1)

		end
	    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    end
    CLOSE Journal_Cursor
    DEALLOCATE Journal_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[cg_InsertVoucherJournal_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-03-02
-- Description:	从分录表获取数据，插入凭证明细表
-- =============================================
CREATE PROCEDURE [dbo].[cg_InsertVoucherJournal_hs] 
(
@idDocDTO int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @code nvarchar(30),@summary nvarchar(max),@origamountdr decimal(28,14),@origamountcr decimal(28,14),@amountdr decimal(28,14),@amountcr decimal(28,14)
		,@quantitydr decimal(28,14),@price decimal(28,14),@sequencenumber int,@AuxiliaryItems nvarchar(500),@idaccount int,@id int,@idUnit int
	declare @docno varchar(30),@currentYear int,@currentPeriod int,@idauxAccCustomer int,@idaccountingperiod int,@auxiliaryinfoid int,@direction int,@voucherdate DateTime

	select @docno=code,@currentYear=accountingyear,@currentPeriod=accountingperiod,@voucherdate=voucherdate from UFTData585087_300003.dbo.GL_Doc where id=@idDocDTO
	select @idaccountingperiod=id FROM UFTData585087_300003.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod --会计期间ID
	
	--删除所有
	delete from UFTData585087_300003.dbo.GL_AuxiliaryInfo where DocId=@idDocDTO
	delete from UFTData585087_300003.dbo.GL_Journal where DocId=@idDocDTO
	
	DECLARE Journal_Cursor CURSOR FOR select id,code,summary,origamountdr,origamountcr,amountdr,amountcr,quantitydr,price,sequencenumber,AuxiliaryItems,idaccount,idUnit 
	from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO order by sequencenumber
	OPEN Journal_Cursor
    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    while @@fetch_status = 0
    begin	
		--插入辅助信息DTO
		if @AuxiliaryItems is not null or @idUnit is not null
		begin
			select @idauxAccCustomer=id from UFTData585087_300003.dbo.AA_Partner where [name]=@AuxiliaryItems
			insert into UFTData585087_300003.[dbo].[GL_AuxiliaryInfo](exchangerate,idauxAccCustomer,DocId,idEntryDTO)
			values(1.0,@idauxAccCustomer,@idDocDTO,@id)
			select @auxiliaryinfoid=@@identity
		end

		set @direction=652  --借方
		if @amountcr is not null
			set @direction=653  --贷方
		if not exists(select 1 from UFTData585087_300003.dbo.[GL_Journal] where docid=@idDocDTO and entryid=@id)
		begin
			insert into UFTData585087_300003.[dbo].[GL_Journal](docno, rowno, summary, maker, exchangerate, price
			,iscarriedforwardout, iscarriedforwardin, sequencenumber, ispost, [year], currentperiod, quantityDr
			,amountDr, amountCr, origAmountDr, OrigAmountCr, isPeriodBegin,DocDrCrType, idaccount, idcurrency, idDocType
			,idauxAccCustomer,direction, makerId, docid, entryid, auxiliaryinfoid, idaccountingperiod, madedate, idUnit,IdMarketingOrgan)
			values(@docno,@code,@summary,'马情情',1,@price,0,0,@sequencenumber,0,@currentYear,@currentPeriod,@quantitydr,@amountdr,@amountcr,@origamountdr,@origamountcr
			,0,22,@idaccount,4,8,@idauxAccCustomer,@direction,88,@idDocDTO,@id,@auxiliaryinfoid,@idaccountingperiod,@voucherdate,@idUnit,1)

		end
	    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    end
    CLOSE Journal_Cursor
    DEALLOCATE Journal_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wj_Invoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	当月开票凭证-五金胶电
-- =============================================
CREATE PROCEDURE [dbo].[cg_wj_Invoiced] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：购进一体式电磁流量计8台，南宁普时，00475221
	DECLARE @supplier nvarchar(100),@goodsname nvarchar(100),@kphm nvarchar(max),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@nCount int,@idDocDTO int,@summoney numeric(18,2),@money_zk numeric(18,2),@money_weixiu numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int

	DECLARE customer_Cursor CURSOR FOR select supplier,kphm from purchase_invoiced 
	where writeoffState=0 and abs([money])>0 and options<>'折扣' and year(indate)=year(jsrq) and month(indate)=month(jsrq)
	and (warehouse='五金仓' or options='维修') and dbo.Getcg_partner(supplier,'广西华纳')<>'零星采购' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod
	and dw='广西华纳新材料股份有限公司'
	group by supplier,kphm order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster @supplier,0,@currentYear,@currentPeriod,'当月开票',@idDocDTO output
		--set @idDocDTO=93140
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO	
			--获取第一个货品名称
			select Top 1 @goodsname=goodsname from purchase_invoiced where kphm=@kphm
			select @nCount=count(*) from(select goodsname from purchase_invoiced where kphm=@kphm group by goodsname) t1
			if @nCount>1
			begin
				set @goodsname=@goodsname+'等'
			end
			set @row_summary='购进'+@goodsname+'，' +@supplier+' ' +@kphm
			
			set @sequencenumber=1
			set @code='0000'
			
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=SUM(money_notax) from purchase_invoiced where kphm=@kphm and options not in('折扣','维修')
			if abs(@money_notax)>0
			begin
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--折扣返利
			set @money_zk=0
			select @money_zk=sum(money_notax) from purchase_invoiced where money_notax<0 and kphm=@kphm  and options='折扣'
			if abs(@money_zk)>0
			begin
				set @zk_summary='购进'+@goodsname+'现金折扣，' +@supplier+' ' +@kphm

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--制造费用-维修费用，5101007
			set @money_weixiu=0
			select @money_weixiu=sum(money_notax) from purchase_invoiced where kphm=@kphm and options='维修'
			if @money_weixiu>0
			begin
				select Top 1 @goodsname=goodsname from purchase_invoiced where kphm=@kphm and options='维修'
				set @zk_summary=@goodsname+'，' +@supplier+' ' +@kphm
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
			end
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from purchase_invoiced where kphm=@kphm
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			select @money=SUM(money) from purchase_invoiced where kphm=@kphm		
			--应付账款-应付账款
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and kphm=@kphm 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from purchase_invoiced where kphm=@kphm)
		end
	    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wj_Invoiced_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	当月开票凭证-五金胶电
-- =============================================
CREATE PROCEDURE [dbo].[cg_wj_Invoiced_ah] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：购进一体式电磁流量计8台，南宁普时，00475221
	DECLARE @supplier nvarchar(100),@goodsname nvarchar(100),@kphm nvarchar(max),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@nCount int,@idDocDTO int,@summoney numeric(18,2),@money_zk numeric(18,2),@money_weixiu numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int

	DECLARE customer_Cursor CURSOR FOR select supplier,kphm from purchase_invoiced 
	where writeoffState=0 and abs([money])>0 and options<>'折扣' and year(indate)=year(jsrq) and month(indate)=month(jsrq)
	and (warehouse='五金仓' or options='维修') and dbo.Getcg_partner(supplier,'安徽')<>'零星采购' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod
	and dw='安徽省宣城市华纳新材料科技有限公司'
	group by supplier,kphm order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_ah @supplier,0,@currentYear,@currentPeriod,'当月开票',@idDocDTO output
		--set @idDocDTO=93140
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO	
			--获取第一个货品名称
			select Top 1 @goodsname=goodsname from purchase_invoiced where kphm=@kphm
			select @nCount=count(*) from(select goodsname from purchase_invoiced where kphm=@kphm group by goodsname) t1
			if @nCount>1
			begin
				set @goodsname=@goodsname+'等'
			end
			set @row_summary='购进'+@goodsname+'，' +@supplier+' ' +@kphm
			
			set @sequencenumber=1
			set @code='0000'
			
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=SUM(money_notax) from purchase_invoiced where kphm=@kphm and options not in('折扣','维修')
			if abs(@money_notax)>0
			begin
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear

				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--折扣返利
			set @money_zk=0
			select @money_zk=sum(money_notax) from purchase_invoiced where money_notax<0 and kphm=@kphm  and options='折扣'
			if abs(@money_zk)>0
			begin
				set @zk_summary='购进'+@goodsname+'现金折扣，' +@supplier+' ' +@kphm

				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--制造费用-维修费用，5101007
			set @money_weixiu=0
			select @money_weixiu=sum(money_notax) from purchase_invoiced where kphm=@kphm and options='维修'
			if @money_weixiu>0
			begin
				select Top 1 @goodsname=goodsname from purchase_invoiced where kphm=@kphm and options='维修'
				set @zk_summary=@goodsname+'，' +@supplier+' ' +@kphm
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
			
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
			end
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from purchase_invoiced where kphm=@kphm
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			select @money=SUM(money) from purchase_invoiced where kphm=@kphm		
			--应付账款-应付账款
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_ah @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and kphm=@kphm 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from purchase_invoiced where kphm=@kphm)
		end
	    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wj_Invoiced_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	当月开票凭证-五金胶电
-- =============================================
CREATE PROCEDURE [dbo].[cg_wj_Invoiced_hs] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：购进一体式电磁流量计8台，南宁普时，00475221
	DECLARE @supplier nvarchar(100),@goodsname nvarchar(100),@kphm nvarchar(max),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@nCount int,@idDocDTO int,@summoney numeric(18,2),@money_zk numeric(18,2),@money_weixiu numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int

	DECLARE customer_Cursor CURSOR FOR select supplier,kphm from purchase_invoiced 
	where writeoffState=0 and abs([money])>0 and options<>'折扣' and year(indate)=year(jsrq) and month(indate)=month(jsrq)
	and (warehouse='五金仓' or options='维修') and dbo.Getcg_partner(supplier,'合山')<>'个体工商户' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod
	and dw='广西合山市华纳新材料科技有限公司'
	group by supplier,kphm order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_hs @supplier,0,@currentYear,@currentPeriod,'当月开票',@idDocDTO output
		--set @idDocDTO=93140
		if @idDocDTO>0
		begin
			--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO	
			--获取第一个货品名称
			select Top 1 @goodsname=goodsname from purchase_invoiced where kphm=@kphm
			select @nCount=count(*) from(select goodsname from purchase_invoiced where kphm=@kphm group by goodsname) t1
			if @nCount>1
			begin
				set @goodsname=@goodsname+'等'
			end
			set @row_summary='购进'+@goodsname+'，' +@supplier+' ' +@kphm
			
			set @sequencenumber=1
			set @code='0000'
			
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=SUM(money_notax) from purchase_invoiced where kphm=@kphm and options not in('折扣','维修')
			if abs(@money_notax)>0
			begin
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear

				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--折扣返利
			set @money_zk=0
			select @money_zk=sum(money_notax) from purchase_invoiced where money_notax<0 and kphm=@kphm  and options='折扣'
			if abs(@money_zk)>0
			begin
				set @zk_summary='购进'+@goodsname+'现金折扣，' +@supplier+' ' +@kphm

				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--制造费用-维修费用，5101007
			set @money_weixiu=0
			select @money_weixiu=sum(money_notax) from purchase_invoiced where kphm=@kphm and options='维修'
			if @money_weixiu>0
			begin
				select Top 1 @goodsname=goodsname from purchase_invoiced where kphm=@kphm and options='维修'
				set @zk_summary=@goodsname+'，' +@supplier+' ' +@kphm
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
			
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
			end
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from purchase_invoiced where kphm=@kphm
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			select @money=SUM(money) from purchase_invoiced where kphm=@kphm		
			--应付账款-应付账款
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_hs @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and kphm=@kphm 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from purchase_invoiced where kphm=@kphm)
		end
	    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wj_Notinvoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-3-1
-- Description:	未开票凭证（五金胶电）
-- =============================================
CREATE PROCEDURE [dbo].[cg_wj_Notinvoiced] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要为XX月未开票XXX产品XX吨客户名称,借方不含税，贷方=单价/1.13*数量
	DECLARE @supplier nvarchar(100),@goodsname nvarchar(100),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@nCount int,@idDocDTO int,@summoney numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int
	
	DECLARE @tb_goods TABLE(id varchar(50),cg_sn varchar(50),supplier varchar(100),indate DateTime,goodsname varchar(100),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2))
		
	insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax)
	select id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax  
	from purchase_in b where writeoffState=0 and abs([money])>0 and warehouse='五金仓' and dbo.Getcg_partner(supplier,'广西华纳')<>'零星采购'
	and year(indate)=@currentYear and month(indate)=@currentPeriod and dw='广西华纳新材料股份有限公司'
	order by supplier,cg_sn
	
	DECLARE customer_Cursor CURSOR FOR select supplier from @tb_goods 
	group by supplier order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster @supplier,0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			--获取第一个货品名称
			select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier
			select @nCount=count(*) from(select goodsname from @tb_goods where supplier=@supplier group by goodsname) t1
			if @nCount>1
			begin
				set @goodsname=@goodsname+'等'
			end
			set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'，' +@supplier
			
			--获取冲红退货单
			insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax)
			select '-1',cg_sn,supplier,thdate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax 
			from purchase_th where writeoffState=0 and warehouse='五金仓' and supplier=@supplier and YEAR(thdate)=@currentYear and MONTH(thdate)=@currentPeriod 
			and dw='广西华纳新材料股份有限公司'
			
			set @sequencenumber=1
			set @code='0000'
			--原材料-五金胶电
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear

			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where ([money]>0 or id=-1)and supplier=@supplier
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--优惠金额
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where id>0 and [money]<0 and supplier=@supplier
			if abs(@money_notax)>0
			begin
				set @zk_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'（优惠金额），' +@supplier
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			end
			
			--应付账款-暂估进项税
			set @money_tax=0
			select @money_tax=sum(money_tax) from @tb_goods where supplier=@supplier
			if abs(@money_tax)>0
			begin
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202003' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)
			end
			
			set @money=0
			select @money=sum(money) from @tb_goods where supplier=@supplier
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
			--应付账款-暂估应付款
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear
				
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where id in(select id from @tb_goods where supplier=@supplier)
		end

	    FETCH NEXT FROM customer_Cursor INTO @supplier
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[cg_wj_Notinvoiced_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-3-1
-- Description:	未开票凭证（五金胶电）
-- =============================================
CREATE PROCEDURE [dbo].[cg_wj_Notinvoiced_ah] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要为XX月未开票XXX产品XX吨客户名称,借方不含税，贷方=单价/1.13*数量
	DECLARE @supplier nvarchar(100),@goodsname nvarchar(100),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@nCount int,@idDocDTO int,@summoney numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int
	
	DECLARE @tb_goods TABLE(id varchar(50),cg_sn varchar(50),supplier varchar(100),indate DateTime,goodsname varchar(100),goodsunit varchar(50)
		,amount numeric(18,5),price numeric(18,5),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2))
		
	insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax)
	select id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax  
	from purchase_in b where writeoffState=0 and abs([money])>0 and warehouse='五金仓' and dbo.Getcg_partner(supplier,'安徽')<>'零星采购'
	and year(indate)=@currentYear and month(indate)=@currentPeriod and dw='安徽省宣城市华纳新材料科技有限公司'
	order by supplier,cg_sn
	
	DECLARE customer_Cursor CURSOR FOR select supplier from @tb_goods 
	group by supplier order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_ah @supplier,0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			--获取第一个货品名称
			select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier
			select @nCount=count(*) from(select goodsname from @tb_goods where supplier=@supplier group by goodsname) t1
			if @nCount>1
			begin
				set @goodsname=@goodsname+'等'
			end
			set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'，' +@supplier
			
			--获取冲红退货单
			insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax)
			select '-1',cg_sn,supplier,thdate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax 
			from purchase_th where writeoffState=0 and warehouse='五金仓' and supplier=@supplier and YEAR(thdate)=@currentYear and MONTH(thdate)=@currentPeriod 
			and dw='安徽省宣城市华纳新材料科技有限公司'
			
			set @sequencenumber=1
			set @code='0000'
			--原材料-五金胶电
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear

			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where ([money]>0 or id=-1) and supplier=@supplier

			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--优惠金额
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where id>0 and [money]<0 and supplier=@supplier
			if abs(@money_notax)>0
			begin
				set @zk_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'（优惠金额），' +@supplier
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			end
			
			--应付账款-暂估进项税
			set @money_tax=0
			select @money_tax=sum(money_tax) from @tb_goods where supplier=@supplier
			if abs(@money_tax)>0
			begin
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202003' and accountingyear=@currentYear
			
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)
			end
			
			set @money=0
			select @money=sum(money) from @tb_goods where supplier=@supplier
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
			--应付账款-暂估应付款
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear
				
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_ah @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where id in(select id from @tb_goods where supplier=@supplier)
			update purchase_th set writeoffState=1 where writeoffState=0 and supplier=@supplier and YEAR(thdate)=@currentYear and MONTH(thdate)=@currentPeriod 
			and dw='安徽省宣城市华纳新材料科技有限公司'
		end

	    FETCH NEXT FROM customer_Cursor INTO @supplier
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[cg_wj_Notinvoiced_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-3-1
-- Description:	未开票凭证（五金胶电）
-- =============================================
CREATE PROCEDURE [dbo].[cg_wj_Notinvoiced_hs] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要为XX月未开票XXX产品XX吨客户名称,借方不含税，贷方=单价/1.13*数量
	DECLARE @supplier nvarchar(100),@goodsname nvarchar(100),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@nCount int,@idDocDTO int,@summoney numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int
	
	DECLARE @tb_goods TABLE(id varchar(50),cg_sn varchar(50),supplier varchar(100),indate DateTime,goodsname varchar(100),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2))
		
	insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax)
	select id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax  
	from purchase_in b where writeoffState=0 and abs([money])>0 and warehouse='五金仓' and dbo.Getcg_partner(supplier,'合山')<>'个体工商户'
	and year(indate)=@currentYear and month(indate)=@currentPeriod and dw='广西合山市华纳新材料科技有限公司'
	order by supplier,cg_sn
	
	DECLARE customer_Cursor CURSOR FOR select supplier from @tb_goods 
	group by supplier order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_hs @supplier,0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			--获取第一个货品名称
			select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier
			select @nCount=count(*) from(select goodsname from @tb_goods where supplier=@supplier group by goodsname) t1
			if @nCount>1
			begin
				set @goodsname=@goodsname+'等'
			end
			set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'，' +@supplier
			
			--获取冲红退货单
			insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax)
			select '-1',cg_sn,supplier,thdate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax 
			from purchase_th where writeoffState=0 and warehouse='五金仓' and supplier=@supplier and YEAR(thdate)=@currentYear and MONTH(thdate)=@currentPeriod 
			and dw='广西合山市华纳新材料科技有限公司'
			
			set @sequencenumber=1
			set @code='0000'
			--原材料-五金胶电
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear

			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where [money]>0 and supplier=@supplier

			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--优惠金额
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where id>0 and [money]<0 and supplier=@supplier
			if abs(@money_notax)>0
			begin
				set @zk_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'（优惠金额），' +@supplier
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			end
			
			--应付账款-暂估进项税
			set @money_tax=0
			select @money_tax=sum(money_tax) from @tb_goods where supplier=@supplier
			if abs(@money_tax)>0
			begin
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202003' and accountingyear=@currentYear
			
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)
			end
			
			set @money=0
			select @money=sum(money) from @tb_goods where supplier=@supplier
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
			--应付账款-暂估应付款
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear
				
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_hs @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where id in(select id from @tb_goods where supplier=@supplier)
			update purchase_th set writeoffState=1 where writeoffState=0 and supplier=@supplier and YEAR(thdate)=@currentYear and MONTH(thdate)=@currentPeriod 
			and dw='广西合山市华纳新材料科技有限公司'
		end

	    FETCH NEXT FROM customer_Cursor INTO @supplier
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[cg_wj_WriteOffNotinvoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-五金胶电
-- =============================================
CREATE PROCEDURE [dbo].[cg_wj_WriteOffNotinvoiced] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年10月31日转字-000273号凭证]对讲机等暂估入账，南宁鑫睿嘉商贸
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100)
		,@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int,@cxYear int,@cxMonth int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@accountcode varchar(100),@money_weixiu numeric(18,2),@partner nvarchar(100),@shortname nvarchar(200)
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE customer_Cursor CURSOR FOR select id,supplier,cg_sn,indate,goodsname,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and abs(money)>0 and convert(int,(DATENAME(year,jsrq)+DATENAME(month,jsrq)))>convert(int,(DATENAME(year,indate)+DATENAME(month,indate)))
	and (warehouse='五金仓' or options='维修') and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='广西华纳新材料股份有限公司'
	--and supplier like'%广西双佳田气体有限公司%'
	order by supplier,kphm,cg_sn
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select @partner=dbo.Getcg_partner(@supplier,'广西华纳')
		select @voucher_id=dbo.Getcg_voucherid(@supplier,@partner,@indate,'广西华纳')
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@cg_sn,@supplier,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
    DECLARE tbgoods_Cursor CURSOR FOR select supplier,kphm from @tb_goods 
    group by supplier,kphm order by supplier
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @supplier,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster @supplier,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=101279
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			select @partner=dbo.Getcg_partner(@supplier,'广西华纳')
			set @goodsname=''
			
			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where supplier=@supplier and kphm=@kphm 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				--获取要冲红的之前凭证		
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,a.code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,AuxiliaryItems,idaccount,idcurrency,b.accountingyear,b.accountingperiod 
				from UFTData328464_300011.dbo.GL_Entry a inner join UFTData328464_300011.dbo.GL_Doc b on b.id=a.idDocDTO 
				where idDocDTO=@voucher_id and idaccount in(select id from UFTData328464_300011.dbo.AA_Account where code in('1403005','5101007','1601004','2202002','2202003') and accountingyear=b.accountingyear)
				order by idDocDTO,a.code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@AuxiliaryItems,@Entryidaccount,@idcurrency,@cxYear,@cxMonth
				while @@fetch_status = 0
				begin
					select @Entrysummary=replace(@Entrysummary,' ','，')
					select @Entrysummary=replace(@Entrysummary,'暂估入库','暂估入账')
					if @sequencenumber=1
					begin
						select @goodsname=replace(RetVal,'暂估入账','') from dbo.tbSplit(@Entrysummary,'，') where RetSeq=1					
						select @goodsname=SUBSTRING(@goodsname,CHARINDEX('月',@goodsname)+1,200)
					end
					select @shortname=RetVal from dbo.tbSplit(@Entrysummary,'，') where RetSeq=2
					if @shortname='零星采购' set @shortname=@supplier
					
					select @doccode=code,@voucherdate=voucherdate from UFTData328464_300011.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转字-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @accountcode=code from UFTData328464_300011.dbo.AA_Account where id=@Entryidaccount
					select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where accountingyear=@currentYear and code=@accountcode
					
					if exists(select 1 from purchase_invoiced where kphm=@kphm and supplier like+'%'+@shortname+'%')
					begin
						if @accountcode='1403005' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_notax) from purchase_invoiced where kphm=@kphm and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth
						end
						else if @accountcode='5101007' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_notax) from purchase_invoiced where kphm=@kphm and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth and options='维修'
						end
						else if @accountcode='2202003' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_tax) from purchase_invoiced where kphm=@kphm and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth
						end
						else if @accountcode='2202002' and @origamountcr<0
						begin
							select @origamountcr=SUM(-money) from purchase_invoiced where kphm=@kphm and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth
						end
						set @amountdr=@origamountdr
						set @amountcr=@origamountcr

						insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
						values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,null,null,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,null)
						--print @row_summary +cast(isnull(@origamountdr,'0') as varchar(20))+','+@code
						set @sequencenumber=@sequencenumber+1
						set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					end
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@AuxiliaryItems,@Entryidaccount,@idcurrency,@cxYear,@cxMonth
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options)
			select '0',id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options 
			from purchase_invoiced b where kphm=@kphm and id not in(select id from @tb_goods where kphm=@kphm)
			
			set @row_summary='购进'+@goodsname+'，' +@supplier+' ' +@kphm
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where kphm=@kphm and options not in('折扣','维修')
			if abs(@money_notax)>0
			begin
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary +'，'+cast(@money_notax as varchar(20))+','+@code
			end
			
			--折扣返利
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where [money]<0 and kphm=@kphm and options='折扣'
			if abs(@money_notax)>0
			begin
				set @zk_summary='购进'+@goodsname+'现金折扣，' +@supplier+' ' +@kphm
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			end
			
			--制造费用-维修费用，5101007
			set @money_weixiu=0
			select @money_weixiu=sum(money_notax) from purchase_invoiced where kphm=@kphm and options='维修'
			if @money_weixiu>0
			begin
				select Top 1 @goodsname=goodsname from purchase_invoiced where kphm=@kphm and options='维修'
				set @zk_summary=@goodsname+'，' +@supplier+' ' +@kphm
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
			end
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=sum(money_tax) from @tb_goods where kphm=@kphm
			if @money_tax>0
			begin
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary +'，'+cast(@money_tax as varchar(20))+','+@code
			end
			
			set @money=0
			select @money=sum(money) from @tb_goods where kphm=@kphm
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
			--应付账款-应付账款
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,@partner,@idaccount,4,@idDocDTO,null)
			--print @row_summary +'，'+cast(@money as varchar(20))+','+@code

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and cg_sn in(select cg_sn from @tb_goods where kphm=@kphm)
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where kphm=@kphm)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @supplier,@kphm
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wj_WriteOffNotinvoiced_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-五金胶电
-- =============================================
CREATE PROCEDURE [dbo].[cg_wj_WriteOffNotinvoiced_ah] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年10月31日转字-000273号凭证]对讲机等暂估入账，南宁鑫睿嘉商贸
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100)
		,@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int,@cxYear int,@cxMonth int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@accountcode varchar(100),@money_weixiu numeric(18,2),@partner nvarchar(100),@shortname nvarchar(200)
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE customer_Cursor CURSOR FOR select id,supplier,cg_sn,indate,goodsname,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and abs(money)>0 and convert(int,(DATENAME(year,jsrq)+DATENAME(month,jsrq)))>convert(int,(DATENAME(year,indate)+DATENAME(month,indate)))
	and (warehouse='五金仓' or options='维修') and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='安徽省宣城市华纳新材料科技有限公司'
	--and supplier like'%广西骏博利机电设备有限公司%'
	order by supplier,kphm,cg_sn
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select @partner=dbo.Getcg_partner(@supplier,'安徽')
		select @voucher_id=dbo.Getcg_voucherid(@supplier,@partner,@indate,'安徽')
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@cg_sn,@supplier,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
	DECLARE tbgoods_Cursor CURSOR FOR select supplier,kphm from @tb_goods 
	group by supplier,kphm order by supplier
	OPEN tbgoods_Cursor
	FETCH NEXT FROM tbgoods_Cursor INTO @supplier,@kphm
	while @@fetch_status = 0
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_ah @supplier,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=101279
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			select @partner=dbo.Getcg_partner(@supplier,'安徽')
			set @goodsname=''
			
			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where supplier=@supplier and kphm=@kphm 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				--获取要冲红的之前凭证		
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,a.code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,AuxiliaryItems,idaccount,idcurrency,b.accountingyear,b.accountingperiod 
				from UFTData305193_300004.dbo.GL_Entry a inner join UFTData305193_300004.dbo.GL_Doc b on b.id=a.idDocDTO 
				where idDocDTO=@voucher_id and idaccount in(select id from UFTData305193_300004.dbo.AA_Account where code in('1403005','5101007','1601004','2202002','2202003') and accountingyear=b.accountingyear)
				order by idDocDTO,a.code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@AuxiliaryItems,@Entryidaccount,@idcurrency,@cxYear,@cxMonth
				while @@fetch_status = 0
				begin
					--1601004,固定资产-电子设备及其他
					select @Entrysummary=replace(@Entrysummary,' ','，')
					select @Entrysummary=replace(@Entrysummary,'暂估入库','暂估入账')
					if @sequencenumber=1
					begin
						select @goodsname=replace(RetVal,'暂估入账','') from dbo.tbSplit(@Entrysummary,'，') where RetSeq=1					
						select @goodsname=SUBSTRING(@goodsname,CHARINDEX('月',@goodsname)+1,200)
					end
					select @shortname=RetVal from dbo.tbSplit(@Entrysummary,'，') where RetSeq=2
					if @shortname='零星采购' set @shortname=@supplier
				
					select @doccode=code,@voucherdate=voucherdate from UFTData305193_300004.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转字2-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @accountcode=code from UFTData305193_300004.dbo.AA_Account where id=@Entryidaccount
					select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where accountingyear=@currentYear and code=@accountcode

					if exists(select 1 from purchase_invoiced where kphm=@kphm and supplier like+'%'+@shortname+'%')
					begin
						if @accountcode='1403005' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_notax) from purchase_invoiced where kphm=@kphm and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth
						end
						else if @accountcode='5101007' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_notax) from purchase_invoiced where kphm=@kphm and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth and options='维修'
						end
						else if @accountcode='2202003' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_tax) from purchase_invoiced where kphm=@kphm and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth
						end
						else if @accountcode='2202002' and @origamountcr<0
						begin
							select @origamountcr=SUM(-money) from purchase_invoiced where kphm=@kphm and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth
						end
						set @amountdr=@origamountdr
						set @amountcr=@origamountcr

						insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
						values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,null,null,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,null)
						--print @row_summary +cast(isnull(@origamountdr,'0') as varchar(20))+','+@code
						set @sequencenumber=@sequencenumber+1
						set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					end
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@AuxiliaryItems,@Entryidaccount,@idcurrency,@cxYear,@cxMonth
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options)
			select '0',id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options 
			from purchase_invoiced b where kphm=@kphm and id not in(select id from @tb_goods where kphm=@kphm)
			
			set @row_summary='购进'+@goodsname+'，' +@supplier+' ' +@kphm
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where kphm=@kphm and options not in('折扣','维修')
			if abs(@money_notax)>0
			begin
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
				
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary +'，'+cast(@money_notax as varchar(20))+','+@code
			end
			
			--折扣返利
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where [money]<0 and kphm=@kphm  and options='折扣'
			if abs(@money_notax)>0
			begin
				set @zk_summary='购进'+@goodsname+'现金折扣，' +@supplier+' ' +@kphm
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			end
			
			--制造费用-维修费用，5101007
			set @money_weixiu=0
			select @money_weixiu=sum(money_notax) from purchase_invoiced where kphm=@kphm and options='维修'
			if @money_weixiu>0
			begin
				select Top 1 @goodsname=goodsname from purchase_invoiced where kphm=@kphm and options='维修'
				set @zk_summary=@goodsname+'，' +@supplier+' ' +@kphm
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
			
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
			end
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=sum(money_tax) from @tb_goods where kphm=@kphm
			if @money_tax>0
			begin
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary +'，'+cast(@money_tax as varchar(20))+','+@code
			end
			
			set @money=0
			select @money=sum(money) from @tb_goods where kphm=@kphm
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
			--应付账款-应付账款
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,@partner,@idaccount,4,@idDocDTO,null)
			--print @row_summary +'，'+cast(@money as varchar(20))+','+@code

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_ah @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and cg_sn in(select cg_sn from @tb_goods where kphm=@kphm)
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where kphm=@kphm)
		end
		FETCH NEXT FROM tbgoods_Cursor INTO @supplier,@kphm
	end
	CLOSE tbgoods_Cursor
	DEALLOCATE tbgoods_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wj_WriteOffNotinvoiced_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-五金胶电
-- =============================================
CREATE PROCEDURE [dbo].[cg_wj_WriteOffNotinvoiced_hs] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年10月31日转字-000273号凭证]对讲机等暂估入账，南宁鑫睿嘉商贸
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100)
		,@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int,@cxYear int,@cxMonth int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@accountcode varchar(100),@money_weixiu numeric(18,2),@partner nvarchar(100),@shortname nvarchar(200)
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))

	DECLARE customer_Cursor CURSOR FOR select id,supplier,cg_sn,indate,goodsname,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and abs(money)>0 and convert(int,(DATENAME(year,jsrq)+DATENAME(month,jsrq)))>convert(int,(DATENAME(year,indate)+DATENAME(month,indate)))
	and (warehouse='五金仓' or options='维修') and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='广西合山市华纳新材料科技有限公司'
	--and supplier like'%桂林灵川县森鑫矿山设备制造有限公司%'
	order by supplier,kphm,cg_sn
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select @partner=dbo.Getcg_partner(@supplier,'合山')
		select @voucher_id=dbo.Getcg_voucherid(@supplier,@partner,@indate,'合山')
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@cg_sn,@supplier,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
	DECLARE tbgoods_Cursor CURSOR FOR select supplier,kphm from @tb_goods 
	group by supplier,kphm order by supplier
	OPEN tbgoods_Cursor
	FETCH NEXT FROM tbgoods_Cursor INTO @supplier,@kphm
	while @@fetch_status = 0
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_hs @supplier,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=18824
		if @idDocDTO>0
		begin
			--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			select @partner=dbo.Getcg_partner(@supplier,'合山')
			set @goodsname=''
			
			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where supplier=@supplier and kphm=@kphm 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				--获取要冲红的之前凭证		
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,a.code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,AuxiliaryItems,idaccount,idcurrency,b.accountingyear,b.accountingperiod 
				from UFTData585087_300003.dbo.GL_Entry a inner join UFTData585087_300003.dbo.GL_Doc b on b.id=a.idDocDTO 
				where idDocDTO=@voucher_id and idaccount in(select id from UFTData585087_300003.dbo.AA_Account where code in('1403005','5101007','1601004','2202002','2202003') and accountingyear=b.accountingyear)
				order by idDocDTO,a.code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@AuxiliaryItems,@Entryidaccount,@idcurrency,@cxYear,@cxMonth
				while @@fetch_status = 0
				begin
					select @Entrysummary=replace(@Entrysummary,' ','，')
					select @Entrysummary=replace(@Entrysummary,'暂估入库','暂估入账')
					if @sequencenumber=1
					begin
						select @goodsname=replace(RetVal,'暂估入账','') from dbo.tbSplit(@Entrysummary,'，') where RetSeq=1					
						select @goodsname=SUBSTRING(@goodsname,CHARINDEX('月',@goodsname)+1,200)
					end
					select @shortname=RetVal from dbo.tbSplit(@Entrysummary,'，') where RetSeq=2
					if @shortname='零星采购' set @shortname=@supplier
					
					select @doccode=code,@voucherdate=voucherdate from UFTData585087_300003.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转1-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @accountcode=code from UFTData585087_300003.dbo.AA_Account where id=@Entryidaccount
					select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where accountingyear=@currentYear and code=@accountcode
					
					if exists(select 1 from purchase_invoiced where kphm=@kphm and supplier like+'%'+@shortname+'%')
					begin
						if @accountcode='1403005' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_notax) from purchase_invoiced where kphm=@kphm and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth
						end
						else if @accountcode='5101007' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_notax) from purchase_invoiced where kphm=@kphm and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth and options='维修'
						end
						else if @accountcode='2202003' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_tax) from purchase_invoiced where kphm=@kphm and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth
						end
						else if @accountcode='2202002' and @origamountcr<0
						begin
							select @origamountcr=SUM(-money) from purchase_invoiced where kphm=@kphm and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth
						end
						set @amountdr=@origamountdr
						set @amountcr=@origamountcr

						insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
						values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,null,null,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,null)
						--print @row_summary +cast(isnull(@origamountdr,'0') as varchar(20))+','+@code
						set @sequencenumber=@sequencenumber+1
						set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					end
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@AuxiliaryItems,@Entryidaccount,@idcurrency,@cxYear,@cxMonth
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options)
			select '0',id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options 
			from purchase_invoiced b where kphm=@kphm and id not in(select id from @tb_goods where kphm=@kphm)
			
			set @row_summary='购进'+@goodsname+'，' +@supplier+' ' +@kphm
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where kphm=@kphm and options not in('折扣','维修')
			if abs(@money_notax)>0
			begin
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
				
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary +'，'+cast(@money_notax as varchar(20))+','+@code
			end
			
			--折扣返利
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where [money]<0 and kphm=@kphm  and options='折扣'
			if abs(@money_notax)>0
			begin
				set @zk_summary='购进'+@goodsname+'现金折扣，' +@supplier+' ' +@kphm
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			end
			
			--制造费用-维修费用，5101007
			set @money_weixiu=0
			select @money_weixiu=sum(money_notax) from purchase_invoiced where kphm=@kphm and options='维修'
			if @money_weixiu>0
			begin
				select Top 1 @goodsname=goodsname from purchase_invoiced where kphm=@kphm and options='维修'
				set @zk_summary=@goodsname+'，' +@supplier+' ' +@kphm
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
			
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
			end
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=sum(money_tax) from @tb_goods where kphm=@kphm
			if @money_tax>0
			begin
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary +'，'+cast(@money_tax as varchar(20))+','+@code
			end
			
			set @money=0
			select @money=sum(money) from @tb_goods where kphm=@kphm
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
			--应付账款-应付账款
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,@partner,@idaccount,4,@idDocDTO,null)
			--print @row_summary +'，'+cast(@money as varchar(20))+','+@code

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_hs @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and cg_sn in(select cg_sn from @tb_goods where kphm=@kphm)
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where kphm=@kphm)
		end
		FETCH NEXT FROM tbgoods_Cursor INTO @supplier,@kphm
	end
	CLOSE tbgoods_Cursor
	DEALLOCATE tbgoods_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wj_WriteOffNotinvoicedTwo]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-五金胶电-多票一凭证
-- =============================================
CREATE PROCEDURE [dbo].[cg_wj_WriteOffNotinvoicedTwo] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年10月31日转字-000273号凭证]对讲机等暂估入账，南宁鑫睿嘉商贸
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100)
		,@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int,@cxYear int,@cxMonth int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@accountcode varchar(100),@money_weixiu numeric(18,2),@partner nvarchar(100),@shortname nvarchar(200)
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))

	DECLARE customer_Cursor CURSOR FOR select id,supplier,cg_sn,indate,goodsname,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and abs(money)>0 and convert(int,(DATENAME(year,jsrq)+DATENAME(month,jsrq)))>convert(int,(DATENAME(year,indate)+DATENAME(month,indate)))
	and (warehouse='五金仓' or options='维修') and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='广西华纳新材料股份有限公司'
	order by supplier,kphm,cg_sn
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select @partner=dbo.Getcg_partner(@supplier,'广西华纳')
		select @voucher_id=dbo.Getcg_voucherid(@supplier,@partner,@indate,'广西华纳')
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@cg_sn,@supplier,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
    if exists(select 1 from (select voucher_id,kphm from @tb_goods group by voucher_id,kphm) as t group by voucher_id having COUNT(*)>1)
    begin
		DECLARE voucherid_Cursor CURSOR FOR select voucher_id
		from (select voucher_id,kphm from @tb_goods group by voucher_id,kphm) as t
		group by voucher_id having COUNT(*)>1
		OPEN voucherid_Cursor
		FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
		while @@fetch_status = 0
		begin
			--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
			exec cg_AddVoucherMaster @supplier,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
			--set @idDocDTO=18824
			if @idDocDTO>0
			begin
				--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
				set @sequencenumber=1
				set @code='0000'
				select Top 1 @supplier=supplier from @tb_goods where voucher_id=@voucher_id
				select @partner=dbo.Getcg_partner(@supplier,'广西华纳')
				set @goodsname=''
				
				--获取要冲红的之前凭证		
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,a.code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,AuxiliaryItems,idaccount,idcurrency,b.accountingyear,b.accountingperiod 
				from UFTData328464_300011.dbo.GL_Entry a inner join UFTData328464_300011.dbo.GL_Doc b on b.id=a.idDocDTO 
				where idDocDTO=@voucher_id and idaccount in(select id from UFTData328464_300011.dbo.AA_Account where code in('1403005','5101007','2202002','2202003') and accountingyear=b.accountingyear)
				order by idDocDTO,a.code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@AuxiliaryItems,@Entryidaccount,@idcurrency,@cxYear,@cxMonth
				while @@fetch_status = 0
				begin
					select @Entrysummary=replace(@Entrysummary,' ','，')
					select @Entrysummary=replace(@Entrysummary,'暂估入库','暂估入账')
					select @shortname=RetVal from dbo.tbSplit(@Entrysummary,'，') where RetSeq=2
					
					select @doccode=code,@voucherdate=voucherdate from UFTData328464_300011.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转字-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @accountcode=code from UFTData328464_300011.dbo.AA_Account where id=@Entryidaccount
					select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where accountingyear=@currentYear and code=@accountcode
					
					if @accountcode='2202003' or @accountcode='2202002' set @shortname=''
					set @kphm=''
					select Top 1 @kphm=kphm from @tb_goods where supplier like+'%'+@shortname+'%'
					if @kphm<>''
					begin
						if @accountcode='1403005' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_notax) from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth
						end
						else if @accountcode='5101007' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_notax) from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth and options='维修'
						end
						else if @accountcode='2202003' and @origamountdr<0
						begin
							select @origamountdr=-2202003.07
						end
						else if @accountcode='2202002' and @origamountcr<0
						begin
							select @origamountcr=-2202002.07
						end
						set @amountdr=@origamountdr
						set @amountcr=@origamountcr

						insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
						values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,null,null,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,null)
						--print @row_summary +cast(isnull(@origamountdr,'0') as varchar(20))+','+@code
						set @sequencenumber=@sequencenumber+1
						set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					end
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@AuxiliaryItems,@Entryidaccount,@idcurrency,@cxYear,@cxMonth
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				set @money_tax=0
				select @money_tax=SUM(-money_tax) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				if abs(@money_tax)>0
					update UFTData328464_300011.dbo.GL_Entry set origamountdr=@money_tax,amountdr=@money_tax where idDocDTO=@idDocDTO and origamountdr=-2202003.07
				set @money=0
				select @money=SUM(-money) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				if abs(@money)>0
					update UFTData328464_300011.dbo.GL_Entry set origamountcr=@money,amountcr=@money where idDocDTO=@idDocDTO and origamountcr=-2202002.07
				
				--同发票号码的写一个凭证，获取同发票号的其它销售记录
				insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options)
				select '0',id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options 
				from purchase_invoiced b where kphm in(select kphm from @tb_goods where voucher_id=@voucher_id) 
				and id not in(select id from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))
				
				set @kphm=''
				DECLARE Goods_Cursor CURSOR FOR select supplier,kphm,(select Top 1 goodsname from @tb_goods where supplier=b.supplier and kphm=b.kphm),sum(money_notax)
				from @tb_goods as b where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options not in('折扣','维修')
				group by supplier,kphm order by supplier
				OPEN Goods_Cursor
				FETCH NEXT FROM Goods_Cursor INTO @supplier,@kphm,@goodsname,@money_notax
				while @@fetch_status = 0
				begin
					set @row_summary='购进'+@goodsname+'，' +@supplier+' ' +@kphm
					--原材料-五金胶电
					if abs(@money_notax)>0
					begin
						select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
					
						insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
						, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
						values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					end
					--print @row_summary+', '+cast(@money_notax as varchar(20))
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					FETCH NEXT FROM Goods_Cursor INTO @supplier,@kphm,@goodsname,@money_notax
				end
				CLOSE Goods_Cursor
				DEALLOCATE Goods_Cursor
				
				select @kphm=stuff((select distinct ','+kphm from @tb_goods where voucher_id=@voucher_id for xml path('')),1,1,'')
				set @row_summary='购进'+@goodsname+'，' +@partner+' ' +@kphm
				
				--折扣返利
				set @money_notax=0
				select @money_notax=sum(money_notax) from @tb_goods where [money]<0 and kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options='折扣'
				if abs(@money_notax)>0
				begin
					set @zk_summary='购进'+@goodsname+'现金折扣，' +@partner+' ' +@kphm
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
					insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@zk_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				end
				
				--制造费用-维修费用，5101007
				set @money_weixiu=0
				select @money_weixiu=sum(money_notax) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options='维修'
				if @money_weixiu>0
				begin
					select Top 1 @goodsname=goodsname from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options='维修'
					set @zk_summary=@goodsname+'，' +@partner+' ' +@kphm
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
				
					insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
				end

				--应交税费-应交增值税-进项税额
				set @money_tax=0
				select @money_tax=sum(money_tax) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				if @money_tax>0
				begin
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
				
					insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				end
				
				set @money=0
				select @money=sum(money) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
						
				--应付账款-应付账款
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
					
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,@partner,@idaccount,4,@idDocDTO,null)

				--更新主表金额
				select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
				update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
				,accuamountcr=@summoney where id=@idDocDTO

				--导入明细表
				exec cg_InsertVoucherJournal @idDocDTO
				
				--反写采购入库
				update purchase_invoiced set writeoffState=1 where writeoffState=0 and cg_sn in(select cg_sn from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))
				update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
				where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))	
			end
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
		end
		CLOSE voucherid_Cursor
		DEALLOCATE voucherid_Cursor
	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wj_WriteOffNotinvoicedTwo_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-五金胶电-多票一凭证
-- =============================================
CREATE PROCEDURE [dbo].[cg_wj_WriteOffNotinvoicedTwo_ah] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年10月31日转字-000273号凭证]对讲机等暂估入账，南宁鑫睿嘉商贸
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100)
		,@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int,@cxYear int,@cxMonth int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@accountcode varchar(100),@money_weixiu numeric(18,2),@partner nvarchar(100),@shortname nvarchar(200)
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))

	DECLARE customer_Cursor CURSOR FOR select id,supplier,cg_sn,indate,goodsname,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and abs(money)>0 and convert(int,(DATENAME(year,jsrq)+DATENAME(month,jsrq)))>convert(int,(DATENAME(year,indate)+DATENAME(month,indate)))
	and (warehouse='五金仓' or options='维修') and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='安徽省宣城市华纳新材料科技有限公司'
	order by supplier,kphm,cg_sn
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select @partner=dbo.Getcg_partner(@supplier,'安徽')
		select @voucher_id=dbo.Getcg_voucherid(@supplier,@partner,@indate,'安徽')
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@cg_sn,@supplier,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
    if exists(select 1 from (select voucher_id,kphm from @tb_goods group by voucher_id,kphm) as t group by voucher_id having COUNT(*)>1)
    begin
		DECLARE voucherid_Cursor CURSOR FOR select voucher_id
		from (select voucher_id,kphm from @tb_goods group by voucher_id,kphm) as t
		group by voucher_id having COUNT(*)>1
		OPEN voucherid_Cursor
		FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
		while @@fetch_status = 0
		begin
			--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
			exec cg_AddVoucherMaster_ah @supplier,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
			--set @idDocDTO=18824
			if @idDocDTO>0
			begin
				--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
				set @sequencenumber=1
				set @code='0000'
				select Top 1 @supplier=supplier from @tb_goods where voucher_id=@voucher_id
				select @partner=dbo.Getcg_partner(@supplier,'安徽')
				set @goodsname=''
				
				--获取要冲红的之前凭证		
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,a.code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,AuxiliaryItems,idaccount,idcurrency,b.accountingyear,b.accountingperiod 
				from UFTData305193_300004.dbo.GL_Entry a inner join UFTData305193_300004.dbo.GL_Doc b on b.id=a.idDocDTO 
				where idDocDTO=@voucher_id and idaccount in(select id from UFTData305193_300004.dbo.AA_Account where code in('1403005','5101007','1601004','2202002','2202003') and accountingyear=b.accountingyear)
				order by idDocDTO,a.code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@AuxiliaryItems,@Entryidaccount,@idcurrency,@cxYear,@cxMonth
				while @@fetch_status = 0
				begin
					select @Entrysummary=replace(@Entrysummary,' ','，')
					select @Entrysummary=replace(@Entrysummary,'暂估入库','暂估入账')
					select @shortname=RetVal from dbo.tbSplit(@Entrysummary,'，') where RetSeq=2
					
					select @doccode=code,@voucherdate=voucherdate from UFTData305193_300004.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转字2-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @accountcode=code from UFTData305193_300004.dbo.AA_Account where id=@Entryidaccount
					select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where accountingyear=@currentYear and code=@accountcode
					
					if @accountcode='2202003' or @accountcode='2202002' set @shortname=''
					set @kphm=''
					select Top 1 @kphm=kphm from @tb_goods where supplier like+'%'+@shortname+'%'
					if @kphm<>''
					begin
						if @accountcode='1403005' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_notax) from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth
						end
						else if @accountcode='5101007' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_notax) from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth and options='维修'
						end
						else if @accountcode='2202003' and @origamountdr<0
						begin
							select @origamountdr=-2202003.07
						end
						else if @accountcode='2202002' and @origamountcr<0
						begin
							select @origamountcr=-2202002.07
						end
						set @amountdr=@origamountdr
						set @amountcr=@origamountcr

						insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
						values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,null,null,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,null)
						--print @row_summary +cast(isnull(@origamountdr,'0') as varchar(20))+','+@code
						set @sequencenumber=@sequencenumber+1
						set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					end
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@AuxiliaryItems,@Entryidaccount,@idcurrency,@cxYear,@cxMonth
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				set @money_tax=0
				select @money_tax=SUM(-money_tax) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				if abs(@money_tax)>0
					update UFTData305193_300004.dbo.GL_Entry set origamountdr=@money_tax,amountdr=@money_tax where idDocDTO=@idDocDTO and origamountdr=-2202003.07
				set @money=0
				select @money=SUM(-money) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				if abs(@money)>0
					update UFTData305193_300004.dbo.GL_Entry set origamountcr=@money,amountcr=@money where idDocDTO=@idDocDTO and origamountcr=-2202002.07
				
				--同发票号码的写一个凭证，获取同发票号的其它销售记录
				insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options)
				select '0',id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options 
				from purchase_invoiced b where kphm in(select kphm from @tb_goods where voucher_id=@voucher_id) 
				and id not in(select id from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))
				
				set @kphm=''
				DECLARE Goods_Cursor CURSOR FOR select supplier,kphm,(select Top 1 goodsname from @tb_goods where supplier=b.supplier and kphm=b.kphm),sum(money_notax)
				from @tb_goods as b where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options not in('折扣','维修')
				group by supplier,kphm order by supplier
				OPEN Goods_Cursor
				FETCH NEXT FROM Goods_Cursor INTO @supplier,@kphm,@goodsname,@money_notax
				while @@fetch_status = 0
				begin
					set @row_summary='购进'+@goodsname+'，' +@supplier+' ' +@kphm
					--原材料-五金胶电
					if abs(@money_notax)>0
					begin
						select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
					
						insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
						, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
						values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					end
					--print @row_summary+', '+cast(@money_notax as varchar(20))+', '+cast(@money_tax as varchar(20))
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					FETCH NEXT FROM Goods_Cursor INTO @supplier,@kphm,@goodsname,@money_notax
				end
				CLOSE Goods_Cursor
				DEALLOCATE Goods_Cursor
				
				select @kphm=stuff((select distinct ','+kphm from @tb_goods where voucher_id=@voucher_id for xml path('')),1,1,'')
				set @row_summary='购进'+@goodsname+'，' +@partner+' ' +@kphm
				
				--折扣返利
				set @money_notax=0
				select @money_notax=sum(money_notax) from @tb_goods where [money]<0 and kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options='折扣'
				if abs(@money_notax)>0
				begin
					set @zk_summary='购进'+@goodsname+'现金折扣，' +@partner+' ' +@kphm
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@zk_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				end
				
				--制造费用-维修费用，5101007
				set @money_weixiu=0
				select @money_weixiu=sum(money_notax) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options='维修'
				if @money_weixiu>0
				begin
					select Top 1 @goodsname=goodsname from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options='维修'
					set @zk_summary=@goodsname+'，' +@partner+' ' +@kphm
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
				
					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
				end

				--应交税费-应交增值税-进项税额
				set @money_tax=0
				select @money_tax=sum(money_tax) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				if @money_tax>0
				begin
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
				
					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				end
				
				set @money=0
				select @money=sum(money) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
						
				--应付账款-应付账款
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
					
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,@partner,@idaccount,4,@idDocDTO,null)

				--更新主表金额
				select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
				update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
				,accuamountcr=@summoney where id=@idDocDTO

				--导入明细表
				exec cg_InsertVoucherJournal_ah @idDocDTO
				
				--反写采购入库
				update purchase_invoiced set writeoffState=1 where writeoffState=0 and cg_sn in(select cg_sn from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))
				update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
				where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))	
			end
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
		end
		CLOSE voucherid_Cursor
		DEALLOCATE voucherid_Cursor
	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wj_WriteOffNotinvoicedTwo_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-五金胶电-多票一凭证
-- =============================================
CREATE PROCEDURE [dbo].[cg_wj_WriteOffNotinvoicedTwo_hs] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年10月31日转字-000273号凭证]对讲机等暂估入账，南宁鑫睿嘉商贸
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100)
		,@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int,@cxYear int,@cxMonth int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@accountcode varchar(100),@money_weixiu numeric(18,2),@partner nvarchar(100),@shortname nvarchar(200)
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))

	DECLARE customer_Cursor CURSOR FOR select id,supplier,cg_sn,indate,goodsname,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and abs(money)>0 and convert(int,(DATENAME(year,jsrq)+DATENAME(month,jsrq)))>convert(int,(DATENAME(year,indate)+DATENAME(month,indate)))
	and (warehouse='五金仓' or options='维修') and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='广西合山市华纳新材料科技有限公司'
	--and supplier like'%桂林灵川县森鑫矿山设备制造有限公司%'
	order by supplier,kphm,cg_sn
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select @partner=dbo.Getcg_partner(@supplier,'合山')
		select @voucher_id=dbo.Getcg_voucherid(@supplier,@partner,@indate,'合山')
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@cg_sn,@supplier,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@money,@money_notax,@money_tax,@kphm,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
    if exists(select 1 from (select voucher_id,kphm from @tb_goods group by voucher_id,kphm) as t group by voucher_id having COUNT(*)>1)
    begin
		DECLARE voucherid_Cursor CURSOR FOR select voucher_id
		from (select voucher_id,kphm from @tb_goods group by voucher_id,kphm) as t
		group by voucher_id having COUNT(*)>1
		OPEN voucherid_Cursor
		FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
		while @@fetch_status = 0
		begin
			--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
			exec cg_AddVoucherMaster_hs @supplier,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
			--set @idDocDTO=18824
			if @idDocDTO>0
			begin
				--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
				set @sequencenumber=1
				set @code='0000'
				select Top 1 @supplier=supplier from @tb_goods where voucher_id=@voucher_id
				select @partner=dbo.Getcg_partner(@supplier,'合山')
				set @goodsname=''
				
				--获取要冲红的之前凭证		
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,a.code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,AuxiliaryItems,idaccount,idcurrency,b.accountingyear,b.accountingperiod 
				from UFTData585087_300003.dbo.GL_Entry a inner join UFTData585087_300003.dbo.GL_Doc b on b.id=a.idDocDTO 
				where idDocDTO=@voucher_id and idaccount in(select id from UFTData585087_300003.dbo.AA_Account where code in('1403005','5101007','1601004','2202002','2202003') and accountingyear=b.accountingyear)
				order by idDocDTO,a.code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@AuxiliaryItems,@Entryidaccount,@idcurrency,@cxYear,@cxMonth
				while @@fetch_status = 0
				begin
					select @Entrysummary=replace(@Entrysummary,' ','，')
					select @Entrysummary=replace(@Entrysummary,'暂估入库','暂估入账')
					select @shortname=RetVal from dbo.tbSplit(@Entrysummary,'，') where RetSeq=2
					
					select @doccode=code,@voucherdate=voucherdate from UFTData585087_300003.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转1-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @accountcode=code from UFTData585087_300003.dbo.AA_Account where id=@Entryidaccount
					select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where accountingyear=@currentYear and code=@accountcode
					
					if @accountcode='2202003' or @accountcode='2202002' set @shortname=''
					set @kphm=''
					select Top 1 @kphm=kphm from @tb_goods where supplier like+'%'+@shortname+'%'
					if @kphm<>''
					begin
						if @accountcode='1403005' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_notax) from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth
						end
						else if @accountcode='5101007' and @origamountdr<0
						begin
							select @origamountdr=SUM(-money_notax) from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and YEAR(indate)=@cxYear and MONTH(indate)=@cxMonth and options='维修'
						end
						else if @accountcode='2202003' and @origamountdr<0
						begin
							select @origamountdr=-2202003.07
						end
						else if @accountcode='2202002' and @origamountcr<0
						begin
							select @origamountcr=-2202002.07
						end
						set @amountdr=@origamountdr
						set @amountcr=@origamountcr

						insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
						values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,null,null,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,null)
						--print @row_summary +cast(isnull(@origamountdr,'0') as varchar(20))+','+@code
						set @sequencenumber=@sequencenumber+1
						set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					end
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@AuxiliaryItems,@Entryidaccount,@idcurrency,@cxYear,@cxMonth
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				set @money_tax=0
				select @money_tax=SUM(-money_tax) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				if abs(@money_tax)>0
					update UFTData585087_300003.dbo.GL_Entry set origamountdr=@money_tax,amountdr=@money_tax where idDocDTO=@idDocDTO and origamountdr=-2202003.07
				set @money=0
				select @money=SUM(-money) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				if abs(@money)>0
					update UFTData585087_300003.dbo.GL_Entry set origamountcr=@money,amountcr=@money where idDocDTO=@idDocDTO and origamountcr=-2202002.07
				
				--同发票号码的写一个凭证，获取同发票号的其它销售记录
				insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options)
				select '0',id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options 
				from purchase_invoiced b where kphm in(select kphm from @tb_goods where voucher_id=@voucher_id) 
				and id not in(select id from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))
				
				set @kphm=''
				DECLARE Goods_Cursor CURSOR FOR select supplier,kphm,(select Top 1 goodsname from @tb_goods where supplier=b.supplier and kphm=b.kphm),sum(money_notax)
				from @tb_goods as b where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options not in('折扣','维修')
				group by supplier,kphm order by supplier
				OPEN Goods_Cursor
				FETCH NEXT FROM Goods_Cursor INTO @supplier,@kphm,@goodsname,@money_notax
				while @@fetch_status = 0
				begin
					set @row_summary='购进'+@goodsname+'，' +@supplier+' ' +@kphm
					--原材料-五金胶电
					if abs(@money_notax)>0
					begin
						select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
					
						insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
						, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
						values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					end
					--print @row_summary+', '+cast(@money_notax as varchar(20))+', '+cast(@money_tax as varchar(20))
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					FETCH NEXT FROM Goods_Cursor INTO @supplier,@kphm,@goodsname,@money_notax
				end
				CLOSE Goods_Cursor
				DEALLOCATE Goods_Cursor
				
				select @kphm=stuff((select distinct ','+kphm from @tb_goods where voucher_id=@voucher_id for xml path('')),1,1,'')
				set @row_summary='购进'+@goodsname+'，' +@partner+' ' +@kphm
				
				--折扣返利
				set @money_notax=0
				select @money_notax=sum(money_notax) from @tb_goods where [money]<0 and kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options='折扣'
				if abs(@money_notax)>0
				begin
					set @zk_summary='购进'+@goodsname+'现金折扣，' +@partner+' ' +@kphm
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@zk_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				end
				
				--制造费用-维修费用，5101007
				set @money_weixiu=0
				select @money_weixiu=sum(money_notax) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options='维修'
				if @money_weixiu>0
				begin
					select Top 1 @goodsname=goodsname from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options='维修'
					set @zk_summary=@goodsname+'，' +@partner+' ' +@kphm
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
				
					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
				end

				--应交税费-应交增值税-进项税额
				set @money_tax=0
				select @money_tax=sum(money_tax) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				if @money_tax>0
				begin
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
				
					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				end
				
				set @money=0
				select @money=sum(money) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
						
				--应付账款-应付账款
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
					
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,@partner,@idaccount,4,@idDocDTO,null)

				--更新主表金额
				select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
				update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
				,accuamountcr=@summoney where id=@idDocDTO

				--导入明细表
				exec cg_InsertVoucherJournal_hs @idDocDTO
				
				--反写采购入库
				update purchase_invoiced set writeoffState=1 where writeoffState=0 and cg_sn in(select cg_sn from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))
				update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
				where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))	
			end
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
		end
		CLOSE voucherid_Cursor
		DEALLOCATE voucherid_Cursor
	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wjlxcg_Invoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	当月开票凭证-五金胶电-零星采购
-- =============================================
CREATE PROCEDURE [dbo].[cg_wjlxcg_Invoiced] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：购进一体式电磁流量计8台，南宁普时，00475221
	DECLARE @id int,@supplier nvarchar(100),@goodsname nvarchar(100),@kphm nvarchar(max),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@foot_summary nvarchar(max),@zk_summary nvarchar(max),@strkphm nvarchar(max),@nCount int,@idDocDTO int,@summoney numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@money_zk numeric(18,12),@money_weixiu numeric(18,2),@partner nvarchar(100)
	
	DECLARE @tb_goods TABLE(id varchar(50),cg_sn varchar(50),supplier varchar(100),indate DateTime,goodsname varchar(50)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm nvarchar(400),options varchar(50),fplx varchar(50))
		
	insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options,fplx)
	select id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options,case when patindex('%专票%',fplx)>0 then '专票' else '普票' end 
	from purchase_invoiced where writeoffState=0 and abs(money)>0 and year(indate)=year(jsrq) and month(indate)=month(jsrq)
	and (warehouse='五金仓' or options='维修') and dbo.Getcg_partner(supplier,'广西华纳')='零星采购' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='广西华纳新材料股份有限公司'

	--普票
	if exists(select 1 from @tb_goods where money_tax=0)
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster '零星采购',0,@currentYear,@currentPeriod,'零星采购开票',@idDocDTO output
		--set @idDocDTO=93149
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @strkphm=''
			set @sequencenumber=1
			set @code='0000'

			select Top 1 @goodsname=goodsname from @tb_goods where money_tax=0
			set @row_summary='购进'+@goodsname+'等，零星采购'
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where money_tax=0 and options not in('维修')
			if abs(@money_notax)>0
			begin
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
		
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary+', '+cast(@money_notax as varchar(20))
					
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
				
			--制造费用-维修费用，5101007
			set @money_weixiu=0
			select @money_weixiu=sum(money_notax) from @tb_goods where money_tax=0 and options='维修'
			if @money_weixiu>0
			begin
				select Top 1 @goodsname=goodsname from @tb_goods where money_tax=0 and options='维修'
				set @zk_summary=@goodsname+'，零星采购'
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
					
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			DECLARE Entry_Cursor CURSOR FOR select supplier,sum(money_notax)
			from @tb_goods where money_tax=0 group by supplier
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @supplier,@money_notax
			while @@fetch_status = 0
			begin
				--获取第一个货品名称
				select Top 1 @goodsname=goodsname from @tb_goods where money_tax=0 and supplier=@supplier
				select @nCount=count(*) from(select goodsname from @tb_goods where money_tax=0 and supplier=@supplier group by goodsname) t1
				if @nCount>1
				begin
					set @goodsname=@goodsname+'等'
				end
				
				--发票号码
				select @kphm=stuff((select distinct ','+kphm from @tb_goods where money_tax=0 and supplier=@supplier for xml path('')),1,1,'')
				select @strkphm=@strkphm+','+@kphm
				
				set @row_summary='购进'+@goodsname+'，'+@supplier+'，零星采购，'+@kphm
				--应付账款-应付账款
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@money_notax,null,@money_notax,null,null,@sequencenumber,'零星采购',@idaccount,4,@idDocDTO,null)

				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary+'，'+cast(@money_notax as varchar(20))
				FETCH NEXT FROM Entry_Cursor INTO @supplier,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and id in(select id from @tb_goods where money_tax=0) 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where money_tax=0)
		end
	end

	if exists(select 1 from @tb_goods where money_tax>0)
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster '零星采购',0,@currentYear,@currentPeriod,'零星采购开票',@idDocDTO output
		--set @idDocDTO=93149
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @strkphm=''
			set @sequencenumber=1
			set @code='0000'

			select Top 1 @goodsname=goodsname from @tb_goods where money_tax>0
			set @row_summary='购进'+@goodsname+'等，零星采购'
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where money_tax>0 and options not in('维修')
			if abs(@money_notax)>0
			begin
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
		
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary+', '+cast(@money_notax as varchar(20))
					
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
				
			--制造费用-维修费用，5101007
			set @money_weixiu=0
			select @money_weixiu=sum(money_notax) from @tb_goods where money_tax>0 and options='维修'
			if @money_weixiu>0
			begin
				select Top 1 @goodsname=goodsname from @tb_goods where money_tax>0 and options='维修'
				set @zk_summary=@goodsname+'，零星采购'
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
					
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end

			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from @tb_goods where money_tax>0
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary+', '+cast(@money_tax as varchar(20))
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end

			DECLARE Entry_Cursor CURSOR FOR select supplier,sum(money_notax)
			from @tb_goods where money_tax>0 group by supplier
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @supplier,@money_notax
			while @@fetch_status = 0
			begin
				--获取第一个货品名称
				select Top 1 @goodsname=goodsname from @tb_goods where money_tax>0 and supplier=@supplier
				select @nCount=count(*) from(select goodsname from @tb_goods where money_tax>0 and supplier=@supplier group by goodsname) t1
				if @nCount>1
				begin
					set @goodsname=@goodsname+'等'
				end

				select @partner=dbo.Getcg_partner(@supplier,'广西华纳')
				
				--发票号码
				select @kphm=stuff((select distinct ','+kphm from @tb_goods where money_tax>0 and supplier=@supplier for xml path('')),1,1,'')
				select @strkphm=@strkphm+','+@kphm
				
				set @row_summary='购进'+@goodsname+'，'+@supplier+'，零星采购，'+@kphm
				--应付账款-应付账款
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@money_notax,null,@money_notax,null,null,@sequencenumber,@partner,@idaccount,4,@idDocDTO,null)

				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary+'，'+cast(@money_notax as varchar(20))
				FETCH NEXT FROM Entry_Cursor INTO @supplier,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and id in(select id from @tb_goods where money_tax>0) 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where money_tax>0)
		end
	end
	    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wjlxcg_Invoiced_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	当月开票凭证-五金胶电-零星采购
-- =============================================
CREATE PROCEDURE [dbo].[cg_wjlxcg_Invoiced_ah] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：购进一体式电磁流量计8台，南宁普时，00475221
	DECLARE @id int,@supplier nvarchar(100),@goodsname nvarchar(100),@kphm nvarchar(max),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@foot_summary nvarchar(max),@zk_summary nvarchar(max),@strkphm nvarchar(max),@nCount int,@idDocDTO int,@summoney numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@amountdr_total numeric(18,2),@money_zk numeric(18,12),@money_weixiu numeric(18,2)
	
	DECLARE @tb_goods TABLE(id varchar(50),cg_sn varchar(50),supplier varchar(100),indate DateTime,goodsname varchar(50)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm nvarchar(400),options varchar(50),fplx varchar(50))
		
	insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options,fplx)
	select id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options,case when patindex('%专票%',fplx)>0 then '专票' else '普票' end 
	from purchase_invoiced where writeoffState=0 and abs(money)>0 and year(indate)=year(jsrq) and month(indate)=month(jsrq)
	and (warehouse='五金仓' or options='维修') and dbo.Getcg_partner(supplier,'安徽')='零星采购' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='安徽省宣城市华纳新材料科技有限公司'

	--普票
	if exists(select 1 from @tb_goods where fplx='普票')
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_ah '零星采购',0,@currentYear,@currentPeriod,'零星采购开票',@idDocDTO output
		--set @idDocDTO=93149
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @strkphm=''
			set @sequencenumber=1
			set @code='0000'
			set @amountdr_total=0
			
			DECLARE Entry_Cursor CURSOR FOR select supplier
			from @tb_goods where fplx='普票' group by supplier
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @supplier
			while @@fetch_status = 0
			begin
				--获取第一个货品名称
				select Top 1 @goodsname=goodsname from @tb_goods where fplx='普票' and supplier=@supplier
				select @nCount=count(*) from(select goodsname from @tb_goods where fplx='普票' and supplier=@supplier group by goodsname) t1
				if @nCount>1
				begin
					set @goodsname=@goodsname+'等'
				end
				
				--发票号码
				select @kphm=stuff((select distinct ','+kphm from @tb_goods where fplx='普票' and supplier=@supplier for xml path('')),1,1,'')
				select @strkphm=@strkphm+','+@kphm
				
				set @row_summary='购进'+@goodsname+'，'+@supplier+' '+@kphm
				--原材料-五金胶电
				set @money_notax=0
				select @money_notax=sum(money_notax) from @tb_goods where supplier=@supplier and options not in('维修')
				if abs(@money_notax)>0
				begin
					select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
		
					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					
					set @amountdr_total=@amountdr_total+@money_notax
					--print @row_summary+', '+cast(@amountdr_total as varchar(20))
					
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				end
				
				--制造费用-维修费用，5101007
				set @money_weixiu=0
				select @money_weixiu=sum(money_notax) from @tb_goods where supplier=@supplier and options='维修'
				if @money_weixiu>0
				begin
					select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier and options='维修'
					set @zk_summary=@goodsname+'，' +@supplier+' ' +@kphm
					select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
			
					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
					
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				end
				FETCH NEXT FROM Entry_Cursor INTO @supplier
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			select @strkphm=stuff(@strkphm,1,1,'')  --去掉第一个逗号
			set @foot_summary='购进'+@goodsname+'，零星采购 '+@strkphm
			
			--应付账款-应付账款
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountdr_total,null,@amountdr_total,null,null,@sequencenumber,'零星采购',@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_ah @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and id in(select id from @tb_goods where fplx='普票') 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where fplx='普票')
		end
	end
	
	--专票
	DECLARE customer_Cursor CURSOR FOR select supplier,kphm from @tb_goods 
	where fplx='专票' group by supplier,kphm
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_ah @supplier,0,@currentYear,@currentPeriod,'零星采购开票',@idDocDTO output
		--set @idDocDTO=89154
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			--获取第一个货品名称
			select Top 1 @goodsname=goodsname from @tb_goods where kphm=@kphm
			select @nCount=count(*) from(select goodsname from @tb_goods where kphm=@kphm group by goodsname) t1
			if @nCount>1
			begin
				set @goodsname=@goodsname+'等'
			end
			set @row_summary='购进'+@goodsname+'，' +@supplier+' ' +@kphm
			
			set @sequencenumber=1
			set @code='0000'
			
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=SUM(money_notax) from @tb_goods where kphm=@kphm and options not in('维修')
			if abs(@money_notax)>0
			begin
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
		
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--制造费用-维修费用，5101007
			set @money_weixiu=0
			select @money_weixiu=sum(money_notax) from @tb_goods where kphm=@kphm and options='维修'
			if @money_weixiu>0
			begin
				select Top 1 @goodsname=goodsname from @tb_goods where kphm=@kphm and options='维修'
				set @zk_summary=@goodsname+'，' +@supplier+' ' +@kphm
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
			
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end

			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from @tb_goods where kphm=@kphm
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			select @money=SUM(money) from @tb_goods where kphm=@kphm 	
			--应付账款-应付账款
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,'零星采购',@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_ah @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and supplier=@supplier and kphm=@kphm 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.supplier=@supplier and a.cg_sn in(select cg_sn from @tb_goods where supplier=@supplier and kphm=@kphm)
		end
	    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wjlxcg_Invoiced_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	当月开票凭证-五金胶电-零星采购
-- =============================================
CREATE PROCEDURE [dbo].[cg_wjlxcg_Invoiced_hs] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：购进一体式电磁流量计8台，南宁普时，00475221
	DECLARE @id int,@supplier nvarchar(100),@goodsname nvarchar(100),@kphm nvarchar(max),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@foot_summary nvarchar(max),@zk_summary nvarchar(max),@strkphm nvarchar(max),@nCount int,@idDocDTO int,@summoney numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@amountdr_total numeric(18,2),@money_zk numeric(18,12),@money_weixiu numeric(18,2)
	
	DECLARE @tb_goods TABLE(id varchar(50),cg_sn varchar(50),supplier varchar(100),indate DateTime,goodsname varchar(50)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm nvarchar(400),options varchar(50),fplx varchar(50))
		
	insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options,fplx)
	select id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax,kphm,options,case when patindex('%专票%',fplx)>0 then '专票' else '普票' end 
	from purchase_invoiced where writeoffState=0 and abs(money)>0 and year(indate)=year(jsrq) and month(indate)=month(jsrq)
	and (warehouse='五金仓' or options='维修') and dbo.Getcg_partner(supplier,'合山')='个体工商户' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='广西合山市华纳新材料科技有限公司'

	--普票
	if exists(select 1 from @tb_goods where fplx='普票')
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_hs '个体工商户',0,@currentYear,@currentPeriod,'个体工商户开票',@idDocDTO output
		--set @idDocDTO=93149
		if @idDocDTO>0
		begin
			--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @strkphm=''
			set @sequencenumber=1
			set @code='0000'
			set @amountdr_total=0
			
			DECLARE Entry_Cursor CURSOR FOR select supplier
			from @tb_goods where fplx='普票' group by supplier
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @supplier
			while @@fetch_status = 0
			begin
				--获取第一个货品名称
				select Top 1 @goodsname=goodsname from @tb_goods where fplx='普票' and supplier=@supplier
				select @nCount=count(*) from(select goodsname from @tb_goods where fplx='普票' and supplier=@supplier group by goodsname) t1
				if @nCount>1
				begin
					set @goodsname=@goodsname+'等'
				end
				
				--发票号码
				select @kphm=stuff((select distinct ','+kphm from @tb_goods where fplx='普票' and supplier=@supplier for xml path('')),1,1,'')
				select @strkphm=@strkphm+','+@kphm
				
				set @row_summary='购进'+@goodsname+'，'+@supplier+' '+@kphm
				--原材料-五金胶电
				set @money_notax=0
				select @money_notax=sum(money_notax) from @tb_goods where supplier=@supplier and options not in('维修')
				if abs(@money_notax)>0
				begin
					select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
		
					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					
					set @amountdr_total=@amountdr_total+@money_notax
					--print @row_summary+', '+cast(@amountdr_total as varchar(20))
					
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				end
				
				--制造费用-维修费用，5101007
				set @money_weixiu=0
				select @money_weixiu=sum(money_notax) from @tb_goods where supplier=@supplier and options='维修'
				if @money_weixiu>0
				begin
					select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier and options='维修'
					set @zk_summary=@goodsname+'，' +@supplier+' ' +@kphm
					select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
			
					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
					
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				end
				FETCH NEXT FROM Entry_Cursor INTO @supplier
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			select @strkphm=stuff(@strkphm,1,1,'')  --去掉第一个逗号
			set @foot_summary='购进'+@goodsname+'，个体工商户 '+@strkphm
			
			--应付账款-应付账款
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountdr_total,null,@amountdr_total,null,null,@sequencenumber,'个体工商户',@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_hs @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and id in(select id from @tb_goods where fplx='普票') 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where fplx='普票')
		end
	end
	
	--专票
	DECLARE customer_Cursor CURSOR FOR select supplier,kphm from @tb_goods 
	where fplx='专票' group by supplier,kphm
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_hs @supplier,0,@currentYear,@currentPeriod,'个体工商户开票',@idDocDTO output
		--set @idDocDTO=89154
		if @idDocDTO>0
		begin
			--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			--获取第一个货品名称
			select Top 1 @goodsname=goodsname from @tb_goods where kphm=@kphm
			select @nCount=count(*) from(select goodsname from @tb_goods where kphm=@kphm group by goodsname) t1
			if @nCount>1
			begin
				set @goodsname=@goodsname+'等'
			end
			set @row_summary='购进'+@goodsname+'，' +@supplier+' ' +@kphm
			
			set @sequencenumber=1
			set @code='0000'
			
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=SUM(money_notax) from @tb_goods where kphm=@kphm and options not in('维修')
			if abs(@money_notax)>0
			begin
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
		
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--制造费用-维修费用，5101007
			set @money_weixiu=0
			select @money_weixiu=sum(money_notax) from @tb_goods where kphm=@kphm and options='维修'
			if @money_weixiu>0
			begin
				select Top 1 @goodsname=goodsname from @tb_goods where kphm=@kphm and options='维修'
				set @zk_summary=@goodsname+'，' +@supplier+' ' +@kphm
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='5101007' and accountingyear=@currentYear
			
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_weixiu,null,@money_weixiu,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @zk_summary+', '+cast(@money_weixiu as varchar(20))
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end

			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from @tb_goods where kphm=@kphm
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			select @money=SUM(money) from @tb_goods where kphm=@kphm 	
			--应付账款-应付账款
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,'个体工商户',@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_hs @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and supplier=@supplier and kphm=@kphm 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.supplier=@supplier and a.cg_sn in(select cg_sn from @tb_goods where supplier=@supplier and kphm=@kphm)
		end
	    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
        
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wjlxcg_NotInvoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	未开票凭证-五金胶电-零星采购
-- =============================================
CREATE PROCEDURE [dbo].[cg_wjlxcg_NotInvoiced] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    --生成摘要：购进一体式电磁流量计8台，南宁普时，00475221
	DECLARE @id int,@supplier nvarchar(100),@goodsname nvarchar(100),@kphm nvarchar(max),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@foot_summary nvarchar(max),@zk_summary nvarchar(max),@strkphm nvarchar(max),@nCount int,@idDocDTO int,@summoney numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@amountdr_total numeric(18,2),@money_zk numeric(18,12),@money_weixiu numeric(18,2)
	
	DECLARE @tb_goods TABLE(id varchar(50),cg_sn varchar(50),supplier varchar(100),indate DateTime,goodsname varchar(50)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm nvarchar(400),options varchar(50),fplx varchar(50))
		
	insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax)
	select id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax 
	from purchase_in where writeoffState=0 and abs(money)>0 and year(indate)=@currentYear and month(indate)=@currentPeriod 
	and warehouse='五金仓' and dbo.Getcg_partner(supplier,'广西华纳')='零星采购'
	and dw='广西华纳新材料股份有限公司'
	
	if exists(select 1 from @tb_goods where supplier='零星采购')
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster '零星采购',0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			
			select Top 1 @goodsname=goodsname from @tb_goods where supplier='零星采购'
			set @row_summary='购进'+@goodsname+'等，零星采购无票'
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where supplier='零星采购'
			if abs(@money_notax)>0
			begin
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
		
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary+', '+cast(@money_notax as varchar(20))+','+@code
					
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end

			--应付账款-暂估进项税
			set @money_tax=0
			select @money_tax=SUM(money_tax) from @tb_goods where supplier='零星采购'
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202003' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary+', '+cast(@money_tax as varchar(20))+','+@code
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end

			DECLARE Entry_Cursor CURSOR FOR select supplier,goodsname,sum(money_notax)
			from @tb_goods where supplier='零星采购' group by supplier,goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @supplier,@goodsname,@money_notax
			while @@fetch_status = 0
			begin
				set @row_summary='购进'+@goodsname+'，'+@supplier+'，零星采购'
				--应付账款-应付账款
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@money_notax,null,@money_notax,null,null,@sequencenumber,'零星采购',@idaccount,4,@idDocDTO,null)
				--print @row_summary+'，'+cast(@money_notax as varchar(20))+','+@code
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				FETCH NEXT FROM Entry_Cursor INTO @supplier,@goodsname,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where id in(select id from @tb_goods where supplier='零星采购')
		end
	end
	
	if exists(select 1 from @tb_goods where supplier<>'零星采购' and money_tax=0)
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster '零星采购',0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'

			select Top 1 @goodsname=goodsname from @tb_goods where supplier<>'零星采购' and money_tax=0
			set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'，零星采购'
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where supplier<>'零星采购' and money_tax=0
			if abs(@money_notax)>0
			begin
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
		
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary+', '+cast(@money_notax as varchar(20))+','+@code				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end

			DECLARE Entry_Cursor CURSOR FOR select supplier,sum(money_notax)
			from @tb_goods where supplier<>'零星采购' and money_tax=0 group by supplier
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @supplier,@money_notax
			while @@fetch_status = 0
			begin
				--获取第一个货品名称
				select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier
				select @nCount=count(*) from(select goodsname from @tb_goods where supplier=@supplier group by goodsname) t1
				if @nCount>1
				begin
					set @goodsname=@goodsname+'等'
				end
				set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'，' +@supplier+'，零星采购'

				--应付账款-暂估应付款
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@money_notax,null,@money_notax,null,null,@sequencenumber,'零星采购',@idaccount,4,@idDocDTO,null)
				--print @row_summary+'，'+cast(@money_notax as varchar(20))+','+@code
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				FETCH NEXT FROM Entry_Cursor INTO @supplier,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where id in(select id from @tb_goods where supplier<>'零星采购' and money_tax=0)
		end
    end

	if exists(select 1 from @tb_goods where supplier<>'零星采购' and money_tax>0)
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster '零星采购',0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'

			select Top 1 @goodsname=goodsname from @tb_goods where supplier<>'零星采购' and money_tax>0
			set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'，零星采购'
			--原材料-五金胶电
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where supplier<>'零星采购' and money_tax>0
			if abs(@money_notax)>0
			begin
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear
		
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary+', '+cast(@money_notax as varchar(20))+','+@code
					
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end

			--应付账款-暂估进项税
			set @money_tax=0
			select @money_tax=SUM(money_tax) from @tb_goods where supplier<>'零星采购' and money_tax>0
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202003' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				--print @row_summary+', '+cast(@money_tax as varchar(20))+','+@code
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end

			DECLARE Entry_Cursor CURSOR FOR select supplier,sum(money_notax)
			from @tb_goods where supplier<>'零星采购' and money_tax>0 group by supplier
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @supplier,@money_notax
			while @@fetch_status = 0
			begin
				--获取第一个货品名称
				select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier
				select @nCount=count(*) from(select goodsname from @tb_goods where supplier=@supplier group by goodsname) t1
				if @nCount>1
				begin
					set @goodsname=@goodsname+'等'
				end
				set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'，' +@supplier+'，零星采购'

				--应付账款-暂估应付款
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,@money_notax,null,@money_notax,null,null,@sequencenumber,'零星采购',@idaccount,4,@idDocDTO,null)
				--print @row_summary+'，'+cast(@money_notax as varchar(20))+','+@code

				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				FETCH NEXT FROM Entry_Cursor INTO @supplier,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where id in(select id from @tb_goods where supplier<>'零星采购' and money_tax>0)
		end
    end
	
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wjlxcg_NotInvoiced_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	未开票凭证-五金胶电-零星采购
-- =============================================
CREATE PROCEDURE [dbo].[cg_wjlxcg_NotInvoiced_ah] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    --生成摘要：购进一体式电磁流量计8台，南宁普时，00475221
	DECLARE @id int,@supplier nvarchar(100),@goodsname nvarchar(100),@kphm nvarchar(max),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@foot_summary nvarchar(max),@zk_summary nvarchar(max),@strkphm nvarchar(max),@nCount int,@idDocDTO int,@summoney numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@amountdr_total numeric(18,2),@money_zk numeric(18,12),@money_weixiu numeric(18,2)
	
	DECLARE @tb_goods TABLE(id varchar(50),cg_sn varchar(50),supplier varchar(100),indate DateTime,goodsname varchar(50)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm nvarchar(400),options varchar(50),fplx varchar(50))
		
	insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax)
	select id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax 
	from purchase_in where writeoffState=0 and abs(money)>0 and year(indate)=@currentYear and month(indate)=@currentPeriod 
	and warehouse='五金仓' and dbo.Getcg_partner(supplier,'安徽')='零星采购'
	and dw='安徽省宣城市华纳新材料科技有限公司'
	
	if exists(select 1 from @tb_goods where supplier='零星采购')
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_ah '零星采购',0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			
			DECLARE goods_Cursor CURSOR FOR select supplier,goodsname,sum(money_notax),sum(money_tax)
			from @tb_goods where supplier='零星采购' 
			group by supplier,goodsname order by goodsname
			OPEN goods_Cursor
			FETCH NEXT FROM goods_Cursor INTO @supplier,@goodsname,@money_notax,@money_tax
			while @@fetch_status = 0
			begin
				set @row_summary='购进'+@goodsname+'，' +@supplier
				if @money_notax>0
				begin
					--原材料-五金胶电
					select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear

					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				end
				
				--应付账款-暂估进项税
				if @money_tax>0
				begin
					select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202003' and accountingyear=@currentYear
			
					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)
					
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				end
				--print @row_summary+'，'+cast(@money_notax as varchar(20))+'，'+cast(@money_tax as varchar(20))
				FETCH NEXT FROM goods_Cursor INTO @supplier,@goodsname,@money_notax,@money_tax
			end
			CLOSE goods_Cursor
			DEALLOCATE goods_Cursor

			select @money=sum(money) from @tb_goods where supplier=@supplier
			--应付账款-应付账款
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
			set @row_summary='零星采购无票'
			--print @row_summary+'，'+cast(@money as varchar(20))
				
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,'零星采购',@idaccount,4,@idDocDTO,null)
			
			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_ah @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where id in(select id from @tb_goods where supplier='零星采购')
		end
	end
	
	if exists(select 1 from @tb_goods where supplier<>'零星采购' and money_tax=0)
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_ah '零星采购',0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			
			DECLARE customer_Cursor CURSOR FOR select supplier from @tb_goods
			where supplier<>'零星采购' and money_tax=0
			group by supplier order by supplier
			OPEN customer_Cursor
			FETCH NEXT FROM customer_Cursor INTO @supplier
			while @@fetch_status = 0
			begin
				--获取第一个货品名称
				select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier
				select @nCount=count(*) from(select goodsname from @tb_goods where supplier=@supplier group by goodsname) t1
				if @nCount>1
				begin
					set @goodsname=@goodsname+'等'
				end
				set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'，' +@supplier+'，零星采购'
				
				set @money_notax=0
				select @money_notax=sum(money_notax) from @tb_goods where supplier=@supplier
				--原材料-五金胶电
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear

				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary+'，'+cast(@money_notax as varchar(20))
				FETCH NEXT FROM customer_Cursor INTO @supplier
			end
			CLOSE customer_Cursor
			DEALLOCATE customer_Cursor
			
			select @money=sum(money) from @tb_goods where supplier<>'零星采购' and money_tax=0
			--应付账款-暂估应付款
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear
			set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账，零星采购'
			--print @row_summary++'，'+cast(@money as varchar(20))
				
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,'零星采购',@idaccount,4,@idDocDTO,null)
			
			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_ah @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where id in(select id from @tb_goods where supplier<>'零星采购' and money_tax=0)
		end
    end
    
    DECLARE customer_Cursor CURSOR FOR select supplier from @tb_goods
	where supplier<>'零星采购' and money_tax>0
	group by supplier order by supplier
	OPEN customer_Cursor
	FETCH NEXT FROM customer_Cursor INTO @supplier
	while @@fetch_status = 0
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_ah '零星采购',0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			
			--获取第一个货品名称
			select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier
			select @nCount=count(*) from(select goodsname from @tb_goods where supplier=@supplier group by goodsname) t1
			if @nCount>1
			begin
				set @goodsname=@goodsname+'等'
			end
			set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'，' +@supplier+'，零星采购'
				
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where supplier=@supplier
			--原材料-五金胶电
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear

			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			set @money_tax=0
			select @money_tax=sum(money_tax) from @tb_goods where supplier=@supplier
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202003' and accountingyear=@currentYear
			
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
			price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,'零星采购',@idaccount,4,@idDocDTO,null)
					
			select @money=sum(money) from @tb_goods where supplier=@supplier
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			--应付账款-暂估应付款
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear
			--print @row_summary+'，'+cast(@money_notax as varchar(20))+'，'+cast(@money_tax as varchar(20))+'，'+cast(@money as varchar(20))
			
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,'零星采购',@idaccount,4,@idDocDTO,null)
			
			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_ah @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where id in(select id from @tb_goods where supplier=@supplier and money_tax>0)
		end
		FETCH NEXT FROM customer_Cursor INTO @supplier
	end
	CLOSE customer_Cursor
	DEALLOCATE customer_Cursor
	
END
GO
/****** Object:  StoredProcedure [dbo].[cg_wjlxcg_NotInvoiced_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	未开票凭证-五金胶电-个体工商户
-- =============================================
CREATE PROCEDURE [dbo].[cg_wjlxcg_NotInvoiced_hs] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    --生成摘要：购进一体式电磁流量计8台，南宁普时，00475221
	DECLARE @id int,@supplier nvarchar(100),@goodsname nvarchar(100),@kphm nvarchar(max),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@foot_summary nvarchar(max),@zk_summary nvarchar(max),@strkphm nvarchar(max),@nCount int,@idDocDTO int,@summoney numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@amountdr_total numeric(18,2),@money_zk numeric(18,12),@money_weixiu numeric(18,2)
	
	DECLARE @tb_goods TABLE(id varchar(50),cg_sn varchar(50),supplier varchar(100),indate DateTime,goodsname varchar(50)
		,[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm nvarchar(400),options varchar(50),fplx varchar(50))
		
	insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax)
	select id,cg_sn,supplier,indate,goodsname,[money],money_notax,money_tax 
	from purchase_in where writeoffState=0 and abs(money)>0 and year(indate)=@currentYear and month(indate)=@currentPeriod 
	and warehouse='五金仓' and dbo.Getcg_partner(supplier,'合山')='个体工商户'
	and dw='广西合山市华纳新材料科技有限公司'
	
	if exists(select 1 from @tb_goods where supplier='个体工商户')
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_hs '个体工商户',0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			
			DECLARE goods_Cursor CURSOR FOR select supplier,goodsname,sum(money_notax),sum(money_tax)
			from @tb_goods where supplier='个体工商户' 
			group by supplier,goodsname order by goodsname
			OPEN goods_Cursor
			FETCH NEXT FROM goods_Cursor INTO @supplier,@goodsname,@money_notax,@money_tax
			while @@fetch_status = 0
			begin
				set @row_summary='购进'+@goodsname+'，' +@supplier
				if @money_notax>0
				begin
					--原材料-五金胶电
					select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear

					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
					, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				end
				
				--应付账款-暂估进项税
				if @money_tax>0
				begin
					select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202003' and accountingyear=@currentYear
			
					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)
					
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				end
				--print @row_summary+'，'+cast(@money_notax as varchar(20))+'，'+cast(@money_tax as varchar(20))
				FETCH NEXT FROM goods_Cursor INTO @supplier,@goodsname,@money_notax,@money_tax
			end
			CLOSE goods_Cursor
			DEALLOCATE goods_Cursor

			select @money=sum(money) from @tb_goods where supplier=@supplier
			--应付账款-应付账款
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
			set @row_summary='个体工商户无票'
			--print @row_summary+'，'+cast(@money as varchar(20))
				
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,'个体工商户',@idaccount,4,@idDocDTO,null)
			
			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_hs @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where id in(select id from @tb_goods where supplier='个体工商户')
		end
	end
	
	if exists(select 1 from @tb_goods where supplier<>'个体工商户' and money_tax=0)
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_hs '个体工商户',0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			
			DECLARE customer_Cursor CURSOR FOR select supplier from @tb_goods
			where supplier<>'个体工商户' and money_tax=0
			group by supplier order by supplier
			OPEN customer_Cursor
			FETCH NEXT FROM customer_Cursor INTO @supplier
			while @@fetch_status = 0
			begin
				--获取第一个货品名称
				select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier
				select @nCount=count(*) from(select goodsname from @tb_goods where supplier=@supplier group by goodsname) t1
				if @nCount>1
				begin
					set @goodsname=@goodsname+'等'
				end
				set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'，' +@supplier+'，个体工商户'
				
				set @money_notax=0
				select @money_notax=sum(money_notax) from @tb_goods where supplier=@supplier
				--原材料-五金胶电
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear

				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary+'，'+cast(@money_notax as varchar(20))
				FETCH NEXT FROM customer_Cursor INTO @supplier
			end
			CLOSE customer_Cursor
			DEALLOCATE customer_Cursor
			
			select @money=sum(money) from @tb_goods where supplier<>'个体工商户' and money_tax=0
			--应付账款-暂估应付款
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear
			set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账，个体工商户'
			--print @row_summary++'，'+cast(@money as varchar(20))
				
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,'个体工商户',@idaccount,4,@idDocDTO,null)
			
			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_hs @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where id in(select id from @tb_goods where supplier<>'个体工商户' and money_tax=0)
		end
    end
    
    DECLARE customer_Cursor CURSOR FOR select supplier from @tb_goods
	where supplier<>'个体工商户' and money_tax>0
	group by supplier order by supplier
	OPEN customer_Cursor
	FETCH NEXT FROM customer_Cursor INTO @supplier
	while @@fetch_status = 0
	begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_hs '个体工商户',0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			
			--获取第一个货品名称
			select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier
			select @nCount=count(*) from(select goodsname from @tb_goods where supplier=@supplier group by goodsname) t1
			if @nCount>1
			begin
				set @goodsname=@goodsname+'等'
			end
			set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'，' +@supplier+'，个体工商户'
				
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where supplier=@supplier
			--原材料-五金胶电
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='1403005' and accountingyear=@currentYear

			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			set @money_tax=0
			select @money_tax=sum(money_tax) from @tb_goods where supplier=@supplier
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202003' and accountingyear=@currentYear
			
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
			price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,'个体工商户',@idaccount,4,@idDocDTO,null)
					
			select @money=sum(money) from @tb_goods where supplier=@supplier
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			--应付账款-暂估应付款
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear
			--print @row_summary+'，'+cast(@money_notax as varchar(20))+'，'+cast(@money_tax as varchar(20))+'，'+cast(@money as varchar(20))
			
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,@money,null,@money,null,null,@sequencenumber,'个体工商户',@idaccount,4,@idDocDTO,null)
			
			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_hs @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where id in(select id from @tb_goods where supplier=@supplier and money_tax>0)
		end
		FETCH NEXT FROM customer_Cursor INTO @supplier
	end
	CLOSE customer_Cursor
	DEALLOCATE customer_Cursor
	
END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_Invoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	当月开票凭证-原料
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_Invoiced] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   --生成摘要：购进CBO 170.94吨，广州茂钦  23442000000149644958
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100),@goodsunit nvarchar(50)
		,@amount numeric(18,5),@price numeric(18,2),@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@summoney numeric(18,2),@money_zk numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@idUnit int
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	insert into @tb_goods(id,supplier,cg_sn,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
	select id,supplier,cg_sn,indate,dbo.Getcgyl_goodsname(goodsname,'广西华纳') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'广西华纳') as goodsunit
	,dbo.Getcg_amountConvert(goodsname,amount,'广西华纳') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and abs([money])>0 and year(indate)=year(jsrq) and month(indate)=month(jsrq)
	and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='广西华纳新材料股份有限公司'
	order by supplier,kphm
	
	DECLARE customer_Cursor CURSOR FOR select supplier,kphm from @tb_goods 
	group by supplier,kphm order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster @supplier,0,@currentYear,@currentPeriod,'当月开票',@idDocDTO output
		--set @idDocDTO=103287
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			delete from @tb_head --清空
			set @sequencenumber=1
			set @code='0000'
			
			DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
			from @tb_goods where kphm=@kphm and options<>'折扣'
			group by goodsname,goodsunit,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			while @@fetch_status = 0
			begin
				--科目
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'广西华纳')
				select Top 1 @idUnit=id from UFTData328464_300011.dbo.AA_Unit where name=@goodsunit
				set @row_summary='购进'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier+' '+@kphm
				if @amount=0
				begin
					if @money_notax>0
						set @row_summary=@goodsname+'运费，'+@supplier+' '+@kphm
					set @price=null
				end
				else
				begin
					set @price=@money_notax/@amount
				end
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
				
				insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣返利
			set @money_zk=0
			select @money_zk=sum(money_notax) from @tb_goods where money_notax<0 and kphm=@kphm  and options='折扣'
			if abs(@money_zk)>0
			begin
				set @zk_summary='购进'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'现金折扣，'+@supplier+'  '+@kphm
							
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--获取汇总行摘要
			set @foot_summary='购进'
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				set @foot_summary=@foot_summary+'+'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit
				if @amount=0
					set @foot_summary='+'+@goodsname+'运费'
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @foot_summary=stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier+' '+@kphm --替换第一个'+'字符
			--print @foot_summary
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from purchase_invoiced where kphm=@kphm
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			select @money=SUM(money) from purchase_invoiced where kphm=@kphm					
			--应付账款-应付账款
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and kphm=@kphm 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from purchase_invoiced where kphm=@kphm)
		end
	    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_Invoiced_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	当月开票凭证-原料
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_Invoiced_ah] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：购进CBO 170.94吨，广州茂钦  23442000000149644958
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100),@goodsunit nvarchar(50)
		,@amount numeric(18,5),@price numeric(18,5),@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@summoney numeric(18,2),@money_zk numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@idUnit int
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	insert into @tb_goods(id,supplier,cg_sn,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
	select id,supplier,cg_sn,indate,dbo.Getcgyl_goodsname(goodsname,'安徽') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'安徽') as goodsunit
	,dbo.Getcg_amountConvert(goodsname,amount,'安徽') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and abs([money])>0 and year(indate)=year(jsrq) and month(indate)=month(jsrq)
	and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='安徽省宣城市华纳新材料科技有限公司'
	order by supplier,kphm
	
	DECLARE customer_Cursor CURSOR FOR select supplier,kphm from @tb_goods 
	group by supplier,kphm order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_ah @supplier,0,@currentYear,@currentPeriod,'当月开票',@idDocDTO output
		--set @idDocDTO=17500
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			delete from @tb_head --清空
			set @sequencenumber=1
			set @code='0000'
			
			DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
			from @tb_goods where kphm=@kphm and options<>'折扣'
			group by goodsname,goodsunit,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			while @@fetch_status = 0
			begin
				--科目
				select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'安徽')
				select Top 1 @idUnit=id from UFTData305193_300004.dbo.AA_Unit where name=@goodsunit
				set @row_summary='购进'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier+' '+@kphm
				if @amount=0
				begin
					if @money_notax>0
						set @row_summary=@goodsname+'运费，'+@supplier+' '+@kphm
					set @price=null
				end
				else
				begin
					set @price=@money_notax/@amount
				end
				
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
					
				insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣返利
			set @money_zk=0
			select @money_zk=sum(money_notax) from @tb_goods where money_notax<0 and kphm=@kphm  and options='折扣'
			if abs(@money_zk)>0
			begin
				set @zk_summary='购进'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'现金折扣，'+@supplier+'  '+@kphm
			
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--获取汇总行摘要
			set @foot_summary='购进'
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				set @foot_summary=@foot_summary+'+'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit
				if @amount=0
					set @foot_summary='+'+@goodsname+'运费'
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @foot_summary=stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier+' '+@kphm --替换第一个'+'字符
			--print @foot_summary
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from purchase_invoiced where kphm=@kphm
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			select @money=SUM(money) from purchase_invoiced where kphm=@kphm					
			--应付账款-应付账款
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_ah @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and kphm=@kphm 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from purchase_invoiced where kphm=@kphm)
		end
	    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_Invoiced_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	当月开票凭证-原料
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_Invoiced_hs] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：购进CBO 170.94吨，广州茂钦  23442000000149644958
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100),@goodsunit nvarchar(50)
		,@amount numeric(18,5),@price numeric(18,2),@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@summoney numeric(18,2),@money_zk numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@idUnit int
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	insert into @tb_goods(id,supplier,cg_sn,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
	select id,supplier,cg_sn,indate,dbo.Getcgyl_goodsname(goodsname,'合山') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'合山') as goodsunit
	,dbo.Getcg_amountConvert(goodsname,amount,'合山') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and abs([money])>0 and year(indate)=year(jsrq) and month(indate)=month(jsrq)
	and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='广西合山市华纳新材料科技有限公司'
	order by supplier,kphm
	
	DECLARE customer_Cursor CURSOR FOR select supplier,kphm from @tb_goods 
	group by supplier,kphm order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_hs @supplier,0,@currentYear,@currentPeriod,'当月开票',@idDocDTO output
		--set @idDocDTO=17075
		if @idDocDTO>0
		begin
			--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			delete from @tb_head --清空
			set @sequencenumber=1
			set @code='0000'
			
			DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
			from @tb_goods where kphm=@kphm and options<>'折扣'
			group by goodsname,goodsunit,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			while @@fetch_status = 0
			begin
				--科目
				select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'合山')
				select Top 1 @idUnit=id from UFTData585087_300003.dbo.AA_Unit where name=@goodsunit
				set @row_summary='购进'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier+' '+@kphm
				if @amount=0
				begin
					if @money_notax>0
						set @row_summary=@goodsname+'运费，'+@supplier+' '+@kphm
					set @price=null
				end
				else
				begin
					set @price=@money_notax/@amount
				end
				
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
					
				insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣返利
			set @money_zk=0
			select @money_zk=sum(money_notax) from @tb_goods where money_notax<0 and kphm=@kphm  and options='折扣'
			if abs(@money_zk)>0
			begin
				set @zk_summary='购进'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'现金折扣，'+@supplier+'  '+@kphm

				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--获取汇总行摘要
			set @foot_summary='购进'
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				set @foot_summary=@foot_summary+'+'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit
				if @amount=0
					set @foot_summary='+'+@goodsname+'运费'
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @foot_summary=stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier+' '+@kphm --替换第一个'+'字符
			--print @foot_summary
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from purchase_invoiced where kphm=@kphm
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			select @money=SUM(money) from purchase_invoiced where kphm=@kphm
			--应付账款-应付账款
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_hs @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and kphm=@kphm 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from purchase_invoiced where kphm=@kphm)
		end
	    FETCH NEXT FROM customer_Cursor INTO @supplier,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_InvoicedTwo]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	当月开票凭证-原料-多票一凭证
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_InvoicedTwo] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   --生成摘要：购进CBO 170.94吨，广州茂钦  23442000000149644958
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100),@goodsunit nvarchar(50)
		,@amount numeric(18,5),@price numeric(18,2),@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@summoney numeric(18,2),@money_zk numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@idUnit int
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)

	DECLARE customer_Cursor CURSOR FOR select supplier from (
	select supplier,kphm from purchase_invoiced where writeoffState=0 and abs([money])>0 and year(indate)=year(jsrq) and month(indate)=month(jsrq)
		and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
		and dw='广西华纳新材料股份有限公司'
	group by supplier,kphm
	) t1
	group by supplier
	having COUNT(*)>1
	order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier
    while @@fetch_status = 0
    begin
		delete from @tb_goods --清除
		insert into @tb_goods(id,supplier,cg_sn,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
		select id,supplier,cg_sn,indate,dbo.Getcgyl_goodsname(goodsname,'广西华纳') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'广西华纳') as goodsunit
		,dbo.Getcg_amountConvert(goodsname,amount,'广西华纳') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
		where writeoffState=0 and abs([money])>0 and year(indate)=year(jsrq) and month(indate)=month(jsrq)
		and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
		and dw='广西华纳新材料股份有限公司'
		and supplier=@supplier
		order by supplier,kphm
	
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster @supplier,0,@currentYear,@currentPeriod,'当月开票',@idDocDTO output
		--set @idDocDTO=103287
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			delete from @tb_head --清空
			set @sequencenumber=1
			set @code='0000'
			
			set @kphm=''
			select @kphm=stuff((select distinct ','+kphm from @tb_goods where supplier=@supplier for xml path('')),1,1,'')
			
			DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
			from @tb_goods where supplier=@supplier and options not in('折扣')
			group by goodsname,goodsunit,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			while @@fetch_status = 0
			begin
				--科目
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'广西华纳')
				select Top 1 @idUnit=id from UFTData328464_300011.dbo.AA_Unit where name=@goodsunit
				set @row_summary='购进'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier+' '+@kphm
				if @amount=0
				begin
					if @money_notax>0
						set @row_summary=@goodsname+'运费，'+@supplier+' '+@kphm
					set @price=null
				end
				else
				begin
					set @price=@money_notax/@amount
				end
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
				
				insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣返利
			set @money_zk=0
			select @money_zk=sum(money_notax) from @tb_goods where money_notax<0 and kphm in(select distinct kphm from @tb_goods where supplier=@supplier) and options='折扣'
			if abs(@money_zk)>0
			begin
				set @zk_summary='购进'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'现金折扣，'+@supplier+'  '+@kphm
								
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--获取汇总行摘要
			set @foot_summary='购进'
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				set @foot_summary=@foot_summary+'+'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit
				if @amount=0
					set @foot_summary='+'+@goodsname+'运费'
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @foot_summary=stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier+' '+@kphm --替换第一个'+'字符
			--print @foot_summary
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where supplier=@supplier)
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			select @money=SUM(money) from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where supplier=@supplier)	
			--应付账款-应付账款
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and kphm in(select distinct kphm from @tb_goods where supplier=@supplier) 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where supplier=@supplier))
		end
	    FETCH NEXT FROM customer_Cursor INTO @supplier
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_InvoicedTwo_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	当月开票凭证-原料-多票一凭证
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_InvoicedTwo_ah] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   --生成摘要：购进CBO 170.94吨，广州茂钦  23442000000149644958
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100),@goodsunit nvarchar(50)
		,@amount numeric(18,5),@price numeric(18,5),@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@summoney numeric(18,2),@money_zk numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@idUnit int
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)

	DECLARE customer_Cursor CURSOR FOR select supplier from (
	select supplier,kphm from purchase_invoiced where writeoffState=0 and abs([money])>0 and year(indate)=year(jsrq) and month(indate)=month(jsrq)
		and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
		and dw='安徽省宣城市华纳新材料科技有限公司'
	group by supplier,kphm
	) t1
	group by supplier
	having COUNT(*)>1
	order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier
    while @@fetch_status = 0
    begin
		delete from @tb_goods --清除
		insert into @tb_goods(id,supplier,cg_sn,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
		select id,supplier,cg_sn,indate,dbo.Getcgyl_goodsname(goodsname,'安徽') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'安徽') as goodsunit
		,dbo.Getcg_amountConvert(goodsname,amount,'安徽') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
		where writeoffState=0 and abs([money])>0 and year(indate)=year(jsrq) and month(indate)=month(jsrq)
		and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
		and dw='安徽省宣城市华纳新材料科技有限公司'
		and supplier=@supplier
		order by supplier,kphm
	
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_ah @supplier,0,@currentYear,@currentPeriod,'当月开票',@idDocDTO output
		--set @idDocDTO=103287
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			delete from @tb_head --清空
			set @sequencenumber=1
			set @code='0000'
			
			set @kphm=''
			select @kphm=stuff((select distinct ','+kphm from @tb_goods where supplier=@supplier for xml path('')),1,1,'')
			
			DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
			from @tb_goods where supplier=@supplier and options not in('折扣')
			group by goodsname,goodsunit,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			while @@fetch_status = 0
			begin
				--科目
				select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'安徽')
				select Top 1 @idUnit=id from UFTData305193_300004.dbo.AA_Unit where name=@goodsunit
				set @row_summary='购进'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier+' '+@kphm
				if @amount=0
				begin
					if @money_notax>0
						set @row_summary=@goodsname+'运费，'+@supplier+' '+@kphm
					set @price=null
				end
				else
				begin
					set @price=@money_notax/@amount
				end
				
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
				
				insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣返利
			set @money_zk=0
			select @money_zk=sum(money_notax) from @tb_goods where money_notax<0 and kphm in(select distinct kphm from @tb_goods where supplier=@supplier) and options='折扣'
			if abs(@money_zk)>0
			begin
				set @zk_summary='购进'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'现金折扣，'+@supplier+'  '+@kphm
								
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--获取汇总行摘要
			set @foot_summary='购进'
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				set @foot_summary=@foot_summary+'+'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit
				if @amount=0
					set @foot_summary='+'+@goodsname+'运费'
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @foot_summary=stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier+' '+@kphm --替换第一个'+'字符
			--print @foot_summary
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where supplier=@supplier)
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			select @money=SUM(money) from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where supplier=@supplier)	
			--应付账款-应付账款
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_ah @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and kphm in(select distinct kphm from @tb_goods where supplier=@supplier) 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where supplier=@supplier))
		end
	    FETCH NEXT FROM customer_Cursor INTO @supplier
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_InvoicedTwo_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	当月开票凭证-原料-多票一凭证
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_InvoicedTwo_hs] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   --生成摘要：购进CBO 170.94吨，广州茂钦  23442000000149644958
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100),@goodsunit nvarchar(50)
		,@amount numeric(18,5),@price numeric(18,2),@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@summoney numeric(18,2),@money_zk numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@idUnit int
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)

	DECLARE customer_Cursor CURSOR FOR select supplier from (
	select supplier,kphm from purchase_invoiced where writeoffState=0 and abs([money])>0 and year(indate)=year(jsrq) and month(indate)=month(jsrq)
		and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
		and dw='广西合山市华纳新材料科技有限公司'
	group by supplier,kphm
	) t1
	group by supplier
	having COUNT(*)>1
	order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier
    while @@fetch_status = 0
    begin
		delete from @tb_goods --清除
		insert into @tb_goods(id,supplier,cg_sn,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
		select id,supplier,cg_sn,indate,dbo.Getcgyl_goodsname(goodsname,'合山') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'合山') as goodsunit
		,dbo.Getcg_amountConvert(goodsname,amount,'合山') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
		where writeoffState=0 and abs([money])>0 and year(indate)=year(jsrq) and month(indate)=month(jsrq)
		and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
		and dw='广西合山市华纳新材料科技有限公司'
		and supplier=@supplier
		order by supplier,kphm
	
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_hs @supplier,0,@currentYear,@currentPeriod,'当月开票',@idDocDTO output
		--set @idDocDTO=103287
		if @idDocDTO>0
		begin
			--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			delete from @tb_head --清空
			set @sequencenumber=1
			set @code='0000'
			
			set @kphm=''
			select @kphm=stuff((select distinct ','+kphm from @tb_goods where supplier=@supplier for xml path('')),1,1,'')
			
			DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
			from @tb_goods where supplier=@supplier and options not in('折扣')
			group by goodsname,goodsunit,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			while @@fetch_status = 0
			begin
				--科目
				select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'合山')
				select Top 1 @idUnit=id from UFTData585087_300003.dbo.AA_Unit where name=@goodsunit
				set @row_summary='购进'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier+' '+@kphm
				if @amount=0
				begin
					if @money_notax>0
						set @row_summary=@goodsname+'运费，'+@supplier+' '+@kphm
					set @price=null
				end
				else
				begin
					set @price=@money_notax/@amount
				end
				
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
				
				insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣返利
			set @money_zk=0
			select @money_zk=sum(money_notax) from @tb_goods where money_notax<0 and kphm in(select distinct kphm from @tb_goods where supplier=@supplier) and options='折扣'
			if abs(@money_zk)>0
			begin
				set @zk_summary='购进'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'现金折扣，'+@supplier+'  '+@kphm
								
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--获取汇总行摘要
			set @foot_summary='购进'
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				set @foot_summary=@foot_summary+'+'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit
				if @amount=0
					set @foot_summary='+'+@goodsname+'运费'
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @foot_summary=stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier+' '+@kphm --替换第一个'+'字符
			--print @foot_summary
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where supplier=@supplier)
			if abs(@money_tax)>0
			begin
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			select @money=SUM(money) from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where supplier=@supplier)	
			--应付账款-应付账款
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_hs @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and kphm in(select distinct kphm from @tb_goods where supplier=@supplier) 
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from purchase_invoiced where kphm in(select distinct kphm from @tb_goods where supplier=@supplier))
		end
	    FETCH NEXT FROM customer_Cursor INTO @supplier
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_Notinvoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-3-1
-- Description:	未开票凭证（原料）
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_Notinvoiced] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：CBO 242.62 吨+R-90   32吨暂估入账，广州茂钦
	DECLARE @cg_sn nvarchar(50),@supplier nvarchar(100),@goodsname nvarchar(100),@goodsunit nvarchar(50),@amount numeric(18,5)
		,@price numeric(18,5),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@summoney numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@idUnit int
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	DECLARE @tb_goods TABLE(id varchar(50),cg_sn varchar(50),supplier varchar(100),indate DateTime,goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,5),price numeric(18,5),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2))
		
	insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax)
	select id,cg_sn,supplier,indate,dbo.Getcgyl_goodsname(goodsname,'广西华纳') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'广西华纳') as goodsunit
	,dbo.Getcg_amountConvert(goodsname,amount,'广西华纳') as amount,dbo.Getcgyl_price(id,'暂估') as price,[money],money_notax,money_tax  
	from purchase_in b where writeoffState=0 and abs([money])>0 and warehouse<>'五金仓' 
	and year(indate)=@currentYear and month(indate)=@currentPeriod and dw='广西华纳新材料股份有限公司'
	order by supplier,cg_sn
	
	DECLARE customer_Cursor CURSOR FOR select supplier from @tb_goods 
	group by supplier order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster @supplier,0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			delete from @tb_head --清空
			set @sequencenumber=1
			set @code='0000'
			
			--获取冲红退货单
			insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax)
			select '-1',cg_sn,supplier,thdate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax 
			from purchase_th where writeoffState=0 and supplier=@supplier and YEAR(thdate)=@currentYear and MONTH(thdate)=@currentPeriod 
			and dw='广西华纳新材料股份有限公司'
			
			--默认摘要
			set @row_summary=''
			set @goodsname=''
			select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier
			DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
			from @tb_goods where [money]>0 and supplier=@supplier
			group by goodsname,goodsunit,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			while @@fetch_status = 0
			begin
				--科目
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'广西华纳')
				select Top 1 @idUnit=id from UFTData328464_300011.dbo.AA_Unit where name=@goodsunit
				set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier
				if @amount=0
				begin
					if @money_notax>0
						set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'运费，'+@supplier
					set @price=null
				end
				else
				begin
					set @price=@money_notax/@amount
				end
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
					
				insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary+'，'+cast(@money_notax as varchar(20))+'，'+cast(@idaccount as varchar(20))
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--优惠金额
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where id>0 and [money]<0 and supplier=@supplier
			if abs(@money_notax)>0
			begin
				if @row_summary=''
				begin
					select @amount=amount,@goodsname=goodsname,@goodsunit=goodsunit from @tb_goods where id>0 and [money]<0 and supplier=@supplier
					select @idUnit=id from UFTData328464_300011.dbo.AA_Unit where name=@goodsunit
				end
				set @zk_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'（优惠金额），'+@supplier
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
				
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @zk_summary+'，'+cast(@money_notax as varchar(20))
			end
			
			--获取汇总行摘要
			set @foot_summary=''
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				set @foot_summary=@foot_summary+'+'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit
				if @amount=0
					set @foot_summary='+'+@goodsname+'运费'
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @foot_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier --替换第一个'+'字符
			if isnull(@foot_summary,'')='' set @foot_summary=@zk_summary
			--print @foot_summary
			
			select @money_tax=sum(money_tax) from @tb_goods where supplier=@supplier
			--应付账款-暂估进项税
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202003' and accountingyear=@currentYear
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
			price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)
			
			set @money=0
			select @money=sum(money) from @tb_goods where supplier=@supplier
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			--应付账款-暂估应付款
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear
			--print @foot_summary+'，'+cast(@money_tax as varchar(20))+'，'+cast(@money as varchar(20))
				
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where writeoffState=0 and id in(select id from @tb_goods where supplier=@supplier)
			update purchase_th set writeoffState=1 where writeoffState=0 and supplier=@supplier and YEAR(thdate)=@currentYear and MONTH(thdate)=@currentPeriod 
			and dw='广西华纳新材料股份有限公司'
		end

	    FETCH NEXT FROM customer_Cursor INTO @supplier
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_Notinvoiced_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-3-1
-- Description:	未开票凭证（原料）
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_Notinvoiced_ah] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：CBO 242.62 吨+R-90   32吨暂估入账，广州茂钦
	DECLARE @cg_sn nvarchar(50),@supplier nvarchar(100),@goodsname nvarchar(100),@goodsunit nvarchar(50),@amount numeric(18,5)
		,@price numeric(18,5),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@summoney numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@idUnit int
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	DECLARE @tb_goods TABLE(id varchar(50),cg_sn varchar(50),supplier varchar(100),indate DateTime,goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,5),price numeric(18,5),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2))
		
	insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax)
	select id,cg_sn,supplier,indate,dbo.Getcgyl_goodsname(goodsname,'安徽') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'安徽') as goodsunit
	,dbo.Getcg_amountConvert(goodsname,amount,'安徽') as amount,price,[money],money_notax,money_tax  
	from purchase_in b where writeoffState=0 and abs([money])>0 and warehouse<>'五金仓' 
	and year(indate)=@currentYear and month(indate)=@currentPeriod and dw='安徽省宣城市华纳新材料科技有限公司'
	order by supplier,cg_sn
	
	DECLARE customer_Cursor CURSOR FOR select supplier from @tb_goods 
	group by supplier order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_ah @supplier,0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			delete from @tb_head --清空
			set @sequencenumber=1
			set @code='0000'
			
			--获取冲红退货单
			insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax)
			select '-1',cg_sn,supplier,thdate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax 
			from purchase_th where writeoffState=0 and supplier=@supplier and YEAR(thdate)=@currentYear and MONTH(thdate)=@currentPeriod 
			and dw='安徽省宣城市华纳新材料科技有限公司'
			
			--默认摘要
			set @row_summary=''
			set @goodsname=''
			select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier
			DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
			from @tb_goods where [money]>0 and supplier=@supplier
			group by goodsname,goodsunit,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			while @@fetch_status = 0
			begin
				--科目
				select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'安徽')
				select Top 1 @idUnit=id from UFTData305193_300004.dbo.AA_Unit where name=@goodsunit
				set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier
				if @amount=0
				begin
					if @money_notax>0
						set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'运费，'+@supplier
					set @price=null
				end
				else
				begin
					set @price=@money_notax/@amount
				end
				
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
					
				insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--优惠金额
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where [money]<0 and supplier=@supplier
			if abs(@money_notax)>0
			begin
				if @row_summary=''
				begin
					select @amount=amount,@goodsname=goodsname,@goodsunit=goodsunit from @tb_goods where id>0 and [money]<0 and supplier=@supplier
					select @idUnit=id from UFTData305193_300004.dbo.AA_Unit where name=@goodsunit
				end
				set @zk_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'（优惠金额），'+@supplier
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--获取汇总行摘要
			set @foot_summary=''
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				set @foot_summary=@foot_summary+'+'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit
				if @amount=0
					set @foot_summary='+'+@goodsname+'运费'
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @foot_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier --替换第一个'+'字符
			if isnull(@foot_summary,'')='' set @foot_summary=@zk_summary
			--print @foot_summary
			
			select @money_tax=sum(money_tax) from @tb_goods where supplier=@supplier
			--应付账款-暂估进项税
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202003' and accountingyear=@currentYear
			
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
			price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)
			
			set @money=0
			select @money=sum(money) from @tb_goods where supplier=@supplier
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			--应付账款-暂估应付款
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear
				
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_ah @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where writeoffState=0 and id in(select id from @tb_goods where supplier=@supplier)
			update purchase_th set writeoffState=1 where writeoffState=0 and supplier=@supplier and YEAR(thdate)=@currentYear and MONTH(thdate)=@currentPeriod 
			and dw='安徽省宣城市华纳新材料科技有限公司'
		end

	    FETCH NEXT FROM customer_Cursor INTO @supplier
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_Notinvoiced_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2024-3-1
-- Description:	未开票凭证（原料）
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_Notinvoiced_hs] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：CBO 242.62 吨+R-90   32吨暂估入账，广州茂钦
	DECLARE @cg_sn nvarchar(50),@supplier nvarchar(100),@goodsname nvarchar(100),@goodsunit nvarchar(50),@amount numeric(18,5)
		,@price numeric(18,5),@money numeric(18,2),@money_notax numeric(18,2),@money_tax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@summoney numeric(18,2)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@idUnit int
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	DECLARE @tb_goods TABLE(id varchar(50),cg_sn varchar(50),supplier varchar(100),indate DateTime,goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2))
		
	insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax)
	select id,cg_sn,supplier,indate,dbo.Getcgyl_goodsname(goodsname,'合山') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'合山') as goodsunit
	,dbo.Getcg_amountConvert(goodsname,amount,'合山') as amount,price,[money],money_notax,money_tax  
	from purchase_in b where writeoffState=0 and abs([money])>0 and warehouse<>'五金仓' 
	and year(indate)=@currentYear and month(indate)=@currentPeriod and dw='广西合山市华纳新材料科技有限公司'
	order by supplier,cg_sn
	
	DECLARE customer_Cursor CURSOR FOR select supplier from @tb_goods 
	group by supplier order by supplier
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @supplier
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_hs @supplier,0,@currentYear,@currentPeriod,'未开票',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			delete from @tb_head --清空
			set @sequencenumber=1
			set @code='0000'
			
			--获取冲红退货单
			insert into @tb_goods(id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax)
			select '-1',cg_sn,supplier,thdate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax 
			from purchase_th where writeoffState=0 and supplier=@supplier and YEAR(thdate)=@currentYear and MONTH(thdate)=@currentPeriod 
			and dw='广西合山市华纳新材料科技有限公司'
			
			--默认摘要
			set @row_summary=''
			set @goodsname=''
			select Top 1 @goodsname=goodsname from @tb_goods where supplier=@supplier
			DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
			from @tb_goods where [money]>0 and supplier=@supplier
			group by goodsname,goodsunit,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			while @@fetch_status = 0
			begin
				--科目
				select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'合山')
				select Top 1 @idUnit=id from UFTData585087_300003.dbo.AA_Unit where name=@goodsunit
				set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier
				if @amount=0
				begin
					if @money_notax>0
						set @row_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+'运费，'+@supplier
					set @price=null
				end
				else
				begin
					set @price=@money_notax/@amount
				end
				
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
					
				insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--优惠金额
			set @money_notax=0
			select @money_notax=sum(money_notax) from @tb_goods where [money]<0 and supplier=@supplier
			if abs(@money_notax)>0
			begin
				if @row_summary=''
				begin
					select @amount=amount,@goodsname=goodsname,@goodsunit=goodsunit from @tb_goods where id>0 and [money]<0 and supplier=@supplier
					select @idUnit=id from UFTData585087_300003.dbo.AA_Unit where name=@goodsunit
				end
				set @zk_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'（优惠金额），'+@supplier
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_notax,null,@money_notax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			end
			
			--获取汇总行摘要
			set @foot_summary=''
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				set @foot_summary=@foot_summary+'+'+@goodsname++' '+dbo.ClearZero(@amount)+@goodsunit
				if @amount=0
					set @foot_summary='+'+@goodsname+'运费'
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @foot_summary=cast(@currentPeriod as varchar(10))+'月暂估入账'+stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier --替换第一个'+'字符
			if isnull(@foot_summary,'')='' set @foot_summary=@zk_summary
			--print @foot_summary
			
			select @money_tax=sum(money_tax) from @tb_goods where supplier=@supplier
			--应付账款-暂估进项税
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202003' and accountingyear=@currentYear
			
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
			price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)
			
			set @money=0
			select @money=sum(money) from @tb_goods where supplier=@supplier
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			--应付账款-暂估应付款
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202002' and accountingyear=@currentYear
				
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_hs @idDocDTO
				
			--反写采购入库
			update purchase_in set writeoffState=-1 where writeoffState=0 and id in(select id from @tb_goods where supplier=@supplier)
			update purchase_th set writeoffState=1 where writeoffState=0 and supplier=@supplier and YEAR(thdate)=@currentYear and MONTH(thdate)=@currentPeriod 
			and dw='广西合山市华纳新材料科技有限公司'
		end

	    FETCH NEXT FROM customer_Cursor INTO @supplier
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_WriteOffNotinvoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-原料
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_WriteOffNotinvoiced] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年10月31日转字-000273号凭证]对讲机等暂估入账，南宁鑫睿嘉商贸
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100),@goodsunit nvarchar(50)
		,@amount numeric(18,5),@price numeric(18,2),@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@money_zk numeric(18,2),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitydr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int
	DECLARE @doccode nvarchar(30),@voucherdate datetime
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	DECLARE customer_Cursor CURSOR FOR select id,supplier,cg_sn,indate,dbo.Getcgyl_goodsname(goodsname,'广西华纳') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'广西华纳') as goodsunit
	,dbo.Getcg_amountConvert(goodsname,amount,'广西华纳') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and [money]>0 and convert(int,(DATENAME(year,jsrq)+DATENAME(month,jsrq)))>convert(int,(DATENAME(year,indate)+DATENAME(month,indate)))
	and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='广西华纳新材料股份有限公司'
	--and supplier like'%广州茂钦贸易有限公司%'
	order by supplier,kphm,cg_sn
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select @voucher_id=dbo.Getcg_voucherid(@supplier,@supplier,@indate,'广西华纳')
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@cg_sn,@supplier,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
    DECLARE tbgoods_Cursor CURSOR FOR select supplier,kphm from @tb_goods 
    group by supplier,kphm order by supplier
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @supplier,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster @supplier,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=102089
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			delete from @tb_head --清空
			set @sequencenumber=1
			set @code='0000'
			
			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where supplier=@supplier and kphm=@kphm 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				--获取要冲红的之前凭证
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitydr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@voucher_id
				order by idDocDTO,code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					select @doccode=code,@voucherdate=voucherdate from UFTData328464_300011.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转字-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code in(select code from UFTData328464_300011.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear
					
					insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)
					
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
			select '0',id,cg_sn,supplier,indate,dbo.Getcgyl_goodsname(goodsname,'广西华纳') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'广西华纳') as goodsunit
			,dbo.Getcg_amountConvert(goodsname,amount,'广西华纳') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options 
			from purchase_invoiced b where kphm=@kphm and id not in(select id from @tb_goods where kphm=@kphm)
			
			DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
			from @tb_goods where kphm=@kphm and options<>'折扣'
			group by goodsname,goodsunit,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			while @@fetch_status = 0
			begin
				--科目
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'广西华纳')
				select Top 1 @idUnit=id from UFTData328464_300011.dbo.AA_Unit where name=@goodsunit
				set @row_summary='购进'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier+' '+@kphm
				if @amount=0
				begin
					if @money_notax>0
						set @row_summary=@goodsname+'运费，'+@supplier+' '+@kphm
					set @price=null
				end
				else
				begin
					set @price=@money_notax/@amount
				end
								
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
					
				insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣返利
			set @money_zk=0
			select @money_zk=sum(money_notax) from @tb_goods where [money]<0 and kphm=@kphm  and options='折扣'
			if abs(@money_zk)>0
			begin
				set @zk_summary='购进'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'现金折扣，'+@supplier+'  '+@kphm
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			end
			
			--获取汇总行摘要
			set @foot_summary='购进'
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				set @foot_summary=@foot_summary+'+'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit
				if @amount=0
					set @foot_summary='+'+@goodsname+'运费'
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @foot_summary=stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier+' '+@kphm --替换第一个'+'字符
			--print @foot_summary
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from @tb_goods where kphm=@kphm
			if abs(@money_tax)>0
			begin
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			end
			
			select @money=SUM(money) from @tb_goods where kphm=@kphm
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
			--应付账款-应付账款
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and cg_sn in(select cg_sn from @tb_goods where kphm=@kphm)
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where kphm=@kphm)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @supplier,@kphm
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_WriteOffNotinvoiced_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-原料
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_WriteOffNotinvoiced_ah] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年10月31日转字-000273号凭证]对讲机等暂估入账，南宁鑫睿嘉商贸
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100),@goodsunit nvarchar(50)
		,@amount numeric(18,5),@price numeric(18,5),@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@money_zk numeric(18,2),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitydr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int
	DECLARE @doccode nvarchar(30),@voucherdate datetime
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options nvarchar(50))
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)

	DECLARE customer_Cursor CURSOR FOR select id,supplier,cg_sn,indate,dbo.Getcgyl_goodsname(goodsname,'安徽') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'安徽') as goodsunit
	,dbo.Getcg_amountConvert(goodsname,amount,'安徽') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options from purchase_invoiced  
	where writeoffState=0 and abs(money)>0 and convert(int,(DATENAME(year,jsrq)+DATENAME(month,jsrq)))>convert(int,(DATENAME(year,indate)+DATENAME(month,indate)))
	and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='安徽省宣城市华纳新材料科技有限公司'
	--and supplier like'%宣城市正宏木业有限公司%'
	order by supplier,kphm,cg_sn
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select @voucher_id=dbo.Getcg_voucherid(@supplier,@supplier,@indate,'安徽')
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@cg_sn,@supplier,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
    DECLARE tbgoods_Cursor CURSOR FOR select supplier,kphm from @tb_goods 
    group by supplier,kphm order by supplier
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @supplier,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_ah @supplier,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=17114
		if @idDocDTO>0
		begin
			--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			delete from @tb_head --清空
			set @sequencenumber=1
			set @code='0000'
			
			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where supplier=@supplier and kphm=@kphm 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				--获取要冲红的之前凭证
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitydr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@voucher_id
				order by idDocDTO,code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					select @doccode=code,@voucherdate=voucherdate from UFTData305193_300004.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转字2-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code in(select code from UFTData305193_300004.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear
					
					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)
					
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
			select '0',id,cg_sn,supplier,indate,dbo.Getcgyl_goodsname(goodsname,'安徽') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'安徽') as goodsunit
			,dbo.Getcg_amountConvert(goodsname,amount,'安徽') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options 
			from purchase_invoiced b where kphm=@kphm and id not in(select id from @tb_goods where kphm=@kphm)
			
			DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
			from @tb_goods where kphm=@kphm and options<>'折扣'
			group by goodsname,goodsunit,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			while @@fetch_status = 0
			begin
				--科目
				select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'安徽')
				select Top 1 @idUnit=id from UFTData305193_300004.dbo.AA_Unit where name=@goodsunit
				set @row_summary='购进'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier+' '+@kphm
				if @amount=0
				begin
					if @money_notax>0
						set @row_summary=@goodsname+'运费，'+@supplier+' '+@kphm
					set @price=null
				end
				else
				begin
					set @price=@money_notax/@amount
				end
								
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
					
				insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣返利
			set @money_zk=0
			select @money_zk=sum(money_notax) from @tb_goods where [money]<0 and kphm=@kphm  and options='折扣'
			if abs(@money_zk)>0
			begin
				set @zk_summary='购进'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'现金折扣，'+@supplier+'  '+@kphm
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			end
			
			--获取汇总行摘要
			set @foot_summary='购进'
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				set @foot_summary=@foot_summary+'+'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit
				if @amount=0
					set @foot_summary='+'+@goodsname+'运费'
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @foot_summary=stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier+' '+@kphm --替换第一个'+'字符
			--print @foot_summary
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from @tb_goods where kphm=@kphm
			if abs(@money_tax)>0
			begin
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			end
			
			select @money=SUM(money) from @tb_goods where kphm=@kphm
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
			--应付账款-应付账款
			select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_ah @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and cg_sn in(select cg_sn from @tb_goods where kphm=@kphm)
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where kphm=@kphm)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @supplier,@kphm
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_WriteOffNotinvoiced_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-原料
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_WriteOffNotinvoiced_hs] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年10月31日转字-000273号凭证]对讲机等暂估入账，南宁鑫睿嘉商贸
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100),@goodsunit nvarchar(50)
		,@amount numeric(18,5),@price numeric(18,5),@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@money_zk numeric(18,2),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitydr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int
	DECLARE @doccode nvarchar(30),@voucherdate datetime
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)

	DECLARE customer_Cursor CURSOR FOR select id,supplier,cg_sn,indate,dbo.Getcgyl_goodsname(goodsname,'合山') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'合山') as goodsunit
	,dbo.Getcg_amountConvert(goodsname,amount,'合山') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options from purchase_invoiced  
	where writeoffState=0 and abs(money)>0 and convert(int,(DATENAME(year,jsrq)+DATENAME(month,jsrq)))>convert(int,(DATENAME(year,indate)+DATENAME(month,indate)))
	and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='广西合山市华纳新材料科技有限公司'
	order by supplier,kphm,cg_sn
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select @voucher_id=dbo.Getcg_voucherid(@supplier,@supplier,@indate,'合山')
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@cg_sn,@supplier,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
    DECLARE tbgoods_Cursor CURSOR FOR select supplier,kphm from @tb_goods 
    group by supplier,kphm order by supplier
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @supplier,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec cg_AddVoucherMaster_hs @supplier,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=18808
		if @idDocDTO>0
		begin
			--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			delete from @tb_head --清空
			set @sequencenumber=1
			set @code='0000'
			
			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where supplier=@supplier and kphm=@kphm 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				--获取要冲红的之前凭证
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitydr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@voucher_id
				order by idDocDTO,code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					select @doccode=code,@voucherdate=voucherdate from UFTData585087_300003.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转1-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code in(select code from UFTData585087_300003.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear
					
					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)
					
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
			select '0',id,cg_sn,supplier,indate,dbo.Getcgyl_goodsname(goodsname,'合山') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'合山') as goodsunit
			,dbo.Getcg_amountConvert(goodsname,amount,'合山') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options  
			from purchase_invoiced b where kphm=@kphm and id not in(select id from @tb_goods where kphm=@kphm)
			
			DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
			from @tb_goods where kphm=@kphm and options<>'折扣'
			group by goodsname,goodsunit,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			while @@fetch_status = 0
			begin
				--科目
				select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'合山')
				select Top 1 @idUnit=id from UFTData585087_300003.dbo.AA_Unit where name=@goodsunit
				set @row_summary='购进'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier+' '+@kphm
				if @amount=0
				begin
					if @money_notax>0
						set @row_summary=@goodsname+'运费，'+@supplier+' '+@kphm
					set @price=null
				end
				else
				begin
					set @price=@money_notax/@amount
				end
								
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
					
				insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣返利
			set @money_zk=0
			select @money_zk=sum(money_notax) from @tb_goods where [money]<0 and kphm=@kphm  and options='折扣'
			if abs(@money_zk)>0
			begin
				set @zk_summary='购进'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'现金折扣，'+@supplier+'  '+@kphm
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			end
			
			--获取汇总行摘要
			set @foot_summary='购进'
			DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				set @foot_summary=@foot_summary+'+'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit
				if @amount=0
					set @foot_summary='+'+@goodsname+'运费'
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			set @foot_summary=stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier+' '+@kphm --替换第一个'+'字符
			--print @foot_summary
			
			--应交税费-应交增值税-进项税额
			set @money_tax=0
			select @money_tax=SUM(money_tax) from @tb_goods where kphm=@kphm
			if abs(@money_tax)>0
			begin
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
			
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			end
			
			select @money=SUM(money) from @tb_goods where kphm=@kphm
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
			--应付账款-应付账款
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
				
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec cg_InsertVoucherJournal_hs @idDocDTO
			
			--反写采购入库
			update purchase_invoiced set writeoffState=1 where writeoffState=0 and cg_sn in(select cg_sn from @tb_goods where kphm=@kphm)
			update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
			where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where kphm=@kphm)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @supplier,@kphm
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor
        
END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_WriteOffNotinvoicedTwo]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-原料-多票一凭证
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_WriteOffNotinvoicedTwo] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年10月31日转字-000273号凭证]对讲机等暂估入账，南宁鑫睿嘉商贸
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100),@goodsunit nvarchar(50)
		,@amount numeric(18,5),@price numeric(18,2),@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@money_zk numeric(18,2),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitydr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int
	DECLARE @doccode nvarchar(30),@voucherdate datetime
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	DECLARE customer_Cursor CURSOR FOR select id,supplier,cg_sn,indate,dbo.Getcgyl_goodsname(goodsname,'广西华纳') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'广西华纳') as goodsunit
	,dbo.Getcg_amountConvert(goodsname,amount,'广西华纳') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and [money]>0 and convert(int,(DATENAME(year,jsrq)+DATENAME(month,jsrq)))>convert(int,(DATENAME(year,indate)+DATENAME(month,indate)))
	and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='广西华纳新材料股份有限公司'
	order by supplier,kphm,cg_sn
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select @voucher_id=dbo.Getcg_voucherid(@supplier,@supplier,@indate,'广西华纳')
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@cg_sn,@supplier,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
    if exists(select 1 from (select voucher_id,kphm from @tb_goods group by voucher_id,kphm) as t group by voucher_id having COUNT(*)>1)
    begin
		DECLARE voucherid_Cursor CURSOR FOR select voucher_id
		from (select voucher_id,kphm from @tb_goods group by voucher_id,kphm) as t
		group by voucher_id having COUNT(*)>1
		OPEN voucherid_Cursor
		FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
		while @@fetch_status = 0
		begin
			--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
			exec cg_AddVoucherMaster @supplier,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
			--set @idDocDTO=79294
			if @idDocDTO>0
			begin
				--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
				delete from @tb_head --清空
				set @sequencenumber=1
				set @code='0000'
				select Top 1 @supplier=supplier from @tb_goods where voucher_id=@voucher_id

				--获取要冲红的之前凭证
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitydr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@voucher_id
				order by idDocDTO,code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					select @doccode=code,@voucherdate=voucherdate from UFTData328464_300011.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转字-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code in(select code from UFTData328464_300011.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear
						
					insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)
						
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				
				--同发票号码的写一个凭证，获取同发票号的其它销售记录
				insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
				select '0',id,cg_sn,supplier,indate,dbo.Getcgyl_goodsname(goodsname,'广西华纳') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'广西华纳') as goodsunit
				,dbo.Getcg_amountConvert(goodsname,amount,'广西华纳') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options
				from purchase_invoiced b where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and id not in(select id from @tb_goods where voucher_id=@voucher_id)
				
				set @kphm=''
				select @kphm=stuff((select distinct ','+kphm from @tb_goods where voucher_id=@voucher_id for xml path('')),1,1,'')
				
				DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
				from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options not in('折扣')
				group by goodsname,goodsunit,price order by goodsname
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
				while @@fetch_status = 0
				begin
					--科目
					select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'广西华纳')
					select Top 1 @idUnit=id from UFTData328464_300011.dbo.AA_Unit where name=@goodsunit
					set @row_summary='购进'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier+' '+@kphm
					if @amount=0
					begin
						if @money_notax>0
							set @row_summary=@goodsname+'运费，'+@supplier+' '+@kphm
						set @price=null
					end
					else
					begin
						set @price=@money_notax/@amount
					end
									
					insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
						
					insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				--折扣返利
				set @money_zk=0
				select @money_zk=sum(money_notax) from @tb_goods where [money]<0 and kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options='折扣'
				if abs(@money_zk)>0
				begin
					set @zk_summary='购进'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'现金折扣，'+@supplier+' '+@kphm
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
					insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					--print @zk_summary
				end
				
				--获取汇总行摘要
				set @foot_summary='购进'
				DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname
				OPEN headsummary_Cursor
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
				while @@fetch_status = 0
				begin
					set @foot_summary=@foot_summary+'+'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit
					if @amount=0
						set @foot_summary='+'+@goodsname+'运费'
					FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
				end
				CLOSE headsummary_Cursor
				DEALLOCATE headsummary_Cursor
				
				set @foot_summary=stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier+' '+@kphm --替换第一个'+'字符
				--print @foot_summary
							
				--应交税费-应交增值税-进项税额
				set @money_tax=0
				select @money_tax=SUM(money_tax) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				if abs(@money_tax)>0
				begin
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
				
					insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				end
				
				select @money=SUM(money) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
						
				--应付账款-应付账款
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
					
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

				--更新主表金额
				select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
				update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
				,accuamountcr=@summoney where id=@idDocDTO

				--导入明细表
				exec cg_InsertVoucherJournal @idDocDTO
				
				--反写采购入库
				update purchase_invoiced set writeoffState=1 where writeoffState=0 and cg_sn in(select cg_sn from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))
				update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
				where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))
			end
		   FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
		end
		CLOSE voucherid_Cursor
		DEALLOCATE voucherid_Cursor
    end
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_WriteOffNotinvoicedTwo_ah]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-原料-多票一凭证
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_WriteOffNotinvoicedTwo_ah] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年10月31日转字-000273号凭证]对讲机等暂估入账，南宁鑫睿嘉商贸
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100),@goodsunit nvarchar(50)
		,@amount numeric(18,5),@price numeric(18,5),@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@money_zk numeric(18,2),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitydr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int
	DECLARE @doccode nvarchar(30),@voucherdate datetime
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	DECLARE customer_Cursor CURSOR FOR select id,supplier,cg_sn,indate,dbo.Getcgyl_goodsname(goodsname,'安徽') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'安徽') as goodsunit
	,dbo.Getcg_amountConvert(goodsname,amount,'安徽') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and [money]>0 and convert(int,(DATENAME(year,jsrq)+DATENAME(month,jsrq)))>convert(int,(DATENAME(year,indate)+DATENAME(month,indate)))
	and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='安徽省宣城市华纳新材料科技有限公司'
	--and supplier like'%中国石化销售股份有限公司广西南宁石油分公司%'
	order by supplier,kphm,cg_sn
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select @voucher_id=dbo.Getcg_voucherid(@supplier,@supplier,@indate,'安徽')
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@cg_sn,@supplier,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
    if exists(select 1 from (select voucher_id,kphm from @tb_goods group by voucher_id,kphm) as t group by voucher_id having COUNT(*)>1)
    begin
		DECLARE voucherid_Cursor CURSOR FOR select voucher_id
		from (select voucher_id,kphm from @tb_goods group by voucher_id,kphm) as t
		group by voucher_id having COUNT(*)>1
		OPEN voucherid_Cursor
		FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
		while @@fetch_status = 0
		begin
			--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
			exec cg_AddVoucherMaster_ah @supplier,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
			--set @idDocDTO=79294
			if @idDocDTO>0
			begin
				--delete from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
				delete from @tb_head --清空
				set @sequencenumber=1
				set @code='0000'
				select Top 1 @supplier=supplier from @tb_goods where voucher_id=@voucher_id

				--获取要冲红的之前凭证
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitydr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@voucher_id
				order by idDocDTO,code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					select @doccode=code,@voucherdate=voucherdate from UFTData305193_300004.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转字2-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code in(select code from UFTData305193_300004.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear
						
					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)
						
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				
				--同发票号码的写一个凭证，获取同发票号的其它销售记录
				insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
				select '0',id,cg_sn,supplier,indate,dbo.Getcgyl_goodsname(goodsname,'安徽') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'安徽') as goodsunit
				,dbo.Getcg_amountConvert(goodsname,amount,'安徽') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options
				from purchase_invoiced b where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and id not in(select id from @tb_goods where voucher_id=@voucher_id)
				
				set @kphm=''
				select @kphm=stuff((select distinct ','+kphm from @tb_goods where voucher_id=@voucher_id for xml path('')),1,1,'')
				
				DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
				from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options not in('折扣')
				group by goodsname,goodsunit,price,kphm order by goodsname
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
				while @@fetch_status = 0
				begin
					--科目
					select Top 1 @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'安徽')
					select Top 1 @idUnit=id from UFTData305193_300004.dbo.AA_Unit where name=@goodsunit
					set @row_summary='购进'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier+' '+@kphm
					if @amount=0
					begin
						if @money_notax>0
							set @row_summary=@goodsname+'运费，'+@supplier+' '+@kphm
						set @price=null
					end
					else
					begin
						set @price=@money_notax/@amount
					end
									
					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
						
					insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

				--折扣返利
				set @money_zk=0
				select @money_zk=sum(money_notax) from @tb_goods where [money]<0 and kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options='折扣'
				if abs(@money_zk)>0
				begin
					set @zk_summary='购进'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'现金折扣，'+@supplier+' '+@kphm
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					--print @zk_summary
				end
				
				--获取汇总行摘要
				set @foot_summary='购进'
				DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname
				OPEN headsummary_Cursor
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
				while @@fetch_status = 0
				begin
					set @foot_summary=@foot_summary+'+'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit
					if @amount=0
						set @foot_summary='+'+@goodsname+'运费'
					FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
				end
				CLOSE headsummary_Cursor
				DEALLOCATE headsummary_Cursor
				
				set @foot_summary=stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier+' '+@kphm --替换第一个'+'字符
				--print @foot_summary
							
				--应交税费-应交增值税-进项税额
				set @money_tax=0
				select @money_tax=SUM(money_tax) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				if abs(@money_tax)>0
				begin
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
				
					insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				end
				
				select @money=SUM(money) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
						
				--应付账款-应付账款
				select @idaccount=id FROM UFTData305193_300004.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
					
				insert into UFTData305193_300004.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

				--更新主表金额
				select @summoney=sum(isnull(origamountdr,0)) from UFTData305193_300004.dbo.GL_Entry where idDocDTO=@idDocDTO
				update UFTData305193_300004.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
				,accuamountcr=@summoney where id=@idDocDTO

				--导入明细表
				exec cg_InsertVoucherJournal_ah @idDocDTO
				
				--反写采购入库
				update purchase_invoiced set writeoffState=1 where writeoffState=0 and cg_sn in(select cg_sn from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))
				update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
				where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))
			end
		   FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
		end
		CLOSE voucherid_Cursor
		DEALLOCATE voucherid_Cursor
    end
    
END
GO
/****** Object:  StoredProcedure [dbo].[cg_yl_WriteOffNotinvoicedTwo_hs]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证-原料-多票一凭证
-- =============================================
CREATE PROCEDURE [dbo].[cg_yl_WriteOffNotinvoicedTwo_hs] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年10月31日转字-000273号凭证]对讲机等暂估入账，南宁鑫睿嘉商贸
	DECLARE @supplier nvarchar(100),@id nvarchar(50),@cg_sn nvarchar(50),@indate DateTime,@goodsname nvarchar(100),@goodsunit nvarchar(50)
		,@amount numeric(18,5),@price numeric(18,5),@money numeric(18,2),@kphm nvarchar(400),@money_notax numeric(18,2),@money_tax numeric(18,2),@options nvarchar(50)
	DECLARE @row_summary nvarchar(max),@zk_summary nvarchar(max),@foot_summary nvarchar(max),@code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@money_zk numeric(18,2),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitydr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int
	DECLARE @doccode nvarchar(30),@voucherdate datetime
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),cg_sn varchar(50),indate DateTime,supplier varchar(100),goodsname varchar(50),goodsunit varchar(50)
		,amount numeric(18,4),price numeric(18,2),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),options varchar(50))
	
	DECLARE @tb_head TABLE(goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	DECLARE customer_Cursor CURSOR FOR select id,supplier,cg_sn,indate,dbo.Getcgyl_goodsname(goodsname,'合山') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'合山') as goodsunit
	,dbo.Getcg_amountConvert(goodsname,amount,'合山') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options from purchase_invoiced 
	where writeoffState=0 and [money]>0 and convert(int,(DATENAME(year,jsrq)+DATENAME(month,jsrq)))>convert(int,(DATENAME(year,indate)+DATENAME(month,indate)))
	and warehouse<>'五金仓' and options<>'维修' and year(jsrq)=@currentYear and month(jsrq)=@currentPeriod 
	and dw='广西合山市华纳新材料科技有限公司'
	--and supplier like'%中国石化销售股份有限公司广西南宁石油分公司%'
	order by supplier,kphm,cg_sn
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select @voucher_id=dbo.Getcg_voucherid(@supplier,@supplier,@indate,'合山')
		if @voucher_id>0
		begin
			insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
			values(@voucher_id,@id,@cg_sn,@supplier,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options)
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@supplier,@cg_sn,@indate,@goodsname,@goodsunit,@amount,@price,@money,@money_notax,@money_tax,@kphm,@options
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
    if exists(select 1 from (select voucher_id,kphm from @tb_goods group by voucher_id,kphm) as t group by voucher_id having COUNT(*)>1)
    begin
		DECLARE voucherid_Cursor CURSOR FOR select voucher_id
		from (select voucher_id,kphm from @tb_goods group by voucher_id,kphm) as t
		group by voucher_id having COUNT(*)>1
		OPEN tbgoods_Cursor
		FETCH NEXT FROM tbgoods_Cursor INTO @voucher_id
		while @@fetch_status = 0
		begin
			--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
			exec cg_AddVoucherMaster_hs @supplier,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
			--set @idDocDTO=79294
			if @idDocDTO>0
			begin
				--delete from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
				delete from @tb_head --清空
				set @sequencenumber=1
				set @code='0000'
				select Top 1 @supplier=supplier from @tb_goods where voucher_id=@voucher_id

				--获取要冲红的之前凭证
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitydr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@voucher_id
				order by idDocDTO,code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					select @doccode=code,@voucherdate=voucherdate from UFTData585087_300003.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转1-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code in(select code from UFTData585087_300003.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear
						
					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)
						
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitydr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				
				--同发票号码的写一个凭证，获取同发票号的其它销售记录
				insert into @tb_goods(voucher_id,id,cg_sn,supplier,indate,goodsname,goodsunit,amount,price,[money],money_notax,money_tax,kphm,options)
				select '0',id,cg_sn,supplier,indate,dbo.Getcgyl_goodsname(goodsname,'合山') as goodsname,dbo.Getcgyl_Unit(goodsname,goodsunit,'合山') as goodsunit
				,dbo.Getcg_amountConvert(goodsname,amount,'合山') as amount,dbo.Getcgyl_price(id,'开票') as price,[money],money_notax,money_tax,kphm,options
				from purchase_invoiced b where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and id not in(select id from @tb_goods where voucher_id=@voucher_id)
				
				set @kphm=''
				select @kphm=stuff((select distinct ','+kphm from @tb_goods where voucher_id=@voucher_id for xml path('')),1,1,'')
				
				DECLARE Entry_Cursor CURSOR FOR select goodsname,goodsunit,price,sum(amount),sum([money_notax]) 
				from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options not in('折扣')
				group by goodsname,goodsunit,price order by goodsname
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
				while @@fetch_status = 0
				begin
					--科目
					select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where accountingyear=@currentYear and code=dbo.Getcg_accountcode(@goodsname,'合山')
					select Top 1 @idUnit=id from UFTData585087_300003.dbo.AA_Unit where name=@goodsunit
					set @row_summary='购进'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'，'+@supplier+' '+@kphm
					if @amount=0
					begin
						if @money_notax>0
							set @row_summary=@goodsname+'运费，'+@supplier+' '+@kphm
						set @price=null
					end
					else
					begin
						set @price=@money_notax/@amount
					end
									
					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@money_notax,null,@money_notax,null,@amount,@price,@sequencenumber,null,@idaccount,4,@idDocDTO,@idUnit)
						
					insert into @tb_head(goodsname,amount)values(@goodsname,@amount) --插入表变量
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@goodsunit,@price,@amount,@money_notax
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				
				--折扣返利
				set @money_zk=0
				select @money_zk=sum(money_notax) from @tb_goods where [money]<0 and kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) and options='折扣'
				if abs(@money_zk)>0
				begin
					set @zk_summary='购进'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit+'现金折扣，'+@supplier+' '+@kphm
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					
					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@zk_summary,1,@money_zk,null,@money_zk,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
					--print @zk_summary
				end
				
				--获取汇总行摘要
				set @foot_summary='购进'
				DECLARE headsummary_Cursor CURSOR FOR select goodsname,sum(amount) from @tb_head group by goodsname
				OPEN headsummary_Cursor
				FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
				while @@fetch_status = 0
				begin
					set @foot_summary=@foot_summary+'+'+@goodsname+' '+dbo.ClearZero(@amount)+@goodsunit
					if @amount=0
						set @foot_summary='+'+@goodsname+'运费'
					FETCH NEXT FROM headsummary_Cursor INTO @goodsname,@amount
				end
				CLOSE headsummary_Cursor
				DEALLOCATE headsummary_Cursor
				
				set @foot_summary=stuff(@foot_summary,patindex('%+%',@foot_summary),1,'')+'，'+@supplier+' '+@kphm --替换第一个'+'字符
				--print @foot_summary
							
				--应交税费-应交增值税-进项税额
				set @money_tax=0
				select @money_tax=SUM(money_tax) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				if abs(@money_tax)>0
				begin
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2221001001' and accountingyear=@currentYear
				
					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitydr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@foot_summary,1,@money_tax,null,@money_tax,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				end
				
				select @money=SUM(money) from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
						
				--应付账款-应付账款
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2202001' and accountingyear=@currentYear
					
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitydr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,null,@money,null,@money,null,null,@sequencenumber,@supplier,@idaccount,4,@idDocDTO,null)

				--更新主表金额
				select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
				update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
				,accuamountcr=@summoney where id=@idDocDTO

				--导入明细表
				exec cg_InsertVoucherJournal_hs @idDocDTO
				
				--反写采购入库
				update purchase_invoiced set writeoffState=1 where writeoffState=0 and cg_sn in(select cg_sn from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))
				update purchase_in set writeoffState=1 from purchase_in a inner join purchase_invoiced b on b.cg_sn=a.cg_sn
				where a.writeoffState<1 and a.cg_sn in(select cg_sn from @tb_goods where kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id))
			end
		   FETCH NEXT FROM tbgoods_Cursor INTO @voucher_id
		end
		CLOSE tbgoods_Cursor
		DEALLOCATE tbgoods_Cursor
    end
    
END
GO
/****** Object:  StoredProcedure [dbo].[GetDocOrderNum]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-01
-- Description:	获取凭证唯一标示号
-- =============================================
CREATE PROCEDURE [dbo].[GetDocOrderNum]
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

	--凭证类别ID=9，AA_DocType.sequencenumber=8
	DECLARE @strNo nvarchar(50),@sql NVARCHAR(4000)
	set @strNo='0001'+cast(@currentYear as nvarchar(20))+isnull(replicate('0',2-len(@currentPeriod)),'')+cast(@currentPeriod as varchar(20))+'0008'
	select @sql=N'if exists(select 1 from UFTData328464_300011.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%'')
	begin
		select @strDocOrderNum=(right(max(DocOrderNum),6)+1) from UFTData328464_300011.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%''
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
/****** Object:  StoredProcedure [dbo].[hs_AddVoucherMaster]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	增加凭证主表，返回id
-- =============================================
CREATE PROCEDURE [dbo].[hs_AddVoucherMaster] 
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
	exec hs_GetDocOrderNum @currentYear,@currentPeriod,@strDocOrderNum output

	select @idPeriod=id FROM UFTData585087_300003.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod
	
	select @voucherdate=cast(@currentYear as varchar(10))+'-'+cast(@currentPeriod as varchar(10))+'-'+cast(day(getdate()) as varchar(10))--当天
	if Convert(DateTime,Convert(varchar(10),getdate(),120))>@voucherdate	
		SELECT  @voucherdate=convert(varchar(10),dateadd(month, datediff(month, -1, @voucherdate), -1),120) --当月最后一天
		
	select @sql=N'
		insert UFTData585087_300003.dbo.GL_Doc(code, [name], accuorigamountdr, accuorigamountcr, accuamountdr, accuamountcr, iscashieraudit
		,ispost, iserror, isinvalidate, iscashflowed, isquantitydoc, isforeigncurrencydoc 
		,accountingperiod, accountingyear, maker, iscarriedforwardout, iscarriedforwardin, ismodifiedcode
		,isCashierDoc, DocOrderNum, PrintCount, isCashflowByHand, iddoctype, cashflowedstate, docbusinesstype
		,invalidateState, makeErrorState, voucherstate, makerid, idperiod, voucherdate, madedate, createdtime,IdMarketingOrgan)
		values('''+right(@strDocOrderNum,6)+''','''','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+','+cast(@summoney as varchar(20))+',0,0,0,0,0,1
		,0,'+cast(@currentPeriod as varchar(10))+','+cast(@currentYear as varchar(10))+',''马情情'',0,0,0
		,0,'''+@strDocOrderNum+''',0,0,7,655,625,682,679,181,88,'+cast(@idPeriod as varchar(30))+','''+@voucherdate+''',Convert(varchar(10),getdate(),120),getdate(),1) 
		select @idDocDTO=@@identity'
	
	--print @sql
	EXEC sp_executesql @sql,N'@idDocDTO int out',@idDocDTO OUT
END
GO
/****** Object:  StoredProcedure [dbo].[hs_GetDocOrderNum]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-01
-- Description:	获取凭证唯一标示号
-- =============================================
CREATE PROCEDURE [dbo].[hs_GetDocOrderNum]
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

	--凭证类别ID=9，AA_DocType.sequencenumber=8
	DECLARE @strNo nvarchar(50),@sql NVARCHAR(4000)
	set @strNo='0001'+cast(@currentYear as nvarchar(20))+isnull(replicate('0',2-len(@currentPeriod)),'')+cast(@currentPeriod as varchar(20))+'0006'
	select @sql=N'if exists(select 1 from UFTData585087_300003.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%'')
	begin
		select @strDocOrderNum=(right(max(DocOrderNum),6)+1) from UFTData585087_300003.dbo.GL_Doc where DocOrderNum like '''+@strNo+'%''
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
/****** Object:  StoredProcedure [dbo].[hs_InsertGiveAndPc]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	赠送、磅差
-- =============================================
CREATE PROCEDURE [dbo].[hs_InsertGiveAndPc] 
(
	@idDocDTO int,   --凭证id
	@kphm nvarchar(400), --发票号码
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	declare @code nvarchar(10),@sequencenumber int,@idaccount int,@Customer nvarchar(100)
	declare @goodsname nvarchar(100),@amount numeric(18,4),@money numeric(18,2)
		,@row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max)
		
	select TOP 1 @code=a.code,@sequencenumber=a.sequencenumber from UFTData585087_300003.dbo.GL_Doc b inner join UFTData585087_300003.dbo.GL_Entry a on a.idDocDTO=b.id
	where a.idDocDTO=@idDocDTO order by a.code desc
	
	if @idDocDTO>0 and @kphm<>''
	begin
		select Top 1 @Customer=customer from tb_invoiced where kphm=@kphm
		--赠送
		if exists(select 1 from sale_fh where writeoffState=0 and amount>0 and money=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm))
		begin
			set @head_summary='赠送'
			--销售费用-其他
			select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='6601099' and accountingyear=@currentYear
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'赠送第一行',1,0,null,0,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--明细
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,sum(amount) from v_sale_fh 
			where writeoffState=0 and amount>0 and money=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
			group by goodscategory order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where name like'%'+@goodsname+'%' and code like'1405%' and accountingyear=@currentYear --库存商品-CCS系列-P180

				set @row_summary='赠送'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer
				set @head_summary=@head_summary+'+'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
						
			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@customer
			set @foot_summary=@head_summary
			select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='2221001003' and accountingyear=@currentYear --应交税费-应交增值税-销项税额
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,null,null,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新第一行摘要
			update UFTData585087_300003.dbo.GL_Entry set summary=@head_summary,origamountdr=null,amountdr=null 
			where idDocDTO=@idDocDTO and summary='赠送第一行'
		
			--反更新销售出库单
			update sale_fh set writeoffState=1 where writeoffState=0 and amount>0 and money=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
		end

		--磅差
		if exists(select 1 from sale_pc where writeoffState=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm))
		begin
			set @head_summary='磅差'
			--销售费用-其他
			select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='6601099' and accountingyear=@currentYear
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'磅差第一行',1,0,null,0,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--明细
			DECLARE Entry_Cursor CURSOR FOR select dbo.DelChinese(goodsname) goodsname,sum(amount) from sale_pc 
			where writeoffState=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
			group by dbo.DelChinese(goodsname) order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where name like'%'+@goodsname+'%' and code like'1405%' and accountingyear=@currentYear --库存商品-CCS系列-P180

				set @row_summary='磅差'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer
				set @head_summary=@head_summary+'+'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			
			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer
			--更新第一行摘要
			update UFTData585087_300003.dbo.GL_Entry set summary=@head_summary,origamountdr=null,amountdr=null 
			where idDocDTO=@idDocDTO and summary='磅差第一行'
		
			--反更新磅差处理单
			update sale_pc set writeoffState=1 where writeoffState=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
		end
	end
	else if @kphm=''
	begin
		select @Customer=replace(AuxiliaryItems,'01','') from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO and AuxiliaryItems is not null
		set @head_summary='磅差'
		--销售费用-其他
		select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code='6601099' and accountingyear=@currentYear
		set @sequencenumber=@sequencenumber+1
		set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
		insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
		, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
		values(@code,'磅差第一行',1,0,null,0,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

		--明细
		DECLARE Entry_Cursor CURSOR FOR select dbo.DelChinese(goodsname) goodsname,sum(amount) from sale_pc 
		where writeoffState=0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod and dw='广西合山市华纳新材料科技有限公司'
		group by dbo.DelChinese(goodsname) order by goodsname
		OPEN Entry_Cursor
		FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
		while @@fetch_status = 0
		begin
			--分录表
			select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where name like'%'+@goodsname+'%' and code like'1405%' and accountingyear=@currentYear --库存商品-CCS系列-P180

			set @row_summary='磅差'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer
			set @head_summary=@head_summary+'+'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

			--print @row_summary
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
		end
		CLOSE Entry_Cursor
		DEALLOCATE Entry_Cursor
			
		set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer
		--更新第一行摘要
		update UFTData585087_300003.dbo.GL_Entry set summary=@head_summary,origamountdr=null,amountdr=null 
		where idDocDTO=@idDocDTO and summary='磅差第一行'
		
		--反更新磅差处理单
		update sale_pc set writeoffState=1 where writeoffState=0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod and dw='广西合山市华纳新材料科技有限公司'
	end
END
GO
/****** Object:  StoredProcedure [dbo].[hs_InsertVoucherJournal]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-02
-- Description:	从分录表获取数据，插入凭证明细表
-- =============================================
CREATE PROCEDURE [dbo].[hs_InsertVoucherJournal] 
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

	select @docno=code,@currentYear=accountingyear,@currentPeriod=accountingperiod,@voucherdate=voucherdate from UFTData585087_300003.dbo.GL_Doc where id=@idDocDTO
	select @idaccountingperiod=id FROM UFTData585087_300003.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod --会计期间ID
	
	--删除所有
	delete from UFTData585087_300003.dbo.GL_AuxiliaryInfo where DocId=@idDocDTO
	delete from UFTData585087_300003.dbo.GL_Journal where DocId=@idDocDTO
	
	DECLARE Journal_Cursor CURSOR FOR select id,code,summary,origamountdr,origamountcr,amountdr,amountcr,quantitycr,price,sequencenumber,AuxiliaryItems,idaccount,idUnit 
	from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO order by sequencenumber
	OPEN Journal_Cursor
    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    while @@fetch_status = 0
    begin	
		--插入辅助信息DTO
		if @AuxiliaryItems is not null or @idUnit is not null
		begin
			select @idauxAccCustomer=id from UFTData585087_300003.dbo.AA_Partner where [name]=@AuxiliaryItems
			insert into UFTData585087_300003.[dbo].[GL_AuxiliaryInfo](exchangerate,idauxAccCustomer,DocId,idEntryDTO)
			values(1.0,@idauxAccCustomer,@idDocDTO,@id)
			select @auxiliaryinfoid=@@identity
		end

		set @direction=652  --借方
		if @amountcr is not null
			set @direction=653  --贷方
		if not exists(select 1 from UFTData585087_300003.dbo.[GL_Journal] where docid=@idDocDTO and entryid=@id)
		begin
			insert into UFTData585087_300003.[dbo].[GL_Journal](docno, rowno, summary, maker, exchangerate, price
			,iscarriedforwardout, iscarriedforwardin, sequencenumber, ispost, [year], currentperiod, quantityCr
			,amountDr, amountCr, origAmountDr, OrigAmountCr, isPeriodBegin,DocDrCrType, idaccount, idcurrency, idDocType
			,idauxAccCustomer,direction, makerId, docid, entryid, auxiliaryinfoid, idaccountingperiod, madedate, idUnit,IdMarketingOrgan)
			values(@docno,@code,@summary,'马情情',1,@price,0,0,@sequencenumber,0,@currentYear,@currentPeriod,@quantitycr,@amountdr,@amountcr,@origamountdr,@origamountcr
			,0,22,@idaccount,4,7,@idauxAccCustomer,@direction,88,@idDocDTO,@id,@auxiliaryinfoid,@idaccountingperiod,@voucherdate,@idUnit,1)

		end
	    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    end
    CLOSE Journal_Cursor
    DEALLOCATE Journal_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[hs_Invoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	已开票凭证，每隔3天执行
-- =============================================
CREATE PROCEDURE [dbo].[hs_Invoiced] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：销售CCS-25  28.4T  保光（天津）  01184714,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4),@money numeric(18,2)
		,@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2),@docTitle nvarchar(60)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	
	DECLARE @tb_goods TABLE(name varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)

	DECLARE customer_Cursor CURSOR FOR select customer,kphm from v_invoiced where writeoffState=0 and isnull(options,'')='' and [money]>0 and kprq is not null 
	and year(fhrq)=year(kprq) and month(fhrq)=month(kprq) and year(kprq)=@currentYear and month(kprq)=@currentPeriod 
	and dw='广西合山市华纳新材料科技有限公司'
	group by customer,kphm order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@kphm
    while @@fetch_status = 0
    begin
		set @docTitle='已开票'
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec hs_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,@docTitle,@idDocDTO output
		--print @idDocDTO
		if @idDocDTO>0
		begin
			set @sequencenumber=1
			set @code='0000'
			set @head_summary='销售' --第一行汇总
			--第一行科目表
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code=dbo.GetFirstRowAccName_hs(@Customer) and accountingyear=@currentYear and isEndNode=1 and IsAux=1

			delete from @tb_goods  --清空数据

			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@head_summary,1,0,null,0,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) from v_invoiced 
			where writeoffState=0 and isnull(options,'')='' and [money]>0  and customer=@Customer and kphm=@kphm 
			and kprq is not null and year(fhrq)=year(kprq) and month(fhrq)=month(kprq) and year(kprq)=@currentYear and month(kprq)=@currentPeriod
			and dw='广西合山市华纳新材料科技有限公司'
			group by goodscategory,price order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where name=@goodsname and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,2)

				--print @row_summary
				insert into @tb_goods([name],amount)values(replace(@goodsname,'(1)',''),@amount) --插入表变量

				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣,返利
			set @money=0
			set @moneyNotax=0
			set @moneyTax=0
			select @money=SUM([money]),@moneyNotax=SUM(money_notax),@moneyTax=SUM(money_tax) from tb_invoiced 
			where options in('折扣','返利') and dw='广西合山市华纳新材料科技有限公司' and kphm=@kphm
			if ABS(@money)>0 or ABS(@moneyNotax)>0
			begin
				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T折扣'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --减去税额13%
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData598373_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,2)
				
				update tb_invoiced set writeoffState=1 where options in('折扣','返利') and dw='广西合山市华纳新材料科技有限公司' and kphm=@kphm
			end
			
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select [name],sum(amount) from @tb_goods group by [name] 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			--尾行汇总
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+'  '+@kphm --替换第一个'+'字符
			
			select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新第一行摘要
			update UFTData585087_300003.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and sequencenumber=1

			--赠送磅差
			exec hs_InsertGiveAndPc @idDocDTO,@kphm,@currentYear,@currentPeriod
			
			update UFTData585087_300003.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO and origamountdr is null
			 and AuxiliaryItems is not null and exists(select 1 from UFTData585087_300003.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')
			
			--更新主表金额
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@amountdr_total, accuorigamountcr=@amountdr_total, accuamountdr=@amountdr_total
			, accuamountcr=@amountdr_total where id=@idDocDTO

			--导入明细表
			exec hs_InsertVoucherJournal @idDocDTO

			--反更新简道云销售发货表
			update tb_invoiced set writeoffState=1 where writeoffState=0 and customer=@Customer and kphm=@kphm 
			and dw='广西合山市华纳新材料科技有限公司'
			update sale_fh set writeoffState=1 from sale_fh a inner join tb_invoiced b on b.xs_sn=a.xs_sn
			where a.writeoffState=0 and a.customer=@Customer and a.xs_sn in(select xs_sn from tb_invoiced where customer=@Customer and kphm=@kphm)
			and a.dw='广西合山市华纳新材料科技有限公司'
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[hs_Notinvoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	上月未开票凭证，每月最后一天或次月1号执行
-- =============================================
CREATE PROCEDURE [dbo].[hs_Notinvoiced] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要为XX月未开票XXX产品XX吨客户名称,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@summoney numeric(12,2),@goodsname nvarchar(100),@price numeric(10,2),@amount numeric(18,4),@money numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@strTemp nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@th_id int, @amount_th numeric(18,4),@money_th numeric(18,2)

	DECLARE @tb_goods TABLE(goodscategory varchar(50),goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	DECLARE customer_Cursor CURSOR FOR select customer,sum(money) from v_sale_fh where writeoffState=0 and [money]>0 
	and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod
	and dw='广西合山市华纳新材料科技有限公司'
	group by customer order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    while @@fetch_status = 0
    begin
		if not exists(select 1 from UFTData585087_300003.dbo.GL_Entry a inner join UFTData585087_300003.dbo.GL_Doc b on b.id=a.idDocDTO 
			where b.accountingyear=@currentYear and b.accountingperiod=@currentPeriod and b.iddoctype=7  
			and a.summary like cast(@currentPeriod as varchar(2))+'月未开票' and a.AuxiliaryItems like @Customer +'%')
		begin
			--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
			exec hs_AddVoucherMaster @Customer,@summoney,@currentYear,@currentPeriod,'未开票',@idDocDTO output
			--print @idDocDTO
			if @idDocDTO>0
			begin
				set @sequencenumber=1
				set @code='0000'
				set @head_summary=cast(@currentPeriod as varchar(10))+'月未开票' --第一行汇总
				--第一行科目表
				select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code=dbo.GetFirstRowAccName_hs(@Customer) and accountingyear=@currentYear and isEndNode=1 and IsAux=1

				delete from @tb_goods  --清空数据

				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@head_summary,1,@summoney,null,@summoney,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

				set @amountcr_total=0  --贷方金额
				set @amountdr_total=0  --借方金额
				DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,sum(amount),sum([money]) 
				from v_sale_fh where writeoffState=0 and [money]>0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod 
				and dw='广西合山市华纳新材料科技有限公司'
				group by goodscategory,price order by goodscategory
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
				while @@fetch_status = 0
				begin
					--分录表
					select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where name=@goodsname and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

					DECLARE th_Cursor CURSOR FOR select id,amount,[money]
					from sale_th where writeoffState=0 and customer=@Customer and dbo.DelChinese(goodsname)=dbo.DelChinese(@goodsname) and price=@price and year(thrq)=@currentYear and month(thrq)=@currentPeriod 
					order by thrq
					OPEN th_Cursor
					FETCH NEXT FROM th_Cursor INTO @th_id,@amount_th,@money_th
					while @@fetch_status = 0
					begin
						if @amount>0
						begin
							set @amount=@amount-@amount_th
							set @money=@money-@money_th
							update sale_th set writeoffState=1 where id=@th_id
						end
						FETCH NEXT FROM th_Cursor INTO @th_id,@amount_th,@money_th
					end
					CLOSE th_Cursor
					DEALLOCATE th_Cursor
					
					set @row_summary=cast(@currentPeriod as varchar(10))+'月未开票'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer
					set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
					set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
					set @amountdr_total=@amountdr_total+@money  --借方金额
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,2)

					insert into @tb_goods(goodscategory, goodsname,amount)values(@goodsname,@goodsname,@amount) --插入表变量

					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

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

				set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer --替换第一个'+'字符
				--尾行汇总
				select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,round((@amountdr_total-@amountcr_total),2),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				--print @head_summary
				--更新第一行摘要
				update UFTData585087_300003.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
				where idDocDTO=@idDocDTO and sequencenumber=1

				--赠送磅差
				exec hs_InsertGiveAndPc @idDocDTO,'',@currentYear,@currentPeriod
				
				update UFTData585087_300003.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO and origamountdr is null
				and AuxiliaryItems is not null and exists(select 1 from UFTData585087_300003.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')

				--更新主表金额
				update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@amountdr_total, accuorigamountcr=@amountdr_total, accuamountdr=@amountdr_total
				, accuamountcr=@amountdr_total where id=@idDocDTO

				--导入明细表
				exec hs_InsertVoucherJournal @idDocDTO
				
				--反写销售出库
				update sale_fh set writeoffState=-1 where writeoffState=0 and [money]>0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod
				and dw='广西合山市华纳新材料科技有限公司'
			end
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[hs_WriteOffNotinvoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[hs_WriteOffNotinvoiced] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年4月30日转2-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@id nvarchar(50),@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@updateRow int,@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@rowmoney numeric(12,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@accountyear int,@accountperiod int
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),xs_sn varchar(50),fhrq DateTime,customer varchar(100),goodscategory varchar(50),goodsname varchar(50)
		,price numeric(18,2),amount numeric(18,4),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400))
	DECLARE @tb_voucherid TABLE(voucher_id int)
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50),@entry_summary nvarchar(max),@goodscategory varchar(50)
	
	DECLARE customer_Cursor CURSOR FOR select id,Customer,xs_sn,fhrq,goodscategory,price,amount,[money],kphm,money_notax,money_tax from v_invoiced 
	where writeoffState=0 and money>0 and options<>'冲红' and convert(int,(DATENAME(year,kprq)+DATENAME(month,kprq)))>convert(int,(DATENAME(year,fhrq)+DATENAME(month,fhrq)))
	and year(kprq)=@currentYear and month(kprq)=@currentPeriod and dw='广西合山市华纳新材料科技有限公司'
	--and customer='瑞安市宁一化工贸易有限公司'
	order by customer,kphm,fhrq,goodscategory
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@moneyNotax,@moneyTax
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select Top 1 @voucher_id=b.id from UFTData585087_300003.dbo.GL_Doc b inner join UFTData585087_300003.dbo.GL_Entry a on a.idDocDTO=b.id
		where accountingyear=year(@fhrq) and accountingperiod=month(@fhrq) and iddoctype=7 
		and a.summary like CAST(accountingperiod as varchar(10))+'月%未开票%' and a.AuxiliaryItems like @Customer+'%'
		order by b.madedate
		if @voucher_id>0
		begin
			if not exists(select 1 from @tb_goods where id=@id)
			begin
				insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodscategory,goodsname,price,amount,[money],money_notax,money_tax,kphm)
				values(@voucher_id,@id,@xs_sn,@Customer,@fhrq,replace(@goodsname,'(1)',''),@goodsname,@price,@amount,@money,@moneyNotax,@moneyTax,@kphm)
			end
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@moneyNotax,@moneyTax
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
		exec hs_AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=79294
		if @idDocDTO>0
		begin
			set @sequencenumber=1
			set @code='0000'
			
			--获取要冲红的之前凭证
			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where customer=@Customer and kphm=@kphm 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				delete from @tb_voucherid  --清除
				select @accountyear=accountingyear,@accountperiod=accountingperiod from UFTData585087_300003.dbo.GL_Doc where id=@voucher_id
				insert into @tb_voucherid(voucher_id)
				select distinct b.id from UFTData585087_300003.dbo.GL_Doc b inner join UFTData585087_300003.dbo.GL_Entry a on a.idDocDTO=b.id
				where accountingyear=@accountyear and accountingperiod=@accountperiod and iddoctype=7 
				and a.summary like CAST(accountingperiod as varchar(10))+'月%未开票%' and a.AuxiliaryItems like @Customer+'%'
				--select * from @tb_voucherid
				
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitycr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData585087_300003.dbo.GL_Entry where idDocDTO in(select voucher_id from @tb_voucherid) 
				order by idDocDTO,code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					select @doccode=code,@voucherdate=voucherdate from UFTData585087_300003.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转2-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code in(select code from UFTData585087_300003.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear
				
					insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)

					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					set @sequencenumber=@sequencenumber+1
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodscategory,goodsname,price,amount,[money],money_notax,money_tax,kphm)
			select '0',id,xs_sn,Customer,fhrq,replace(goodscategory,'(1)',''),goodscategory,price,amount,[money],money_notax,money_tax,kphm 
			from v_invoiced b where kphm=@kphm and ISNULL(options,'')='' and id not in(select id from @tb_goods where kphm=@kphm)
			and not exists(select 1 from @tb_goods where id=b.id)

			set @updateRow=@sequencenumber		
			set @head_summary='销售' --第一行汇总
			--第一行科目表
			select @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where code=dbo.GetFirstRowAccName_hs(@Customer) and accountingyear=@currentYear and isEndNode=1 and IsAux=1
			
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@head_summary,1,2,null,2,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from @tb_goods where customer=@Customer and kphm=@kphm
			group by goodsname,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where name=@goodsname and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='销售'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,2)
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣,返利
			set @money=0
			set @moneyNotax=0
			set @moneyTax=0
			select @money=SUM([money]),@moneyNotax=SUM(money_notax),@moneyTax=SUM(money_tax) from tb_invoiced 
			where options in('折扣','返利') and dw='广西合山市华纳新材料科技有限公司' and kphm=@kphm
			if ABS(@money)>0 or ABS(@moneyNotax)>0
			begin
				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T折扣'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --减去税额13%
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,2)
				
				update tb_invoiced set writeoffState=1 where options in('折扣','返利') and dw='广西合山市华纳新材料科技有限公司' and kphm=@kphm
			end
			
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodscategory,sum(amount) from @tb_goods 
			where customer=@Customer and kphm=@kphm 
			group by goodscategory order by goodscategory
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+'  '+@kphm --替换第一个'+'字符
			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData585087_300003.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			
			insert into UFTData585087_300003.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,@moneyTax_total,null,null,@sequencenumber+1,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新销售第一行摘要
			update UFTData585087_300003.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and sequencenumber=@updateRow

			--赠送磅差
			exec hs_InsertGiveAndPc @idDocDTO,@kphm,@currentYear,@currentPeriod
			
			update UFTData585087_300003.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO and origamountdr is null
			and AuxiliaryItems is not null and exists(select 1 from UFTData585087_300003.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')
			
			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData585087_300003.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData585087_300003.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec hs_InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update tb_invoiced set writeoffState=1 where writeoffState=0 and options<>'冲红' and xs_sn in(select xs_sn from @tb_goods where kphm=@kphm)
			update sale_fh set writeoffState=1 from sale_fh a inner join tb_invoiced b on b.xs_sn=a.xs_sn
			where a.writeoffState<1 and a.xs_sn in(select xs_sn from @tb_goods where kphm=@kphm)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@kphm
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[InsertGiveAndPc]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	赠送、磅差
-- =============================================
CREATE PROCEDURE [dbo].[InsertGiveAndPc] 
(
	@idDocDTO int,   --凭证id
	@kphm nvarchar(400), --发票号码
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	declare @code nvarchar(10),@sequencenumber int,@idaccount int,@Customer nvarchar(100)
	declare @goodsname nvarchar(100),@amount numeric(18,4),@money numeric(18,2)
		,@row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max)
		
	select TOP 1 @code=a.code,@sequencenumber=a.sequencenumber from UFTData328464_300011.dbo.GL_Doc b inner join UFTData328464_300011.dbo.GL_Entry a on a.idDocDTO=b.id
	where a.idDocDTO=@idDocDTO order by a.code desc
	
	if @idDocDTO>0 and @kphm<>''
	begin
		select Top 1 @Customer=customer from tb_invoiced where kphm=@kphm
		--赠送
		if exists(select 1 from sale_fh where writeoffState=0 and amount>0 and money=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm))
		begin
			set @head_summary='赠送'
			--销售费用-其他
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='6601099' and accountingyear=@currentYear
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'赠送第一行',1,0,null,0,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--明细
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,sum(amount) from v_sale_fh 
			where writeoffState=0 and amount>0 and money=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
			group by goodscategory order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name like'%'+@goodsname+'%' and code like'1405%' and accountingyear=@currentYear --库存商品-CCS系列-P180

				set @row_summary='赠送'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer
				set @head_summary=@head_summary+'+'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
						
			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@customer
			set @foot_summary=@head_summary
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='2221001003' and accountingyear=@currentYear --应交税费-应交增值税-销项税额
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,null,null,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新第一行摘要
			update UFTData328464_300011.dbo.GL_Entry set summary=@head_summary,origamountdr=null,amountdr=null 
			where idDocDTO=@idDocDTO and summary='赠送第一行'
		
			--反更新销售出库单
			update sale_fh set writeoffState=1 where writeoffState=0 and amount>0 and money=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
		end

		--磅差
		if exists(select 1 from sale_pc where writeoffState=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm))
		begin
			set @head_summary='磅差'
			--销售费用-其他
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='6601099' and accountingyear=@currentYear
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'磅差第一行',1,0,null,0,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

			--明细
			DECLARE Entry_Cursor CURSOR FOR select dbo.DelChinese(goodsname) goodsname,sum(amount) from sale_pc 
			where writeoffState=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
			group by dbo.DelChinese(goodsname) order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name like'%'+@goodsname+'%' and code like'1405%' and accountingyear=@currentYear --库存商品-CCS系列-P180

				set @row_summary='磅差'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer
				set @head_summary=@head_summary+'+'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			
			set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer
			--更新第一行摘要
			update UFTData328464_300011.dbo.GL_Entry set summary=@head_summary,origamountdr=null,amountdr=null 
			where idDocDTO=@idDocDTO and summary='磅差第一行'
		
			--反更新磅差处理单
			update sale_pc set writeoffState=1 where writeoffState=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
		end
	end
	else if @kphm=''
	begin
		select @Customer=replace(AuxiliaryItems,'01','') from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO and AuxiliaryItems is not null
		set @head_summary='磅差'
		--销售费用-其他
		select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code='6601099' and accountingyear=@currentYear
		set @sequencenumber=@sequencenumber+1
		set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
		insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
		, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
		values(@code,'磅差第一行',1,0,null,0,null,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)

		--明细
		DECLARE Entry_Cursor CURSOR FOR select dbo.DelChinese(goodsname) goodsname,sum(amount) from sale_pc 
		where writeoffState=0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod and dw='广西华纳新材料股份有限公司'
		group by dbo.DelChinese(goodsname) order by goodsname
		OPEN Entry_Cursor
		FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
		while @@fetch_status = 0
		begin
			--分录表
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name like'%'+@goodsname+'%' and code like'1405%' and accountingyear=@currentYear --库存商品-CCS系列-P180

			set @row_summary='磅差'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer
			set @head_summary=@head_summary+'+'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,null,null,null,@amount,null,@sequencenumber,null,@idaccount,4,@idDocDTO,1)

			--print @row_summary
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@amount
		end
		CLOSE Entry_Cursor
		DEALLOCATE Entry_Cursor
			
		set @head_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer
		--更新第一行摘要
		update UFTData328464_300011.dbo.GL_Entry set summary=@head_summary,origamountdr=null,amountdr=null 
		where idDocDTO=@idDocDTO and summary='磅差第一行'
		
		--反更新磅差处理单
		update sale_pc set writeoffState=1 where writeoffState=0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod and dw='广西华纳新材料股份有限公司'
	end
END
GO
/****** Object:  StoredProcedure [dbo].[InsertVoucherJournal]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-06-02
-- Description:	从分录表获取数据，插入凭证明细表
-- =============================================
CREATE PROCEDURE [dbo].[InsertVoucherJournal] 
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

	select @docno=code,@currentYear=accountingyear,@currentPeriod=accountingperiod,@voucherdate=voucherdate from UFTData328464_300011.dbo.GL_Doc where id=@idDocDTO
	select @idaccountingperiod=id FROM UFTData328464_300011.[dbo].[SM_Period] where currentyear=@currentYear and currentperiod=@currentPeriod --会计期间ID
	
	--删除所有
	delete from UFTData328464_300011.dbo.GL_AuxiliaryInfo where DocId=@idDocDTO
	delete from UFTData328464_300011.dbo.GL_Journal where DocId=@idDocDTO
	
	DECLARE Journal_Cursor CURSOR FOR select id,code,summary,origamountdr,origamountcr,amountdr,amountcr,quantitycr,price,sequencenumber,AuxiliaryItems,idaccount,idUnit 
	from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO order by sequencenumber
	OPEN Journal_Cursor
    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    while @@fetch_status = 0
    begin	
		--插入辅助信息DTO
		if @AuxiliaryItems is not null or @idUnit is not null
		begin
			select @idauxAccCustomer=id from UFTData328464_300011.dbo.AA_Partner where [name]=@AuxiliaryItems
			insert into UFTData328464_300011.[dbo].[GL_AuxiliaryInfo](exchangerate,idauxAccCustomer,DocId,idEntryDTO)
			values(1.0,@idauxAccCustomer,@idDocDTO,@id)
			select @auxiliaryinfoid=@@identity
		end

		set @direction=652  --借方
		if @amountcr is not null
			set @direction=653  --贷方
		if not exists(select 1 from UFTData328464_300011.dbo.[GL_Journal] where docid=@idDocDTO and entryid=@id)
		begin
			insert into UFTData328464_300011.[dbo].[GL_Journal](docno, rowno, summary, maker, exchangerate, price
			,iscarriedforwardout, iscarriedforwardin, sequencenumber, ispost, [year], currentperiod, quantityCr
			,amountDr, amountCr, origAmountDr, OrigAmountCr, isPeriodBegin,DocDrCrType, idaccount, idcurrency, idDocType
			,idauxAccCustomer,direction, makerId, docid, entryid, auxiliaryinfoid, idaccountingperiod, madedate, idUnit,IdMarketingOrgan)
			values(@docno,@code,@summary,'赵健廷',1,@price,0,0,@sequencenumber,0,@currentYear,@currentPeriod,@quantitycr,@amountdr,@amountcr,@origamountdr,@origamountcr
			,0,22,@idaccount,4,9,@idauxAccCustomer,@direction,124,@idDocDTO,@id,@auxiliaryinfoid,@idaccountingperiod,@voucherdate,@idUnit,1)

		end
	    FETCH NEXT FROM Journal_Cursor INTO @id,@code,@summary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@price,@sequencenumber,@AuxiliaryItems,@idaccount,@idUnit
    end
    CLOSE Journal_Cursor
    DEALLOCATE Journal_Cursor
END
GO
/****** Object:  StoredProcedure [dbo].[Invoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	已开票凭证，每隔3天执行
-- =============================================
CREATE PROCEDURE [dbo].[Invoiced] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：销售CCS-25  28.4T  保光（天津）  01184714,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4),@money numeric(18,2)
		,@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2),@docTitle nvarchar(60)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	
	DECLARE @tb_goods TABLE(name varchar(100), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)

	DECLARE customer_Cursor CURSOR FOR select customer,kphm from v_invoiced where writeoffState=0 and isnull(options,'')='' and [money]>0  
	and year(fhrq)=year(kprq) and month(fhrq)=month(kprq) and year(kprq)=@currentYear and month(kprq)=@currentPeriod 
	and dw='广西华纳新材料股份有限公司'
	group by customer,kphm order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@kphm
    while @@fetch_status = 0
    begin
		set @docTitle='已开票'
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,@docTitle,@idDocDTO output
		--set @idDocDTO=89155
		if @idDocDTO>0
		begin
			set @sequencenumber=1
			set @code='0000'
			set @head_summary='销售' --第一行汇总
			--科目表
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1

			delete from @tb_goods  --清空数据

			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@head_summary,1,0,null,0,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) from v_invoiced 
			where writeoffState=0 and isnull(options,'')='' and [money]>0  and customer=@Customer and kphm=@kphm 
			group by goodscategory,price order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name=dbo.GetAccountname(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)

				--print @row_summary
				insert into @tb_goods([name],amount)values(replace(@goodsname,'(1)',''),@amount) --插入表变量

				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor

			--折扣,返利
			set @money=0
			set @moneyNotax=0
			set @moneyTax=0
			select @money=SUM([money]),@moneyNotax=SUM(money_notax),@moneyTax=SUM(money_tax) from tb_invoiced 
			where options in('折扣','返利') and dw='广西华纳新材料股份有限公司' and kphm=@kphm
			if ABS(@money)>0 or ABS(@moneyNotax)>0
			begin
				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T折扣'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --减去税额13%
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				
				update tb_invoiced set writeoffState=1 where options in('折扣','返利') and dw='广西华纳新材料股份有限公司' and kphm=@kphm
			end
			
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select [name],sum(amount) from @tb_goods group by [name] 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			--尾行汇总
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+'  '+@kphm --替换第一个'+'字符
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新第一行摘要
			update UFTData328464_300011.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and sequencenumber=1
			
			--赠送
			exec InsertGiveAndPc @idDocDTO,@kphm,@currentYear,@currentPeriod

			update UFTData328464_300011.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO
			and exists(select 1 from UFTData328464_300011.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')
			
			--更新主表金额
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@amountdr_total, accuorigamountcr=@amountdr_total, accuamountdr=@amountdr_total
			, accuamountcr=@amountdr_total where id=@idDocDTO

			--导入明细表
			exec InsertVoucherJournal @idDocDTO

			--反更新简道云销售发货表
			update tb_invoiced set writeoffState=1 where writeoffState=0 and customer=@Customer and kphm=@kphm 
			and dw='广西华纳新材料股份有限公司'
			update sale_fh set writeoffState=1 from sale_fh a where a.writeoffState=0 and a.customer=@Customer 
			and a.xs_sn in(select xs_sn from tb_invoiced where customer=@Customer and kphm=@kphm)
			and a.dw='广西华纳新材料股份有限公司'
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[InvoicedTwo]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	已开票凭证，多票一凭证
-- =============================================
CREATE PROCEDURE [dbo].[InvoicedTwo] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：销售CCS-25  28.4T  保光（天津）  01184714,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4),@money numeric(18,2)
		,@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@idDocDTO int,@strkphm nvarchar(max)
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2),@docTitle nvarchar(60)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	
	DECLARE @tb_goods TABLE(name varchar(100), amount numeric(18,4))
	DECLARE @tb_invoices TABLE(kphm nvarchar(400))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	DECLARE customer_Cursor CURSOR FOR select customer from (
	select customer,kphm from v_Invoiced where writeoffState=0 and isnull(options,'')='' and [money]>0 
		and year(fhrq)=year(kprq) and month(fhrq)=month(kprq) and year(kprq)=@currentYear and month(kprq)=@currentPeriod 
		and dw='广西华纳新材料股份有限公司'
		group by customer,kphm
	) t1
	group by customer
	having COUNT(*)>1
	order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer
    while @@fetch_status = 0
    begin
		set @docTitle='已开票'
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,@docTitle,@idDocDTO output
		--set @idDocDTO=89154
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			set @head_summary='销售' --第一行汇总
			--科目表
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1

			delete from @tb_goods  --清空数据
			delete from @tb_invoices  --清空数据

			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@head_summary,1,0,null,0,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)
			
			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) from v_invoiced 
			where writeoffState=0 and isnull(options,'')='' and [money]>0  and customer=@Customer 
			and year(fhrq)=year(kprq) and month(fhrq)=month(kprq) and year(kprq)=@currentYear and month(kprq)=@currentPeriod
			and dw='广西华纳新材料股份有限公司'
			group by goodscategory,price order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name=dbo.GetAccountname(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth
				
				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer+'  '
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)

				--print @row_summary
				insert into @tb_goods([name],amount)values(replace(@goodsname,'(1)',''),@amount) --插入表变量
				insert into @tb_invoices(kphm) select distinct kphm from v_Invoiced
				where writeoffState=0 and isnull(options,'')='' and [money]>0  and customer=@Customer 
				and year(fhrq)=year(kprq) and month(fhrq)=month(kprq) and year(kprq)=@currentYear and month(kprq)=@currentPeriod
				and dw='广西华纳新材料股份有限公司'
				and goodscategory=@goodsname and price=@price and kphm not in(select kphm from @tb_invoices)
				
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣,返利
			set @money=0
			set @moneyNotax=0
			set @moneyTax=0
			select @money=SUM([money]),@moneyNotax=SUM(money_notax),@moneyTax=SUM(money_tax) from tb_invoiced 
			where options in('折扣','返利') and dw='广西华纳新材料股份有限公司' and kphm in(select distinct kphm from @tb_invoices)
			if ABS(@money)>0 or ABS(@moneyNotax)>0
			begin
				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T折扣'+'  '+@Customer+'  '
				set @rowmoney=@money/1.13  --减去税额13%
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				
				update tb_invoiced set writeoffState=1 where options in('折扣','返利') and dw='广西华纳新材料股份有限公司' and kphm in(select distinct kphm from @tb_invoices)
			end

			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select [name],sum(amount) from @tb_goods group by [name] 
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			--尾行汇总
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer --替换第一个'+'字符
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新第一行摘要
			update UFTData328464_300011.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and sequencenumber=1
			
			--加上发票号码
			select @strkphm=stuff((select distinct ','+kphm from @tb_invoices for xml path('')),1,1,'')
			update UFTData328464_300011.dbo.GL_Entry set summary=summary+' '+@strkphm where idDocDTO=@idDocDTO

			update UFTData328464_300011.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO
			and exists(select 1 from UFTData328464_300011.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')
			
			--更新主表金额
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@amountdr_total, accuorigamountcr=@amountdr_total, accuamountdr=@amountdr_total
			, accuamountcr=@amountdr_total where id=@idDocDTO

			--导入明细表
			exec InsertVoucherJournal @idDocDTO

			--反更新简道云销售发货表
			update tb_invoiced set writeoffState=1 where writeoffState=0 and xs_sn in(select xs_sn from tb_invoiced where kphm in(select distinct kphm from @tb_invoices))
			update sale_fh set writeoffState=1 from sale_fh a where a.writeoffState<1 
			and a.xs_sn in(select xs_sn from tb_invoiced where kphm in(select distinct kphm from @tb_invoices))
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[Notinvoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	上月未开票凭证，每月最后一天或次月1号执行
-- =============================================
CREATE PROCEDURE [dbo].[Notinvoiced] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要为XX月未开票XXX产品XX吨客户名称,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@summoney numeric(12,2),@goodsname nvarchar(100),@price numeric(10,2),@amount numeric(18,4)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@strTemp nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2),@money numeric(12,2)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@th_id int, @amount_th numeric(18,4),@money_th numeric(18,2)

	DECLARE @tb_goods TABLE(goodscategory varchar(50),goodsname varchar(50), amount numeric(18,4))
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50)
	
	DECLARE customer_Cursor CURSOR FOR select customer,sum(money) from v_sale_fh where writeoffState=0 and [money]>0 
	and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod
	and dw='广西华纳新材料股份有限公司'
	group by customer order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    while @@fetch_status = 0
    begin
		if not exists(select 1 from UFTData328464_300011.dbo.GL_Entry a inner join UFTData328464_300011.dbo.GL_Doc b on b.id=a.idDocDTO 
			where b.accountingyear=@currentYear and b.accountingperiod=@currentPeriod and b.iddoctype=9 
			and a.summary like cast(@currentPeriod as varchar(2))+'月未开票' and a.AuxiliaryItems like @Customer +'%')
		begin
			--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
			exec AddVoucherMaster @Customer,@summoney,@currentYear,@currentPeriod,'未开票',@idDocDTO output
			--print @idDocDTO
			if @idDocDTO>0
			begin
				set @sequencenumber=1
				set @code='0000'
				set @head_summary=cast(@currentPeriod as varchar(10))+'月未开票' --第一行汇总
				--科目表
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1

				delete from @tb_goods  --清空数据

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@head_summary,1,@summoney,null,@summoney,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

				set @amountcr_total=0  --贷方金额
				set @amountdr_total=0  --借方金额
				DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,sum(amount),sum([money]) 
				from v_sale_fh where writeoffState=0 and [money]>0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod 
				and dw='广西华纳新材料股份有限公司'
				group by goodscategory,price order by goodscategory
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
				while @@fetch_status = 0
				begin
					--分录表
					select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name=dbo.GetAccountname(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

					DECLARE th_Cursor CURSOR FOR select id,amount,[money]
					from sale_th where writeoffState=0 and customer=@Customer and dbo.DelChinese(goodsname)= replace(dbo.DelChinese(@goodsname),'(1)','') and price=@price and year(thrq)=@currentYear and month(thrq)=@currentPeriod 
					order by thrq
					OPEN th_Cursor
					FETCH NEXT FROM th_Cursor INTO @th_id,@amount_th,@money_th
					while @@fetch_status = 0
					begin
						if @amount>0
						begin
							set @amount=@amount-@amount_th
							set @money=@money-@money_th
							update sale_th set writeoffState=1 where id=@th_id
						end
						FETCH NEXT FROM th_Cursor INTO @th_id,@amount_th,@money_th
					end
					CLOSE th_Cursor
					DEALLOCATE th_Cursor
					
					set @row_summary=cast(@currentPeriod as varchar(10))+'月未开票'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer
					set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
					set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
					set @amountdr_total=@amountdr_total+@money  --借方金额
					set @sequencenumber=@sequencenumber+1
					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

					insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)

					insert into @tb_goods(goodscategory, goodsname,amount)values(replace(@goodsname,'(1)',''),@goodsname,@amount) --插入表变量

					FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor

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

				set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer --替换第一个'+'字符
				--尾行汇总
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,round((@amountdr_total-@amountcr_total),2),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
				
				--print @head_summary
				--更新第一行摘要
				update UFTData328464_300011.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
				where idDocDTO=@idDocDTO and sequencenumber=1

				update UFTData328464_300011.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO
				and exists(select 1 from UFTData328464_300011.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')

				--更新主表金额
				update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@amountdr_total, accuorigamountcr=@amountdr_total, accuamountdr=@amountdr_total
				, accuamountcr=@amountdr_total where id=@idDocDTO

				--导入明细表
				exec InsertVoucherJournal @idDocDTO
				
				--反写销售出库
				update sale_fh set writeoffState=-1 where writeoffState=0 and [money]>0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod
				and dw='广西华纳新材料股份有限公司'
			end
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[Notinvoiced_zhekou]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: 2023-6-1
-- Description:	未开票折扣凭证，最后一步运行
-- =============================================
CREATE PROCEDURE [dbo].[Notinvoiced_zhekou] 
(
	@currentYear int,
	@currentPeriod int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要为XX月未开票XXX产品XX吨客户名称,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@summoney numeric(12,2),@goodsname nvarchar(100),@price numeric(10,2),@amount numeric(18,4)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@strTemp nvarchar(max),@idDocDTO int
	DECLARE @code nvarchar(20),@sequencenumber int,@idaccount int,@rowmoney numeric(12,2),@money numeric(12,2)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@th_id int, @amount_th numeric(18,4),@money_th numeric(18,2)
	
	DECLARE customer_Cursor CURSOR FOR select customer,sum(money) from v_sale_fh where writeoffState=0 and [money]<0 
	and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod 
	and xs_sn not in(select xs_sn from tb_invoiced where year(kprq)=@currentYear and month(kprq)=@currentPeriod)
	and dw='广西华纳新材料股份有限公司'
	group by customer order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec AddVoucherMaster @Customer,@summoney,@currentYear,@currentPeriod,'未开票折扣',@idDocDTO output
		--set @idDocDTO=121
		if @idDocDTO>0
		begin
			set @sequencenumber=1
			set @code='0000'
			set @head_summary=cast(@currentPeriod as varchar(10))+'月未开票' --第一行汇总
			--科目表
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1

			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'未开票折扣第一行',1,@summoney,null,@summoney,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,sum(amount),sum([money]) 
			from v_sale_fh where writeoffState=0 and [money]<0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod 
			and xs_sn not in(select xs_sn from tb_invoiced where year(kprq)=@currentYear and month(kprq)=@currentPeriod)
			and dw='广西华纳新材料股份有限公司'
			group by goodscategory,price order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name=dbo.GetAccountname(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary=cast(@currentPeriod as varchar(10))+'月未开票'+replace(@goodsname,'(1)','')+'  折扣 '+@Customer
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)

				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor

			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@row_summary,1,null,round(@amountcr_total,2),null,round((@amountdr_total-@amountcr_total),2),null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--更新第一行摘要
			update UFTData328464_300011.dbo.GL_Entry set summary=@row_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='未开票折扣第一行'

			update UFTData328464_300011.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO
			and exists(select 1 from UFTData328464_300011.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')

			--更新主表金额
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@amountdr_total, accuorigamountcr=@amountdr_total, accuamountdr=@amountdr_total
			, accuamountcr=@amountdr_total where id=@idDocDTO

			--导入明细表
			exec InsertVoucherJournal @idDocDTO
				
			--反写销售出库
			update sale_fh set writeoffState=-1 where writeoffState=0 and [money]<0 and customer=@Customer and year(fhrq)=@currentYear and month(fhrq)=@currentPeriod
			and xs_sn not in(select xs_sn from tb_invoiced where year(kprq)=@currentYear and month(kprq)=@currentPeriod)
			and dw='广西华纳新材料股份有限公司'
		end

	    FETCH NEXT FROM customer_Cursor INTO @Customer,@summoney
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor

END
GO
/****** Object:  StoredProcedure [dbo].[WriteOffInvoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲红已开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[WriteOffInvoiced] 
	@cust_name nvarchar(100),
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

     --生成摘要：[冲红2023年4月30日转字1-000412号凭证]销售QAA-3 87T 辽宁晶欧 04475686（01527882）,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@id nvarchar(50),@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@strkphm nvarchar(max),@updateRow int,@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@rowmoney numeric(12,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@docTitle nvarchar(60),@old_kphm nvarchar(200),@firstkphm nvarchar(50)
	
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),xs_sn varchar(50),customer varchar(100),fhrq DateTime,goodscategory varchar(50)
		,goodsname varchar(50),price numeric(18,2),amount numeric(18,4),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400),old_kphm varchar(400))
	DECLARE @tb_voucherid TABLE(id int,voucher_id int,kphm nvarchar(400))
	delete from @tb_goods  --清空数据
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50),@entry_summary nvarchar(max),@goodscategory varchar(50)

	DECLARE customer_Cursor CURSOR FOR select id,customer,xs_sn,fhrq,goodscategory,price,amount,[money],kphm,money_notax,money_tax from v_invoiced 
	where writeoffState=0 and money>0 and options='冲红' and year(kprq)=@currentYear and month(kprq)=@currentPeriod 
	and dw='广西华纳新材料股份有限公司'
	and customer=@cust_name
	order by customer,goodscategory
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@moneyNotax,@moneyTax
    while @@fetch_status = 0
    begin
		--首先查找已开票的凭证
		set @old_kphm=''
		select Top 1 @old_kphm=kphm from tb_invoiced where xs_sn in(select xs_sn from tb_invoiced where kphm=@kphm) order by kprq,id
		set @voucher_id=0
		select Top 1 @voucher_id=b.id from UFTData328464_300011.dbo.GL_Doc b inner join UFTData328464_300011.dbo.GL_Entry a on a.idDocDTO=b.id 
		where b.iddoctype=9 
		and a.summary like '%'+@old_kphm+'%' and a.AuxiliaryItems like @Customer+'%'
		order by b.voucherdate
		if @voucher_id>0
		begin
			if not exists(select 1 from @tb_goods where id=@id)
			begin
				insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodscategory,goodsname,price,amount,[money],money_notax,money_tax,kphm,old_kphm)
				values(@voucher_id,@id,@xs_sn,@Customer,@fhrq,replace(@goodsname,'(1)',''),@goodsname,@price,@amount,@money,@moneyNotax,@moneyTax,@kphm,@old_kphm)
			end
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@moneyNotax,@moneyTax
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
    DECLARE tbgoods_Cursor CURSOR FOR select voucher_id from @tb_goods 
    group by voucher_id
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @voucher_id
    while @@fetch_status = 0
    begin
		delete from @tb_voucherid  --清除
		select Top 1 @old_kphm=old_kphm from @tb_goods where voucher_id=@voucher_id
		insert into @tb_voucherid(id,voucher_id,kphm)
		select @voucher_id,b.id,@old_kphm from UFTData328464_300011.dbo.GL_Doc b inner join UFTData328464_300011.dbo.GL_Entry a on a.idDocDTO=b.id 
		where b.iddoctype=9 
		and a.summary like '%'+@old_kphm+'%' and a.AuxiliaryItems like @Customer+'%'
		and not exists(select 1 from @tb_voucherid where voucher_id=b.id)
		group by b.id
				
		set @docTitle='冲红已开票|'+cast(@voucher_id as varchar(30))
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,@docTitle,@idDocDTO output
		--set @idDocDTO=120873
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			--获取要冲红的之前凭证
			DECLARE Entry_Cursor CURSOR FOR select idDocDTO,code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitycr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
			from UFTData328464_300011.dbo.GL_Entry where idDocDTO in(select voucher_id from @tb_voucherid where id=@voucher_id) 
			order by idDocDTO,code
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
			while @@fetch_status = 0
			begin
				select @doccode=code,@voucherdate=voucherdate from UFTData328464_300011.dbo.GL_Doc where id=@EntryDocid
				set @row_summary='[冲红'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转字1-'+@doccode+'号凭证]'+@Entrysummary
				--科目
				select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code in(select code from UFTData328464_300011.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@Entrycode,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)

				set @sequencenumber=@sequencenumber+1
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodscategory,goodsname,price,amount,[money],money_notax,money_tax,kphm,old_kphm)
			select @voucher_id,id,xs_sn,Customer,fhrq,replace(goodscategory,'(1)',''),goodscategory,price,amount,[money],money_notax,money_tax,kphm,'' 
			from v_invoiced b where ISNULL(options,'')='' and b.kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) 
			and b.id not in(select id from @tb_goods where voucher_id=@voucher_id)
			
			set @updateRow=@sequencenumber		
			set @head_summary='销售' --第一行汇总
			set @code=replicate('0',4-len((convert(int,@Entrycode)+1)))+cast((convert(int,@Entrycode)+1) as varchar(10))
			--科目表
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@head_summary,1,2,null,2,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)
			
			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,kphm,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from @tb_goods where voucher_id=@voucher_id
			group by goodsname,price,kphm order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@kphm,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name=dbo.GetAccountname(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='销售'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@kphm,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣,返利
			set @money=0
			set @moneyNotax=0
			set @moneyTax=0
			select @money=SUM([money]),@moneyNotax=SUM(money_notax),@moneyTax=SUM(money_tax) from tb_invoiced 
			where options in('折扣','返利') and dw='广西华纳新材料股份有限公司' and kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
			if ABS(@money)>0 or ABS(@moneyNotax)>0
			begin
				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T折扣'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --减去税额13%
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				
				update tb_invoiced set writeoffState=1 where options in('折扣','返利') and dw='广西华纳新材料股份有限公司'
				and kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id)
			end
			
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodscategory,sum(amount) from @tb_goods 
			where voucher_id=@voucher_id 
			group by goodscategory order by goodscategory
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor

			--所有的开票号码
			select @strkphm=''
			select @strkphm=stuff((select distinct ','+kphm from @tb_goods where voucher_id=@voucher_id for xml path('')),1,1,'')
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+'  '+@strkphm --替换第一个'+'字符
			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,@moneyTax_total,null,null,@sequencenumber+1,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新销售第一行摘要
			update UFTData328464_300011.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and sequencenumber=@updateRow
			
			--更新冲红第一行摘要
			select Top 1 @firstkphm=kphm from tb_invoiced where options='冲红' and abs(amount)>0 and [money]<0 
			and xs_sn in(select top 1 xs_sn from @tb_goods where voucher_id=@voucher_id) order by kprq desc
			update UFTData328464_300011.dbo.GL_Entry set summary=summary+'（'+@firstkphm+'）' where idDocDTO=@idDocDTO and sequencenumber<@updateRow
			
			select Top 1 @kphm=kphm,@Customer=customer from @tb_goods where voucher_id=@voucher_id
			--赠送
			exec InsertGiveAndPc @idDocDTO,@kphm,@currentYear,@currentPeriod

			update UFTData328464_300011.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO
			and exists(select 1 from UFTData328464_300011.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update tb_invoiced set writeoffState=1 where writeoffState=0 and (kphm in(select distinct kphm from @tb_goods where voucher_id=@voucher_id) or kphm in(@firstkphm))
			update sale_fh set writeoffState=1 from sale_fh a inner join tb_invoiced b on b.xs_sn=a.xs_sn
			where a.writeoffState=0 and a.xs_sn in(select xs_sn from @tb_goods where voucher_id=@voucher_id)
		end
			
        FETCH NEXT FROM tbgoods_Cursor INTO @voucher_id
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[WriteOffInvoiced_kai]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	无凭证冲红重开票
-- =============================================
CREATE PROCEDURE [dbo].[WriteOffInvoiced_kai] 
	@cust_name nvarchar(100),
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

     --生成摘要：[冲红2023年4月30日转字1-000412号凭证]销售QAA-3 87T 辽宁晶欧 04475686（01527882）,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@fh_id int,@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@prev_kphm nvarchar(200),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@rowmoney numeric(12,2),@summoney numeric(18,2)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50),@head_summary nvarchar(max),@foot_summary nvarchar(max),@strkphm nvarchar(400),@n_kphm nvarchar(400)
	
    DECLARE customer_Cursor CURSOR FOR select customer,kphm from v_invoiced 
	where writeoffState=0 and money>0 and isnull(options,'')='' and year(kprq)=@currentYear and month(kprq)=@currentPeriod 
	and dw='广西华纳新材料股份有限公司'
	and customer=@cust_name
	group by customer,kphm
	order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'冲红已开票',@idDocDTO output
		--set @idDocDTO=120873
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			--科目表
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'销售第一行',1,1,null,1,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)
			
			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from v_Invoiced where writeoffState=0 and isnull(options,'')='' and kphm=@kphm
			group by goodscategory,price order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name=dbo.GetAccountname(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='销售'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣,返利
			set @money=0
			set @moneyNotax=0
			set @moneyTax=0
			select @money=SUM([money]),@moneyNotax=SUM(money_notax),@moneyTax=SUM(money_tax) from tb_invoiced 
			where options in('折扣','返利') and dw='广西华纳新材料股份有限公司' and kphm=@kphm
			if ABS(@money)>0 or ABS(@moneyNotax)>0
			begin
				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T折扣'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --减去税额13%
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				
				update tb_invoiced set writeoffState=1 where options in('折扣','返利') and dw='广西华纳新材料股份有限公司'
				and kphm=@kphm
			end
			
			--获取第一行摘要汇总
			set @head_summary='销售'
			DECLARE headsummary_Cursor CURSOR FOR select goodscategory,sum(amount) from v_Invoiced 
			where customer=@Customer and kphm=@kphm 
			group by goodscategory order by goodscategory
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			--尾行汇总
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+'  '+@kphm --替换第一个'+'字符
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountcr_total,null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新销售第一行摘要
			update UFTData328464_300011.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='销售第一行'
			
			--冲红销售
			set @strkphm=''
			select Top 1 @strkphm=kphm from tb_invoiced where writeoffState=0 and options='冲红' and abs(amount)>0 and [money]<0 
			and customer=@Customer order by kprq desc
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			--科目表
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'冲红销售第一行',1,-1,null,-1,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)
			
			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from v_Invoiced where writeoffState=0 and money<0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
			group by goodscategory,price order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name=dbo.GetAccountname(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='冲红销售'+@goodsname+'  '+dbo.ClearZero(abs(@amount))+'T'+'  '+@Customer+'  '+@kphm+'（'+@strkphm+'）'
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--获取第一行摘要汇总
			set @head_summary='冲红销售'
			DECLARE headsummary_Cursor CURSOR FOR select goodscategory,sum(amount) from v_Invoiced 
			where writeoffState=0 and money<0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
			group by goodscategory order by goodscategory
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(abs(@head_amount))+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			--尾行汇总
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+'  '+@kphm+'（'+@strkphm+'）' --替换第一个'+'字符
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountcr_total,null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新销售第一行摘要
			update UFTData328464_300011.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='冲红销售第一行'
			
			--重新开票
			set @strkphm=''
			select Top 1 @strkphm=kphm from tb_invoiced where writeoffState=0 and options='冲红' and money>0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm) and kphm<>@kphm
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			--科目表
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'销售第一行',1,1,null,1,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)
			
			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from v_Invoiced where kphm=@strkphm
			group by goodscategory,price order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name=dbo.GetAccountname(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='销售'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer+'  '+@strkphm
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣,返利
			set @money=0
			set @moneyNotax=0
			set @moneyTax=0
			select @money=SUM([money]),@moneyNotax=SUM(money_notax),@moneyTax=SUM(money_tax) from tb_invoiced 
			where options in('折扣','返利') and dw='广西华纳新材料股份有限公司' and kphm=@strkphm
			if ABS(@money)>0 or ABS(@moneyNotax)>0
			begin
				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T折扣'+'  '+@Customer+'  '+@strkphm
				set @rowmoney=@money/1.13  --减去税额13%
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				
				update tb_invoiced set writeoffState=1 where options in('折扣','返利') and dw='广西华纳新材料股份有限公司'
				and kphm=@strkphm
			end
			
			--获取第一行摘要汇总
			set @head_summary='销售'
			DECLARE headsummary_Cursor CURSOR FOR select goodscategory,sum(amount) from v_Invoiced 
			where kphm=@strkphm 
			group by goodscategory order by goodscategory
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			--尾行汇总
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+'  '+@strkphm --替换第一个'+'字符
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountcr_total,null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新销售第一行摘要
			update UFTData328464_300011.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='销售第一行'
			
			--赠送
			exec InsertGiveAndPc @idDocDTO,@kphm,@currentYear,@currentPeriod

			update UFTData328464_300011.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO
			and exists(select 1 from UFTData328464_300011.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update tb_invoiced set writeoffState=1 where writeoffState=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
			update sale_fh set writeoffState=1 from sale_fh a inner join tb_invoiced b on b.xs_sn=a.xs_sn
			where b.writeoffState=1 and a.xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
		end		
        FETCH NEXT FROM customer_Cursor INTO @Customer,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[WriteOffInvoiced_nokai]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	无凭证冲红不开票
-- =============================================
CREATE PROCEDURE [dbo].[WriteOffInvoiced_nokai] 
	@cust_name nvarchar(100),
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

     --生成摘要：[冲红2023年4月30日转字1-000412号凭证]销售QAA-3 87T 辽宁晶欧 04475686（01527882）,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@fh_id int,@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@prev_kphm nvarchar(200),@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@rowmoney numeric(12,2),@summoney numeric(18,2)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50),@head_summary nvarchar(max),@foot_summary nvarchar(max),@strkphm nvarchar(400)
	
    DECLARE customer_Cursor CURSOR FOR select customer,kphm from v_invoiced 
	where writeoffState=0 and money>0 and year(kprq)=@currentYear and month(kprq)=@currentPeriod 
	and dw='广西华纳新材料股份有限公司'
	and customer=@cust_name
	group by customer,kphm
	order by customer
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @Customer,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'冲红已开票',@idDocDTO output
		--set @idDocDTO=120968
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			--科目表
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'销售第一行',1,1,null,1,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)
			
			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from v_Invoiced where customer=@Customer and kphm=@kphm
			group by goodscategory,price order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name=dbo.GetAccountname(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='销售'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣,返利
			set @money=0
			set @moneyNotax=0
			set @moneyTax=0
			select @money=SUM([money]),@moneyNotax=SUM(money_notax),@moneyTax=SUM(money_tax) from tb_invoiced 
			where options in('折扣','返利') and dw='广西华纳新材料股份有限公司' and kphm=@kphm
			if ABS(@money)>0 or ABS(@moneyNotax)>0
			begin
				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T折扣'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --减去税额13%
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				
				update tb_invoiced set writeoffState=1 where options in('折扣','返利') and dw='广西华纳新材料股份有限公司'
				and kphm=@kphm
			end
			
			--获取第一行摘要汇总
			set @head_summary='销售'
			DECLARE headsummary_Cursor CURSOR FOR select goodscategory,sum(amount) from v_Invoiced 
			where customer=@Customer and kphm=@kphm 
			group by goodscategory order by goodscategory
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			--尾行汇总
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+'  '+@kphm --替换第一个'+'字符
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountcr_total,null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新销售第一行摘要
			update UFTData328464_300011.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='销售第一行'
			
			--冲红销售
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			--科目表
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,'冲红销售第一行',1,-1,null,-1,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)
			
			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodscategory,price,kphm,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from v_Invoiced where writeoffState=0 and money<0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
			group by goodscategory,price,kphm order by goodscategory
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@strkphm,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name=dbo.GetAccountname(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='冲红销售'+@goodsname+'  '+dbo.ClearZero(abs(@amount))+'T'+'  '+@Customer+'  '+@kphm+'（'+@strkphm+'）'
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@strkphm,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--获取第一行摘要汇总
			set @head_summary='冲红销售'
			DECLARE headsummary_Cursor CURSOR FOR select goodscategory,sum(amount) from v_Invoiced 
			where writeoffState=0 and money<0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
			group by goodscategory order by goodscategory
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(abs(@head_amount))+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			--尾行汇总
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+'  '+@kphm+'（'+@strkphm+'）' --替换第一个'+'字符
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @sequencenumber=@sequencenumber+1
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
			
			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,@amountcr_total,null,@moneyTax_total,null,null,@sequencenumber,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新销售第一行摘要
			update UFTData328464_300011.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and summary='冲红销售第一行'
			
			--赠送
			exec InsertGiveAndPc @idDocDTO,@kphm,@currentYear,@currentPeriod

			update UFTData328464_300011.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO
			and exists(select 1 from UFTData328464_300011.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update tb_invoiced set writeoffState=1 where writeoffState=0 and xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
			update sale_fh set writeoffState=1 from sale_fh a inner join tb_invoiced b on b.xs_sn=a.xs_sn
			where a.writeoffState=0 and a.xs_sn in(select xs_sn from v_Invoiced where kphm=@kphm)
		end		
        FETCH NEXT FROM customer_Cursor INTO @Customer,@kphm
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    
END
GO
/****** Object:  StoredProcedure [dbo].[WriteOffNotinvoiced]    Script Date: 2025/4/2 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		唐毓师
-- Create date: <Create Date,,>
-- Description:	冲销未开票凭证
-- =============================================
CREATE PROCEDURE [dbo].[WriteOffNotinvoiced] 
	@currentYear int,
	@currentPeriod int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --生成摘要：[冲销2023年4月30日转字1-000412号凭证]4月未开票CCS-25   32T   保光（天津）,借方不含税，贷方=单价/1.13*数量
	DECLARE @Customer nvarchar(100),@id nvarchar(50),@xs_sn nvarchar(50),@fhrq DateTime,@goodsname nvarchar(100),@price numeric(18,2),@amount numeric(18,4)
		,@money numeric(18,2),@kphm nvarchar(400),@moneyNotax numeric(18,2),@moneyTax numeric(18,2)
	DECLARE @row_summary nvarchar(max),@head_summary nvarchar(max),@foot_summary nvarchar(max),@updateRow int,@idDocDTO int,@idaccount int,@voucher_id int
	DECLARE @code nvarchar(20),@sequencenumber int,@summoney numeric(18,2),@rowmoney numeric(12,2),@summary nvarchar(max)
		,@amountdr_total numeric(18,2),@amountcr_total numeric(18,2),@moneyTax_total numeric(18,2)
	DECLARE @Entrycode nvarchar(50),@Entrysummary nvarchar(max),@origamountdr numeric(18,2),@origamountcr numeric(18,2),@amountdr numeric(18,2),@amountcr numeric(18,2)
		,@quantitycr numeric(18,4),@Entryprice numeric(18,4),@AuxiliaryItems nvarchar(100),@Entryidaccount int,@idcurrency int,@idUnit int,@EntryDocid int
	DECLARE @doccode nvarchar(30),@voucherdate datetime,@accountyear int,@accountperiod int
	
	DECLARE @tb_goods TABLE(voucher_id int,id varchar(50),xs_sn varchar(50),fhrq DateTime,customer varchar(100),goodscategory varchar(50),goodsname varchar(50)
		,price numeric(18,2),amount numeric(18,4),[money] numeric(18,2),money_notax numeric(18,2),money_tax numeric(18,2),kphm varchar(400))
	DECLARE @tb_voucherid TABLE(voucher_id int)
	DECLARE @head_amount numeric(18,4),@head_goodsname nvarchar(50),@entry_summary nvarchar(max),@goodscategory varchar(50)

	DECLARE customer_Cursor CURSOR FOR select id,Customer,xs_sn,fhrq,goodscategory,price,amount,[money],kphm,money_notax,money_tax from v_invoiced 
	where writeoffState=0 and money>0 and options<>'冲红' and convert(int,(DATENAME(year,kprq)+DATENAME(month,kprq)))>convert(int,(DATENAME(year,fhrq)+DATENAME(month,fhrq)))
	and year(kprq)=@currentYear and month(kprq)=@currentPeriod and dw='广西华纳新材料股份有限公司'
	order by customer,kphm,fhrq,goodscategory
	OPEN customer_Cursor
    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@moneyNotax,@moneyTax
    while @@fetch_status = 0
    begin
		set @voucher_id=0
		select Top 1 @voucher_id=b.id from UFTData328464_300011.dbo.GL_Doc b inner join UFTData328464_300011.dbo.GL_Entry a on a.idDocDTO=b.id
		where accountingyear=year(@fhrq) and accountingperiod=month(@fhrq) and iddoctype=9 
		and a.summary like CAST(accountingperiod as varchar(10))+'月%未开票%' and a.AuxiliaryItems like @Customer+'%'
		order by b.madedate
		if @voucher_id>0
		begin
			if not exists(select 1 from @tb_goods where id=@id)
			begin
				insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodscategory,goodsname,price,amount,[money],money_notax,money_tax,kphm)
				values(@voucher_id,@id,@xs_sn,@Customer,@fhrq,replace(@goodsname,'(1)',''),@goodsname,@price,@amount,@money,@moneyNotax,@moneyTax,@kphm)
			end
		end
	    FETCH NEXT FROM customer_Cursor INTO @id,@Customer,@xs_sn,@fhrq,@goodsname,@price,@amount,@money,@kphm,@moneyNotax,@moneyTax
    end
    CLOSE customer_Cursor
    DEALLOCATE customer_Cursor
    --select * from @tb_goods
    
    DECLARE tbgoods_Cursor CURSOR FOR select customer,kphm from @tb_goods 
    group by customer,kphm order by customer
	OPEN tbgoods_Cursor
    FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@kphm
    while @@fetch_status = 0
    begin
		--首先插入一条凭证主表GL_Doc，获取凭证ID，然后再添加分录表(GL_Entry)、明细表(GL_Journal)
		exec AddVoucherMaster @Customer,0,@currentYear,@currentPeriod,'冲销',@idDocDTO output
		--set @idDocDTO=98062
		if @idDocDTO>0
		begin
			--delete from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			set @sequencenumber=1
			set @code='0000'
			
			--获取要冲红的之前凭证
			DECLARE voucherid_Cursor CURSOR FOR select voucher_id
			from @tb_goods where customer=@Customer and kphm=@kphm 
			group by voucher_id
			OPEN voucherid_Cursor
			FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			while @@fetch_status = 0
			begin
				delete from @tb_voucherid  --清除
				select @accountyear=accountingyear,@accountperiod=accountingperiod from UFTData328464_300011.dbo.GL_Doc where id=@voucher_id
				insert into @tb_voucherid(voucher_id)
				select distinct b.id from UFTData328464_300011.dbo.GL_Doc b inner join UFTData328464_300011.dbo.GL_Entry a on a.idDocDTO=b.id
				where accountingyear=@accountyear and accountingperiod=@accountperiod and iddoctype=9 
				and a.summary like CAST(accountingperiod as varchar(10))+'月%未开票%' and a.AuxiliaryItems like @Customer+'%'
				--select * from @tb_voucherid
				
				DECLARE Entry_Cursor CURSOR FOR select idDocDTO,code,summary,-origamountdr,-origamountcr,-amountdr,-amountcr,-quantitycr,price,AuxiliaryItems,idaccount,idcurrency,idUnit
				from UFTData328464_300011.dbo.GL_Entry where idDocDTO in(select voucher_id from @tb_voucherid) 
				order by idDocDTO,code
				OPEN Entry_Cursor
				FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				while @@fetch_status = 0
				begin
					select @doccode=code,@voucherdate=voucherdate from UFTData328464_300011.dbo.GL_Doc where id=@EntryDocid
					set @row_summary='[冲销'+cast(year(@voucherdate) as varchar(10))+'年'+cast(month(@voucherdate) as varchar(2))+'月'+cast(day(@voucherdate) as varchar(2))+'日转字1-'+@doccode+'号凭证]'+@Entrysummary
					--科目
					select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where code in(select code from UFTData328464_300011.dbo.AA_Account where id=@Entryidaccount) and accountingyear=@currentYear
				
					insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
						price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
					values(@code,@row_summary,1,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@sequencenumber,@AuxiliaryItems,@idaccount,@idcurrency,@idDocDTO,@idUnit)

					set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
					set @sequencenumber=@sequencenumber+1
					--print @row_summary
					FETCH NEXT FROM Entry_Cursor INTO @EntryDocid,@Entrycode,@Entrysummary,@origamountdr,@origamountcr,@amountdr,@amountcr,@quantitycr,@Entryprice,@AuxiliaryItems,@Entryidaccount,@idcurrency,@idUnit
				end
				CLOSE Entry_Cursor
				DEALLOCATE Entry_Cursor
				FETCH NEXT FROM voucherid_Cursor INTO @voucher_id
			end
			CLOSE voucherid_Cursor
			DEALLOCATE voucherid_Cursor
			
			--同发票号码的写一个凭证，获取同发票号的其它销售记录
			insert into @tb_goods(voucher_id,id,xs_sn,customer,fhrq,goodscategory,goodsname,price,amount,[money],money_notax,money_tax,kphm)
			select '0',id,xs_sn,Customer,fhrq,replace(goodscategory,'(1)',''),goodscategory,price,amount,[money],money_notax,money_tax,kphm 
			from v_invoiced b where kphm=@kphm and ISNULL(options,'')='' and id not in(select id from @tb_goods where kphm=@kphm)
			and not exists(select 1 from @tb_goods where id=b.id)

			set @updateRow=@sequencenumber		
			set @head_summary='销售' --第一行汇总
			--科目表
			select @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='应收账款' and accountingyear=@currentYear and isEndNode=1 and IsAux=1
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
			, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@head_summary,1,2,null,2,null,null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,null)

			set @amountcr_total=0  --贷方金额
			set @amountdr_total=0  --借方金额
			set @moneyTax_total=0  --销项税额
			DECLARE Entry_Cursor CURSOR FOR select goodsname,price,sum(amount),sum([money]),sum(money_notax),sum(money_tax) 
			from @tb_goods where customer=@Customer and kphm=@kphm
			group by goodsname,price order by goodsname
			OPEN Entry_Cursor
			FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			while @@fetch_status = 0
			begin
				--分录表
				select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name=dbo.GetAccountname(@goodsname) and accountingyear=@currentYear and isEndNode=1 and IsAux=1 order by depth

				set @row_summary='销售'+@goodsname+'  '+dbo.ClearZero(@amount)+'T'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --不含税金额=含税金额/1.13
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				set @sequencenumber=@sequencenumber+1

				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
					price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),@amount,@price/1.13,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				--print @row_summary
				FETCH NEXT FROM Entry_Cursor INTO @goodsname,@price,@amount,@money,@moneyNotax,@moneyTax
			end
			CLOSE Entry_Cursor
			DEALLOCATE Entry_Cursor
			
			--折扣,返利
			set @money=0
			set @moneyNotax=0
			set @moneyTax=0
			select @money=SUM([money]),@moneyNotax=SUM(money_notax),@moneyTax=SUM(money_tax) from tb_invoiced 
			where options in('折扣','返利') and dw='广西华纳新材料股份有限公司' and kphm=@kphm
			if ABS(@money)>0 or ABS(@moneyNotax)>0
			begin
				set @row_summary='销售'+replace(@goodsname,'(1)','')+'  '+dbo.ClearZero(@amount)+'T折扣'+'  '+@Customer+'  '+@kphm
				set @rowmoney=@money/1.13  --减去税额13%
				if abs(@moneyNotax)>0  set @rowmoney=@moneyNotax
				set @amountcr_total=@amountcr_total+@rowmoney  --贷方金额主营业务收入
				set @amountdr_total=@amountdr_total+@money  --借方金额
				set @moneyTax_total=@moneyTax_total+@moneyTax  --销项税额
				set @sequencenumber=@sequencenumber+1
				set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))
				
				insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr, amountcr, quantitycr, 
				price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
				values(@code,@row_summary,1,null,round(@rowmoney,2),null,round(@rowmoney,2),null,null,@sequencenumber,@Customer,@idaccount,4,@idDocDTO,1)
				
				update tb_invoiced set writeoffState=1 where options in('折扣','返利') and dw='广西华纳新材料股份有限公司' and kphm=@kphm
			end
			
			--获取第一行摘要汇总
			DECLARE headsummary_Cursor CURSOR FOR select goodscategory,sum(amount) from @tb_goods 
			where customer=@Customer and kphm=@kphm 
			group by goodscategory order by goodscategory
			OPEN headsummary_Cursor
			FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			while @@fetch_status = 0
			begin
				set @head_summary=@head_summary+'+'+@head_goodsname+'  '+dbo.ClearZero(@head_amount)+'T'
				FETCH NEXT FROM headsummary_Cursor INTO @head_goodsname,@head_amount
			end
			CLOSE headsummary_Cursor
			DEALLOCATE headsummary_Cursor
			
			set @foot_summary=stuff(@head_summary,patindex('%+%',@head_summary),1,'') +'  '+@Customer+'  '+@kphm --替换第一个'+'字符
			--尾行汇总
			select Top 1 @idaccount=id FROM UFTData328464_300011.[dbo].[AA_Account] where name='销项税额' and accountingyear=@currentYear and isEndNode=1 order by depth
			set @code=replicate('0',4-len((convert(int,@code)+1)))+cast((convert(int,@code)+1) as varchar(10))

			if @moneyTax_total=0  set @moneyTax_total=round((@amountdr_total-@amountcr_total),2) --借方金额减去贷方金额
			
			insert into UFTData328464_300011.dbo.GL_Entry(code, summary, exchangerate, origamountdr, origamountcr, amountdr 
				, amountcr, quantitycr,price, sequencenumber, AuxiliaryItems, idaccount, idcurrency, idDocDTO, idUnit)
			values(@code,@foot_summary,1,null,round(@amountcr_total,2),null,@moneyTax_total,null,null,@sequencenumber+1,null,@idaccount,4,@idDocDTO,null)
			
			--print @foot_summary
			--更新销售第一行摘要
			update UFTData328464_300011.dbo.GL_Entry set summary=@foot_summary,origamountdr=@amountdr_total,amountdr=@amountdr_total 
			where idDocDTO=@idDocDTO and sequencenumber=@updateRow
			
			--赠送
			exec InsertGiveAndPc @idDocDTO,@kphm,@currentYear,@currentPeriod

			update UFTData328464_300011.dbo.GL_Entry set AuxiliaryItems=AuxiliaryItems+'01' where idDocDTO=@idDocDTO
			and exists(select 1 from UFTData328464_300011.dbo.AA_Partner where LEFT(code,1)='C' and name=@Customer+'01')

			--更新主表金额
			select @summoney=sum(isnull(origamountdr,0)) from UFTData328464_300011.dbo.GL_Entry where idDocDTO=@idDocDTO
			update UFTData328464_300011.dbo.GL_Doc set accuorigamountdr=@summoney, accuorigamountcr=@summoney, accuamountdr=@summoney
			,accuamountcr=@summoney where id=@idDocDTO

			--导入明细表
			exec InsertVoucherJournal @idDocDTO
			
			--反更新简道云销售出库表
			update tb_invoiced set writeoffState=1 where writeoffState=0 and options<>'冲红' and xs_sn in(select xs_sn from @tb_goods where kphm=@kphm)
			update sale_fh set writeoffState=1 from sale_fh a inner join tb_invoiced b on b.xs_sn=a.xs_sn
			where a.writeoffState<1 and a.xs_sn in(select xs_sn from tb_invoiced where kphm=@kphm)
		end
        FETCH NEXT FROM tbgoods_Cursor INTO @Customer,@kphm
    end
    CLOSE tbgoods_Cursor
    DEALLOCATE tbgoods_Cursor
    
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'冲销状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'purchase_in', @level2type=N'COLUMN',@level2name=N'writeoffState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'冲销状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'purchase_th', @level2type=N'COLUMN',@level2name=N'writeoffState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生产基地' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sale_fh', @level2type=N'COLUMN',@level2name=N'production'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'冲销状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sale_fh', @level2type=N'COLUMN',@level2name=N'writeoffState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'冲销状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sale_th', @level2type=N'COLUMN',@level2name=N'writeoffState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生产基地' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_invoiced', @level2type=N'COLUMN',@level2name=N'production'
GO
USE [master]
GO
ALTER DATABASE [MakeT+Voucher] SET  READ_WRITE 
GO
