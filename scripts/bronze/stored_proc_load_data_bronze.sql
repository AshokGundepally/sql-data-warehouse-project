CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
   BEGIN TRY
		--CRM TABLES--
	 DECLARE @batch_start_time DATE, @batch_end_time Date
	 SET @batch_start_time = GETDATE()
		PRINT '=======================================================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '=======================================================';
		DECLARE @startTime date, @endTime Date
-------------------------TABLE-1---------------------------------------
        SET @startTime = GETDATE();
		TRUNCATE TABLE  bronze.crm_cust_info;
		PRINT '-------------------------------------------------------';
		PRINT 'Loading.. crm_cust_info table';
		PRINT '-------------------------------------------------------';
		BULK INSERT bronze.crm_cust_info 
		FROM 'C:\Users\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
		   FIRSTROW = 2,
		   FIELDTERMINATOR = ',',
		   TABLOCK
		)
		SET @endTime = GETDATE()
		PRINT 'Loading Duration...' + CAST(DATEDIFF(SECOND,@startTime,@endtime) AS NVARCHAR) +' seconds';
		--SELECT * FROM bronze.crm_cust_info;
-------------------------TABLE-2---------------------------------------
        SET @startTime = GETDATE();
		TRUNCATE TABLE  bronze.crm_prd_info;
		
		PRINT '-------------------------------------------------------';
		PRINT 'Loading.. crm_prd_info table';
		PRINT '-------------------------------------------------------';

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
		   FIRSTROW = 2,
		   FIELDTERMINATOR = ',',
		   TABLOCK
		)
		SET @endTime = GETDATE()
        PRINT 'Loading Duration...' + CAST(DATEDIFF(SECOND,@startTime,@endtime) AS NVARCHAR) +' seconds';
		--SELECT * FROM bronze.crm_prd_info;
-------------------------TABLE-3---------------------------------------
        SET @startTime = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '-------------------------------------------------------';
		PRINT 'Loading.. crm_sales_details table';
		PRINT '-------------------------------------------------------';

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
		   FIRSTROW = 2,
		   FIELDTERMINATOR = ',',
		   TABLOCK
		)
		SET @endTime = GETDATE()
        PRINT 'Loading Duration...' + CAST(DATEDIFF(SECOND,@startTime,@endtime) AS NVARCHAR) +' seconds';
		--SELECT * FROM bronze.crm_sales_details
-------------------------TABLE-4---------------------------------------
		-- ERP TABLES
		SET @startTime = GETDATE();
		PRINT '=======================================================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '=======================================================';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '-------------------------------------------------------';
		PRINT 'Loading.. erp_cust_az12 table';
		PRINT '-------------------------------------------------------';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
		   FIRSTROW = 2,
		   FIELDTERMINATOR = ',',
		   TABLOCK
		)
		SET @endTime = GETDATE()
        PRINT 'Loading Duration...' + CAST(DATEDIFF(SECOND,@startTime,@endtime) AS NVARCHAR) +' seconds';
		--SELECT * FROM bronze.erp_cust_az12
-------------------------TABLE-5---------------------------------------

        SET @startTime = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '-------------------------------------------------------';
		PRINT 'Loading.. erp_cust_az12 table';
		PRINT '-------------------------------------------------------';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
		   FIRSTROW = 2,
		   FIELDTERMINATOR = ',',
		   TABLOCK
		)
		--SELECT * FROM bronze.erp_loc_a101
		SET @endTime = GETDATE()
        PRINT 'Loading Duration...' + CAST(DATEDIFF(SECOND,@startTime,@endtime) AS NVARCHAR) +' seconds';
-------------------------TABLE-6---------------------------------------

        SET @startTime = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '-------------------------------------------------------';
		PRINT 'Loading.. erp_px_cat_g1v2 table';
		PRINT '-------------------------------------------------------';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\sql-data-warehouse-project\datasets\source_erp\Px_CAT_G1V2.csv'
		WITH(
		   FIRSTROW = 2,
		   FIELDTERMINATOR = ',',
		   TABLOCK
		)
		SET @endTime = GETDATE()
        PRINT 'Loading Duration...' + CAST(DATEDIFF(SECOND,@startTime,@endtime) AS NVARCHAR) +' seconds';
		--SELECT * FROM bronze.erp_px_cat_g1v2
   END TRY
   BEGIN CATCH
		PRINT '====================================================================='
		PRINT 'ERROR OCCURED'
		PRINT 'ERROR_MESSAGE '  +ERROR_MESSAGE()
		PRINT 'ERROR_NUMBER  '  +ERROR_NUMBER()
		PRINT 'ERROR_LINE    '  +ERROR_LINE()
		PRINT 'ERROR_STATE   '  +ERROR_STATE()
		PRINT '====================================================================='
   END CATCH
   SET @batch_end_time = GETDATE()
   PRINT 'Bronze Layer Took....' + CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) +' seconds';
END
