CREATE OR ALTER PROCEDURE BRONZE.load_bronze AS
BEGIN
    DECLARE  @startTime DATETIME,@endTime DATETIME,@batch_Start_Time DATETIME,@batch_End_Time DATETIME
    BEGIN TRY
        SET @batch_Start_Time=GETDATE()
        print '=======================================';
        print 'Loading the Bronze layer';
        print '=======================================';
        print 'Loading CRM Tables'
        
        SET @startTime=GETDATE();
        print '>>Truncating table bronze.crm_cust_info'
        TRUNCATE TABLE bronze.crm_cust_info;
        print'Inserting data into bronze.crm_cust_info'
        BULK INSERT bronze.crm_cust_info
        FROM '/var/opt/mssql/data/csv/cust_info.csv'
        WITH (
            FIRSTROW=2,
            FIELDTERMINATOR=',',
            TABLOCK
        );
        SET @endTime=GETDATE();
        print 'Load duration time '+CAST(DATEDIFF(second,@startTime,@endTime) AS NVARCHAR)

        print '=======================================';

        SET @startTime=GETDATE();
        print '>>Truncating table bronze.crm_prd_info'
        TRUNCATE TABLE bronze.crm_prd_info;
        print'Inserting data into bronze.crm_prd_info'

        BULK INSERT bronze.crm_prd_info
        FROM '/var/opt/mssql/data/csv/prd_info.csv'
        WITH (
            FIRSTROW=2,
            FIELDTERMINATOR=',',
            TABLOCK
        );
        SET @endTime=GETDATE();
        print 'Load duration time '+CAST(DATEDIFF(second,@startTime,@endTime) AS NVARCHAR)

        print '=======================================';

        SET @startTime=GETDATE();
        print '>>Truncating table bronze.crm_sales_details'
        TRUNCATE TABLE bronze.crm_sales_details;
        print'Inserting data into bronze.crm_sales_details'

        BULK INSERT bronze.crm_sales_details
        FROM '/var/opt/mssql/data/csv/sales_details.csv'
        WITH (
            FIRSTROW=2,
            FIELDTERMINATOR=',',
            TABLOCK
        );
        print '=======================================';
        print 'Loading ERP Tables';
        print '=======================================';

        SET @endTime=GETDATE();
        print 'Load duration time '+CAST(DATEDIFF(second,@startTime,@endTime) AS NVARCHAR)
        print '=======================================';

        SET @startTime=GETDATE();
        print '>>Truncating table bronze.erp_PX_CAT_G1V2'
        TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
        print'Inserting data into bronze.erp_PX_CAT_G1V2'

        BULK INSERT bronze.erp_PX_CAT_G1V2
        FROM '/var/opt/mssql/data/csv/PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW=2,
            FIELDTERMINATOR=',',
            TABLOCK
        );
        SET @endTime=GETDATE();
        print 'Load duration time '+CAST(DATEDIFF(second,@startTime,@endTime) AS NVARCHAR)
        print '=======================================';

        SET @startTime=GETDATE();
        print '>>Truncating table bronze.erp_CUST_AZ12'
        TRUNCATE TABLE bronze.erp_CUST_AZ12;
        print'Inserting data into bronze.erp_CUST_AZ12'

        BULK INSERT bronze.erp_CUST_AZ12
        FROM '/var/opt/mssql/data/csv/CUST_AZ12.csv'
        WITH (
            FIRSTROW=2,
            FIELDTERMINATOR=',',
            TABLOCK
        );
        SET @endTime=GETDATE();
        print 'Load duration time '+CAST(DATEDIFF(second,@startTime,@endTime) AS NVARCHAR)
        print '=======================================';
        
        SET @startTime=GETDATE();
        print '>>Truncating table bronze.erp_LOC_A101'
        TRUNCATE TABLE bronze.erp_LOC_A101;
        print'Inserting data into bronze.erp_LOC_A101'

        BULK INSERT bronze.erp_LOC_A101
        FROM '/var/opt/mssql/data/csv/LOC_A101.csv'
        WITH (
            FIRSTROW=2,
            FIELDTERMINATOR=',',
            TABLOCK
        );
        SET @endTime=GETDATE();
        print 'Load duration time '+CAST(DATEDIFF(second,@startTime,@endTime) AS NVARCHAR)
        print '=======================================';
        
    END TRY
    BEGIN CATCH
        print '=======================================';
        print 'Error Occured while Loading Bronze Layer'
        print 'Error Message'+ ERROR_MESSAGE();
        print 'Error Number'+ CAST(ERROR_NUMBER() AS NVARCHAR);
        print '=======================================';
    END CATCH
    SET @batch_End_Time=GETDATE()
    print '=======================================';
    print 'Batch duration time '+CAST(DATEDIFF(second,@batch_Start_Time,@batch_End_Time) AS NVARCHAR)
    print '=======================================';
END

EXEC bronze.load_bronze
