/*
=========================================
Title : Create db and schema
=========================================
Script purpose:
	this script create new db named "Datawarehouse" after checking if it exists or not

Warning:
	Running this script will drop the entire "Datawarehouse" database if it exists.
*/



USE master;
GO


-- Drop and recreate the datawarehouse db
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Datawarehouse
END;
GO



-- Create "Datawarehouse" db
CREATE DATABASE Datawarehouse;
GO


USE Datawarehouse;
GO


-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
