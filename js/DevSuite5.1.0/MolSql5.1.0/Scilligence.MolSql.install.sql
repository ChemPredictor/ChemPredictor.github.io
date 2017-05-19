/*********************************************************************************
//////////////////////////////////////////////////////////////////////////////////
//
// MolSql - Chemistry Cartridge for Sql Server
// Copyright (C) 2013 Scilligence Corporation
// Version 4.0.0 (2015-05-05)
// http://www.scilligence.com/
//
//////////////////////////////////////////////////////////////////////////////////
*********************************************************************************/


/*******************************************************************
Before running this script, you need to do two things:

1. Replace [TargetDatabase] with your database name
2. Change System.Drawing path based on your OS type (64bit) and sql server version (2005/2008 or 2012)
3. Replace LICENSE CODE with the MolSql License code assigned to you
   (Please contact support@scilligence.com for evaluation licenses)
4. Change C:\PATH\ to the correct path where it can find the two Scilligence DLLs

NOTE: MolSql works only with SQL Server 2005 and later versions

Example:
create table test(id bigint primary key, mol varchar(max));
exec molindex 'create', 'test', 'mol', 1;

insert into test (id, mol) values (1, 'c1ccccc1');
insert into test (id, mol) values (2, 'c1ccccn1');

exec MolSelect 'select id, $MolWeight(Mol, null) from test where $Search(Substructure, mol, C1=CC=CC=C1)';
*******************************************************************/



/********************************************
I.   Config DB
II.  License
III. Install
IV.  Apply Patch
*********************************************/


/******************************* Part I. Config DB *******************************/
EXEC SP_CONFIGURE 'clr enabled' , '1';
GO
RECONFIGURE;
GO
ALTER DATABASE [TargetDatabase] SET TRUSTWORTHY ON;
GO
USE [TargetDatabase]
--GO
--EXEC sp_changedbowner 'sa'
GO
/* SQL Server 2005/2008 x64 */
/*
CREATE ASSEMBLY [System.Drawing] 
from 'C:\Windows\Microsoft.NET\Framework64\v2.0.50727\System.Drawing.dll' 
with permission_set = UNSAFE;
*/
/* SQL Server 2012 x64 */
CREATE ASSEMBLY [System.Drawing] 
from 'C:\Windows\Microsoft.NET\Framework64\v4.0.30319\System.Drawing.dll' 
with permission_set = UNSAFE;
GO

/******************************* Part II. License *******************************/
USE [TargetDatabase];
create table [OLN.License] (license varchar(max));
insert into [OLN.License] (license) values (N'LICENSE CODE');
GO






USE [TargetDatabase]
GO
/****** Object:  SqlAssembly [Scilligence.MolEngine]    Script Date: 07/16/2013 10:45:39 ******/
CREATE ASSEMBLY [Scilligence.MolEngine]
AUTHORIZATION [dbo]
from 'C:\PATH\Scilligence.MolEngine.dll'
WITH PERMISSION_SET = UNSAFE
GO
/****** Object:  SqlAssembly [Scilligence.MolSql]    Script Date: 07/12/2013 08:04:07 ******/
CREATE ASSEMBLY [Scilligence.MolSql]
AUTHORIZATION [dbo]
from 'C:\PATH\Scilligence.MolSql.dll'
WITH PERMISSION_SET = UNSAFE
GO
/****** Object:  StoredProcedure [dbo].[UpdateLicense]    Script Date: 07/12/2013 08:04:04 ******/
CREATE PROCEDURE [dbo].[UpdateLicense]
	@license [nvarchar](4000)
AS
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[UpdateLicense]
GO
/****** Object:  UserDefinedFunction [dbo].[Tanimoto]    Script Date: 07/12/2013 08:04:07 ******/
CREATE FUNCTION [dbo].[Tanimoto](@query [varbinary](max), @target [varbinary](max))
RETURNS [float] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Tanimoto]
GO
/****** Object:  UserDefinedFunction [dbo].[SmilesS]    Script Date: 07/12/2013 08:04:07 ******/
CREATE FUNCTION [dbo].[SmilesS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[SmilesS]
GO
/****** Object:  UserDefinedFunction [dbo].[Smiles]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[Smiles](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Smiles]
GO
/****** Object:  StoredProcedure [dbo].[ShowVersion]    Script Date: 07/12/2013 08:04:04 ******/
CREATE PROCEDURE [dbo].[ShowVersion]
AS
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[ShowVersion]
GO
/****** Object:  StoredProcedure [dbo].[ShowLicense]    Script Date: 07/12/2013 08:04:04 ******/
CREATE PROCEDURE [dbo].[ShowLicense]
AS
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[ShowLicense]
GO
/****** Object:  StoredProcedure [dbo].[RxnUpdateIndex]    Script Date: 07/12/2013 08:04:04 ******/
CREATE PROCEDURE [dbo].[RxnUpdateIndex]
	@table [nvarchar](4000),
	@column [nvarchar](4000),
	@id [nvarchar](4000),
	@insert [bit]
AS
EXTERNAL NAME [Scilligence.MolSql].[StoredProcedures].[RxnUpdateIndex]
GO
/****** Object:  StoredProcedure [dbo].[RxnSelect]    Script Date: 07/12/2013 08:04:04 ******/
CREATE PROCEDURE [dbo].[RxnSelect]
	@query [nvarchar](4000)
AS
EXTERNAL NAME [Scilligence.MolSql].[StoredProcedures].[RxnSelect]
GO
/****** Object:  StoredProcedure [dbo].[RxnScreen]    Script Date: 07/12/2013 08:04:04 ******/
CREATE PROCEDURE [dbo].[RxnScreen]
	@table [nvarchar](4000),
	@column [nvarchar](4000),
	@smiles [nvarchar](4000),
	@startid [nvarchar](4000)
AS
EXTERNAL NAME [Scilligence.MolSql].[StoredProcedures].[RxnScreen]
GO
/****** Object:  StoredProcedure [dbo].[RxnIndex]    Script Date: 07/12/2013 08:04:04 ******/
CREATE PROCEDURE [dbo].[RxnIndex]
	@cmd [nvarchar](4000),
	@table [nvarchar](4000),
	@column [nvarchar](4000)
AS
EXTERNAL NAME [Scilligence.MolSql].[StoredProcedures].[RxnIndex]
GO
/****** Object:  UserDefinedType [dbo].[Reaction]    Script Date: 07/12/2013 08:04:07 ******/
CREATE TYPE [dbo].[Reaction]
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.Reaction]
GO
/****** Object:  UserDefinedFunction [dbo].[PsaS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[PsaS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [float] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[PsaS]
GO
/****** Object:  UserDefinedFunction [dbo].[Psa]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[Psa](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [float] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Psa]
GO
/****** Object:  UserDefinedFunction [dbo].[PngS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[PngS](@data [nvarchar](4000), @mimetype [nvarchar](4000), @options [nvarchar](4000))
RETURNS [varbinary](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[PngS]
GO
/****** Object:  UserDefinedFunction [dbo].[Png]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[Png](@data [varbinary](max), @mimetype [nvarchar](4000), @options [nvarchar](4000))
RETURNS [varbinary](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Png]
GO
/****** Object:  UserDefinedFunction [dbo].[NorbS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[NorbS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[NorbS]
GO
/****** Object:  UserDefinedFunction [dbo].[Norb]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[Norb](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Norb]
GO
/****** Object:  UserDefinedFunction [dbo].[NohdS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[NohdS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[NohdS]
GO
/****** Object:  UserDefinedFunction [dbo].[Nohd]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[Nohd](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Nohd]
GO
/****** Object:  UserDefinedFunction [dbo].[NohaS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[NohaS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[NohaS]
GO
/****** Object:  UserDefinedFunction [dbo].[Noha]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[Noha](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Noha]
GO
/****** Object:  UserDefinedFunction [dbo].[MolWeightS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[MolWeightS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [float] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[MolWeightS]
GO
/****** Object:  UserDefinedFunction [dbo].[MolWeight]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[MolWeight](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [float] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[MolWeight]
GO
/****** Object:  StoredProcedure [dbo].[MolUpdateIndex]    Script Date: 07/12/2013 08:04:04 ******/
CREATE PROCEDURE [dbo].[MolUpdateIndex]
	@table [nvarchar](4000),
	@column [nvarchar](4000),
	@id [nvarchar](4000),
	@insert [bit]
AS
EXTERNAL NAME [Scilligence.MolSql].[StoredProcedures].[MolUpdateIndex]
GO
/****** Object:  UserDefinedType [dbo].[MolSql]    Script Date: 07/12/2013 08:04:07 ******/
CREATE TYPE [dbo].[MolSql]
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.MolSql]
GO
/****** Object:  StoredProcedure [dbo].[MolSelect]    Script Date: 07/12/2013 08:04:04 ******/
CREATE PROCEDURE [dbo].[MolSelect]
	@query [nvarchar](4000)
AS
EXTERNAL NAME [Scilligence.MolSql].[StoredProcedures].[MolSelect]
GO
/****** Object:  StoredProcedure [dbo].[MolScreen]    Script Date: 07/12/2013 08:04:04 ******/
CREATE PROCEDURE [dbo].[MolScreen]
	@table [nvarchar](4000),
	@column [nvarchar](4000),
	@smiles [nvarchar](4000),
	@startid [nvarchar](4000)
AS
EXTERNAL NAME [Scilligence.MolSql].[StoredProcedures].[MolScreen]
GO
/****** Object:  StoredProcedure [dbo].[MolRegistered]    Script Date: 07/12/2013 08:04:04 ******/
CREATE PROCEDURE [dbo].[MolRegistered]
	@table [nvarchar](4000),
	@column [nvarchar](4000),
	@smiles [nvarchar](4000)
AS
EXTERNAL NAME [Scilligence.MolSql].[StoredProcedures].[MolRegistered]
GO
/****** Object:  StoredProcedure [dbo].[MolIndex]    Script Date: 07/12/2013 08:04:04 ******/
CREATE PROCEDURE [dbo].[MolIndex]
	@cmd [nvarchar](4000),
	@table [nvarchar](4000),
	@column [nvarchar](4000),
	@unique [bit]
AS
EXTERNAL NAME [Scilligence.MolSql].[StoredProcedures].[MolIndex]
GO
/****** Object:  UserDefinedFunction [dbo].[MolFileS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[MolFileS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[MolFileS]
GO
/****** Object:  UserDefinedFunction [dbo].[MolFile]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[MolFile](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[MolFile]
GO
/****** Object:  UserDefinedType [dbo].[Molecule]    Script Date: 07/12/2013 08:04:07 ******/
CREATE TYPE [dbo].[Molecule]
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.Molecule]
GO
/****** Object:  UserDefinedFunction [dbo].[MixtureGuidS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[MixtureGuidS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [uniqueidentifier] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[MixtureGuidS]
GO
/****** Object:  UserDefinedFunction [dbo].[MixtureGuid]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[MixtureGuid](@data [varbinary](8000), @mimetype [nvarchar](4000))
RETURNS [uniqueidentifier] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[MixtureGuid]
GO
/****** Object:  UserDefinedFunction [dbo].[MatchSequence]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[MatchSequence](@target [nvarchar](4000), @query [nvarchar](4000))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[MatchSequence]
GO
/****** Object:  UserDefinedFunction [dbo].[JSDrawS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[JSDrawS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[JSDrawS]
GO
/****** Object:  UserDefinedFunction [dbo].[JSDraw]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[JSDraw](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[JSDraw]
GO
/****** Object:  UserDefinedFunction [dbo].[JpgS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[JpgS](@data [nvarchar](4000), @mimetype [nvarchar](4000), @options [nvarchar](4000))
RETURNS [varbinary](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[JpgS]
GO
/****** Object:  UserDefinedFunction [dbo].[Jpg]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[Jpg](@data [varbinary](max), @mimetype [nvarchar](4000), @options [nvarchar](4000))
RETURNS [varbinary](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Jpg]
GO
/****** Object:  UserDefinedFunction [dbo].[ImageS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[ImageS](@data [nvarchar](4000), @mimetype [nvarchar](4000), @format [nvarchar](4000), @options [nvarchar](4000))
RETURNS [varbinary](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[ImageS]
GO
/****** Object:  UserDefinedFunction [dbo].[Image]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[Image](@data [varbinary](max), @mimetype [nvarchar](4000), @format [nvarchar](4000), @options [nvarchar](4000))
RETURNS [varbinary](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Image]
GO
/****** Object:  UserDefinedFunction [dbo].[HtmlFormulaS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[HtmlFormulaS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[HtmlFormulaS]
GO
/****** Object:  UserDefinedFunction [dbo].[HtmlFormula]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[HtmlFormula](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[HtmlFormula]
GO
/****** Object:  UserDefinedFunction [dbo].[GifS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[GifS](@data [nvarchar](4000), @mimetype [nvarchar](4000), @options [nvarchar](4000))
RETURNS [varbinary](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[GifS]
GO
/****** Object:  UserDefinedFunction [dbo].[Gif]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[Gif](@data [varbinary](max), @mimetype [nvarchar](4000), @options [nvarchar](4000))
RETURNS [varbinary](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Gif]
GO
/****** Object:  UserDefinedFunction [dbo].[GetMolIDS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[GetMolIDS](@table [nvarchar](4000), @column [nvarchar](4000), @data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[GetMolIDS]
GO
/****** Object:  UserDefinedFunction [dbo].[GetMolID2]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[GetMolID2](@table [nvarchar](4000), @column [nvarchar](4000), @cano [uniqueidentifier])
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[GetMolID2]
GO
/****** Object:  UserDefinedFunction [dbo].[GetMolID]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[GetMolID](@table [nvarchar](4000), @column [nvarchar](4000), @data [varbinary](8000), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[GetMolID]
GO
/****** Object:  UserDefinedFunction [dbo].[FormulaS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[FormulaS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[FormulaS]
GO
/****** Object:  UserDefinedFunction [dbo].[Formula]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[Formula](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Formula]
GO
/****** Object:  UserDefinedFunction [dbo].[ExSmilesS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[ExSmilesS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[ExSmilesS]
GO
/****** Object:  UserDefinedFunction [dbo].[ExSmiles]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[ExSmiles](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[ExSmiles]
GO
/****** Object:  UserDefinedFunction [dbo].[ExactMassS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[ExactMassS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [float] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[ExactMassS]
GO
/****** Object:  UserDefinedFunction [dbo].[ExactMass]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[ExactMass](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [float] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[ExactMass]
GO
/****** Object:  UserDefinedFunction [dbo].[CountRingsS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[CountRingsS](@data [nvarchar](4000), @mimetype [nvarchar](4000), @ringsize [int])
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[CountRingsS]
GO
/****** Object:  UserDefinedFunction [dbo].[CountRings]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[CountRings](@data [varbinary](max), @mimetype [nvarchar](4000), @ringsize [int])
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[CountRings]
GO
/****** Object:  UserDefinedFunction [dbo].[CountAtomsS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[CountAtomsS](@data [nvarchar](4000), @mimetype [nvarchar](4000), @symbol [nvarchar](4000))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[CountAtomsS]
GO
/****** Object:  UserDefinedFunction [dbo].[CountAtoms]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[CountAtoms](@data [varbinary](max), @mimetype [nvarchar](4000), @symbol [nvarchar](4000))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[CountAtoms]
GO
/****** Object:  UserDefinedAggregate [dbo].[Concat]    Script Date: 07/12/2013 08:04:07 ******/
CREATE AGGREGATE [dbo].[Concat]
(@s [nvarchar](max))
RETURNS[nvarchar](max)
EXTERNAL NAME [Scilligence.MolSql].[Concat]
GO
/****** Object:  UserDefinedFunction [dbo].[CMLFileS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[CMLFileS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[CMLFileS]
GO
/****** Object:  UserDefinedFunction [dbo].[CMLFile]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[CMLFile](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[CMLFile]
GO
/****** Object:  UserDefinedFunction [dbo].[ChemSearch]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[ChemSearch](@column [nvarchar](4000), @query [dbo].[Molecule], @command [nvarchar](4000), @options [nvarchar](4000))
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[ChemSearch]
GO
/****** Object:  UserDefinedFunction [dbo].[ChemScreen]    Script Date: 07/12/2013 08:04:05 ******/
CREATE FUNCTION [dbo].[ChemScreen](@query [varbinary](max), @target [varbinary](max))
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[ChemScreen]
GO
/****** Object:  UserDefinedFunction [dbo].[CanonicalCodeS]    Script Date: 07/12/2013 08:04:05 ******/
CREATE FUNCTION [dbo].[CanonicalCodeS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [uniqueidentifier] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[CanonicalCodeS]
GO
/****** Object:  UserDefinedFunction [dbo].[CanonicalCode]    Script Date: 07/12/2013 08:04:05 ******/
CREATE FUNCTION [dbo].[CanonicalCode](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [uniqueidentifier] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[CanonicalCode]
GO


/****** 2.7.1 change **********/
/****** Object:  UserDefinedFunction [dbo].[HasCoordinates]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[HasCoordinates](@data [varbinary](max), @mimetype [nvarchar](4000))
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[HasCoordinates]
GO
/****** Object:  UserDefinedFunction [dbo].[HasCoordinatesS]    Script Date: 07/12/2013 08:04:06 ******/
CREATE FUNCTION [dbo].[HasCoordinatesS](@data [nvarchar](4000), @mimetype [nvarchar](4000))
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[HasCoordinatesS]
GO

/****** Object:  UserDefinedAggregate [dbo].[ConcatDistinct]    Script Date: 01/23/2014 08:04:07 ******/
CREATE AGGREGATE [dbo].[ConcatDistinct]
(@s [nvarchar](max))
RETURNS[nvarchar](max)
EXTERNAL NAME [Scilligence.MolSql].[ConcatDistinct]
GO

/****** Object:  UserDefinedFunction [dbo].[TanimotoSimilarity]    Script Date: 01/23/2014 08:04:07 ******/
CREATE FUNCTION [dbo].[TanimotoSimilarity](@m1 [varbinary](max), @mimetype1 [nvarchar](4000), @m2 [varbinary](max), @mimetype2 [nvarchar](4000))
RETURNS [float] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[TanimotoSimilarity]
GO

/****** Object:  UserDefinedFunction [dbo].[TanimotoSimilarityS]    Script Date: 01/23/2014 08:04:07 ******/
CREATE FUNCTION [dbo].[TanimotoSimilarityS](@m1 [nvarchar](max), @mimetype1 [nvarchar](4000), @m2 [nvarchar](max), @mimetype2 [nvarchar](4000))
RETURNS [float] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[TanimotoSimilarityS]
GO

/****** Object:  UserDefinedFunction [dbo].[RegexMatch]    Script Date: 03/04/2014 ******/
CREATE FUNCTION [dbo].[RegexMatch](@s [nvarchar](4000), @pattern [nvarchar](4000))
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[RegexMatch]
GO

/****** Object:  UserDefinedFunction [dbo].[RegexMatch]    Script Date: 06/02/2014 ******/
CREATE FUNCTION [dbo].[TryCastNumber](@s [nvarchar](4000), @pattern [bigint])
RETURNS [bigint] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[TryCastNumber]
GO

/****** Object:  UserDefinedFunction [dbo].[RegexMatch]    Script Date: 06/02/2014 ******/
CREATE AGGREGATE [dbo].[ConcatReverse]
(@s [nvarchar](max))
RETURNS[nvarchar](max)
EXTERNAL NAME [Scilligence.MolSql].[ConcatReverse]
GO

/****** Object:  UserDefinedFunction [dbo].[Bin2Str]    Script Date: 01/20/2015 09:30:05 ******/
CREATE FUNCTION [dbo].[Bin2Str](@s [varbinary](max))
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Bin2Str]
GO
/****** Object:  UserDefinedFunction [dbo].[Str2Bin]    Script Date: 01/20/2015 09:30:13 ******/
CREATE FUNCTION [dbo].[Str2Bin](@s [nvarchar](max))
RETURNS [varbinary](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[Str2Bin]
GO


/******************************* Part IV. Apply Patch *******************************/
/*
USE [TargetDatabase];
ALTER ASSEMBLY [OLN.MolEngine] from 'C:\temp\Scilligence.MolEngine.dll' with unchecked data;
ALTER ASSEMBLY [OLN.MolSql] from 'C:\temp\Scilligence.MolSql.dll' with unchecked data;
*/



-- 01-22

drop AGGREGATE [dbo].[Concat];
go
create AGGREGATE [dbo].[Concat]
(@s [nvarchar](max))
RETURNS[nvarchar](max)
EXTERNAL NAME [Scilligence.MolSql].[Concat]
GO


drop AGGREGATE [dbo].[ConcatDistinct];
go
CREATE AGGREGATE [dbo].[ConcatDistinct]
(@s [nvarchar](max))
RETURNS[nvarchar](max)
EXTERNAL NAME [Scilligence.MolSql].[ConcatDistinct]
GO


drop AGGREGATE [dbo].[ConcatReverse];
go
CREATE AGGREGATE [dbo].[ConcatReverse]
(@s [nvarchar](max))
RETURNS[nvarchar](max)
EXTERNAL NAME [Scilligence.MolSql].[ConcatReverse]
GO


/* 5.0.1 */

-- 2016-09-13

CREATE FUNCTION [dbo].[ContainKeyword](@src [nvarchar](max), @keyword [nvarchar](max), @ignorecase bit)
RETURNS [bit]
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[ContainKeyword]
GO

CREATE FUNCTION [dbo].[ContainAnyKeywords](@src [nvarchar](max), @keywords [nvarchar](max), @ignorecase bit)
RETURNS [bit]
AS 
EXTERNAL NAME [Scilligence.MolSql].[Scilligence.MolSql.UserDefinedFunctions].[ContainAnyKeywords]
GO
