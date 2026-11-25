use master;
GO 
--drop and recreate database if exists
IF EXISTS(SELECT 1 FROM sys.databases WHERE name='DataWarehouse')
BEGIN
ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE DataWarehouse;
END;
GO
CREATE DATABASE DataWarehouse;

--create database
USE DataWarehouse;

--create schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
