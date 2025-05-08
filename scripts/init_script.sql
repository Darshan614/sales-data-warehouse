USE master;
GO

IF EXISTS(select 1 from sys.databases where name='DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

create schema bronze;
GO
create schema silver;
GO 
create schema gold;