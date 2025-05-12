# sales-data-warehouse
data warehouse project for sales data

Data Warehouse and Analytics solution for sales data

Technologies:
MSSQL Server, draw.io

This project uses medieval architecture for creating a data warehouse:

1. Bronze Layer - It contains raw data from crm and erp folders which is basically sales data and related customer and products data in raw format.
2. Silver Layer - This contains cleaned and processed data which could be used to perform analytics. It has bronze data which has gone through data cleaning, stadardisation, null value removals, etc.
3. Gold Layer - This contains business ready data which contains combined data in form of views which could be queried to generate BI reports.

![Architecture](https://github.com/Darshan614/sales-data-warehouse/blob/main/architecture/Layer%20Architecture.png)
![DataModel](https://github.com/Darshan614/sales-data-warehouse/blob/main/architecture/DataModel%20Gold%20Layer.png)
