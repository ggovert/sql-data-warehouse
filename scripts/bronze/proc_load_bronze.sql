/*
==================================================================
Stored Procedure: Load Bronze Layer  (Source -> Bronze)
===================================================================
Script Purpose:
  this stored procedure loads data into 'bronze' schema from external csv files.
  it performs the following actions:
    - truncate the bronze tabes before loading the data
    - use 'BULK INSERT' comment to load the data from csv to bronze tables

Parameters:
  None.
   this stored procedure does not accept any parameters or return any values.

Example usage:
  EXEC bronze.load_bronze


*/


CREATE OR ALTER PROCEDURE bronze.load_bronze  AS
BEGIN

	DECLARE @start_time DATETIME, @end_time DATETIME, @start_time_batch DATETIME, @end_time_batch DATETIME;
	BEGIN TRY

		SET @start_time_batch = GETDATE();
		PRINT '=======================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=======================================================';


		PRINT '-------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info ';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into: bronze.crm_cust_info ';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------'



		-- Table for bronze.crm_prd_info
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info ';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info ';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------'


		-- Table for bronze.crm_sales_details
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details ';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into: bronze.crm_sales_details ';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------'


		PRINT '-------------------------------------------------------'
		PRINT 'Loading ERP Tables'
		PRINT '-------------------------------------------------------'


		-- Table for bronze.erp_cust_az12
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12 ';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12 ';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------'


		-- Table for bronze.erp_loc_a101
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101 ';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data Into: bronze.erp_loc_a101 ';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------'


		-- Table for bronze.erp_px_cat_g1v2
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2 ';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2 ';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------'
		
		SET @end_time_batch = GETDATE();
		PRINT '==========================================================';
		PRINT 'Loading Bronze layer Completed';
		PRINT '		- Total duration: ' + CAST(DATEDIFF(second, @start_time_batch, @end_time_batch) AS NVARCHAR) + ' seconds';
		PRINT '==========================================================';


	END TRY

	BEGIN CATCH
		PRINT '==========================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT '==========================================================';
	END CATCH


END
