/*********************************************************************************
//////////////////////////////////////////////////////////////////////////////////
//
// MolSql - Chemistry Cartridge for Sql Server
// Copyright (C) 2014 Scilligence Corporation
// Version 3.1.8 (2014-06-10)
// http://www.scilligence.com/
//
//////////////////////////////////////////////////////////////////////////////////
*********************************************************************************/


USE [TargetDatabase];
go


drop PROCEDURE [dbo].[UpdateLicense]
drop FUNCTION [dbo].[Tanimoto]
drop FUNCTION [dbo].[SmilesS]
drop FUNCTION [dbo].[Smiles]
drop PROCEDURE [dbo].[ShowVersion]
drop PROCEDURE [dbo].[ShowLicense]
drop PROCEDURE [dbo].[RxnUpdateIndex]
drop PROCEDURE [dbo].[RxnSelect]
drop PROCEDURE [dbo].[RxnScreen]
drop PROCEDURE [dbo].[RxnIndex]
drop FUNCTION [dbo].[PsaS]
drop FUNCTION [dbo].[Psa]
drop FUNCTION [dbo].[PngS]
drop FUNCTION [dbo].[Png]
drop FUNCTION [dbo].[NorbS]
drop FUNCTION [dbo].[Norb]
drop FUNCTION [dbo].[NohdS]
drop FUNCTION [dbo].[Nohd]
drop FUNCTION [dbo].[NohaS]
drop FUNCTION [dbo].[Noha]
drop FUNCTION [dbo].[MolWeightS]
drop FUNCTION [dbo].[MolWeight]
drop PROCEDURE [dbo].[MolUpdateIndex]
drop PROCEDURE [dbo].[MolSelect]
drop PROCEDURE [dbo].[MolScreen]
drop PROCEDURE [dbo].[MolRegistered]
drop PROCEDURE [dbo].[MolIndex]
drop FUNCTION [dbo].[MolFileS]
drop FUNCTION [dbo].[MolFile]
drop FUNCTION [dbo].[JSDrawS]
drop FUNCTION [dbo].[JSDraw]
drop FUNCTION [dbo].[MixtureGuidS]
drop FUNCTION [dbo].[MixtureGuid]
drop FUNCTION [dbo].[JpgS]
drop FUNCTION [dbo].[Jpg]
drop FUNCTION [dbo].[ImageS]
drop FUNCTION [dbo].[Image]
drop FUNCTION [dbo].[HtmlFormulaS]
drop FUNCTION [dbo].[HtmlFormula]
drop FUNCTION [dbo].[GifS]
drop FUNCTION [dbo].[Gif]
drop FUNCTION [dbo].[GetMolIDS]
drop FUNCTION [dbo].[GetMolID]
drop FUNCTION [dbo].[FormulaS]
drop FUNCTION [dbo].[Formula]
drop FUNCTION [dbo].[ExSmilesS]
drop FUNCTION [dbo].[ExSmiles]
drop FUNCTION [dbo].[ExactMassS]
drop FUNCTION [dbo].[ExactMass]
drop FUNCTION [dbo].[CMLFileS]
drop FUNCTION [dbo].[CMLFile]
drop FUNCTION [dbo].[ChemSearch]
drop FUNCTION [dbo].[ChemScreen]
drop FUNCTION [dbo].[MatchSequence]
drop FUNCTION [dbo].[CanonicalCodeS]
drop FUNCTION [dbo].[CanonicalCode]
drop FUNCTION [dbo].[CountAtomsS]
drop FUNCTION [dbo].[CountAtoms]
drop FUNCTION [dbo].[CountRingsS]
drop FUNCTION [dbo].[CountRings]
drop FUNCTION [dbo].[GetMolID2]
drop FUNCTION [dbo].[RegexMatch]
drop FUNCTION [dbo].[TanimotoSimilarity]
drop FUNCTION [dbo].[TanimotoSimilarityS]
go
drop FUNCTION [dbo].[TryCastNumber]
go
drop FUNCTION [dbo].[HasCoordinates]
drop FUNCTION [dbo].[HasCoordinatesS]
go
drop FUNCTION [dbo].[Bin2Str]
drop FUNCTION [dbo].[Str2Bin]
GO
drop FUNCTION [dbo].[ContainKeyword]
drop FUNCTION [dbo].[ContainAnyKeywords]
GO


drop AGGREGATE [dbo].[Concat]
drop AGGREGATE [dbo].[ConcatDistinct]
drop AGGREGATE [dbo].[ConcatReverse]
GO

drop TYPE [dbo].[MolSql]
drop TYPE [dbo].[Reaction]
drop TYPE [dbo].[Molecule]
GO

drop ASSEMBLY [Scilligence.MolSql]
GO

drop ASSEMBLY [Scilligence.MolEngine]
GO

drop ASSEMBLY [System.Drawing]
GO

drop table [OLN.License]
GO