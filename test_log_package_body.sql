create or replace PACKAGE BODY TEST_LOG AS 

    PROCEDURE RUN_LOG_PROCEDURE( 
        PROCEDURE_NAME VARCHAR2, 
        ACTION_RESULT VARCHAR2, 
        ACTION_STEP VARCHAR2, 
        PROCEDURE_ID NUMBER
        ) 

        IS  
     
        V_PROCEDURE_NAME VARCHAR2(64) := PROCEDURE_NAME; 
        V_ACTION_RESULT VARCHAR2(64) := ACTION_RESULT; 
        V_ACTION_STEP VARCHAR2(64) := ACTION_STEP; 
        V_PROCEDURE_ID NUMBER := PROCEDURE_ID; 
         
 
        BEGIN

            INSERT INTO LOG_PROCEDURE ( 
                PROCEDURE_NAME, 
                ACTION_DATE, 
                ACTION_RESULT, 
                ACTION_STEP, 
                PROCEDURE_ID, 
                USER_NAME 
            )   
                SELECT 
                    V_PROCEDURE_NAME, 
                    CURRENT_TIMESTAMP, 
                    V_ACTION_RESULT, 
                    V_ACTION_STEP, 
                    V_PROCEDURE_ID, 
                    USER
                    FROM DUAL 
                 
            COMMIT;          
 
    END RUN_LOG_PROCEDURE; 
 
    PROCEDURE TEST_INSERT_x_UPDATE (PROCEDURE_ID NUMBER) IS 
 
        V_PROCEDURE_NAME VARCHAR2(64) := 'TEST_INSERT_x_UPDATE'; 
        V_ACTION_RESULT VARCHAR2(64) := ''; 
        V_ACTION_STEP VARCHAR2(64) := 'START'; 
        V_PROCEDURE_ID NUMBER := PROCEDURE_ID; 
         
 
          
 
        BEGIN  

            EXECUTE IMMEDIATE 'TRUNCATE TABLE CARS_ERR_LOG';
 
            RUN_LOG_PROCEDURE( 
                V_PROCEDURE_NAME, 
                V_ACTION_RESULT, 
                V_ACTION_STEP, 
                V_PROCEDURE_ID 
                ); 
 
                INSERT INTO CARS ( 
                    ID, 
                    CAR_ID, 
                    MILEAGE, 
                    VEHICLE_AGE, 
                    REPORTED_ISSUES, 
                    TIRE_CONDITION, 
                    BRAKE_CONDITION, 
                    BATTERY_STATUS, 
                    DAY_SINCE_LAST_SERVICE, 
                    DAY_TO_WARRANTY_EXPIRE 
                ) 
                    SELECT * FROM CARS_SOURCE 
                    WHERE ID < 50 
                    UNION ALL 
                    SELECT 101,  
                    NULL, 
                    NULL, 
                    NULL, 
                    NULL, 
                    NULL, 
                    NULL, 
                    NULL, 
                    NULL, 
                    NULL FROM DUAL                 
                LOG ERRORS INTO CARS_ERR_LOG REJECT LIMIT UNLIMITED; 
 
                V_ACTION_RESULT := 'INSERTED INTO CARS' || SQL % ROWCOUNT || 'ROWS' ; 
                V_ACTION_STEP := 'STEP'; 
                
 
                RUN_LOG_PROCEDURE( 
                    V_PROCEDURE_NAME, 
                    V_ACTION_RESULT, 
                    V_ACTION_STEP, 
                    V_PROCEDURE_ID 
                    ); 
 
                UPDATE CARS  
                    SET MILEAGE = 0 
                    WHERE ID < 25 
                LOG ERRORS INTO CARS_ERR_LOG REJECT LIMIT UNLIMITED; 
 
                V_ACTION_RESULT := 'UPDATED CARS' || SQL % ROWCOUNT || 'ROWS' ; 
                V_ACTION_STEP := 'STEP'; 
                 
                RUN_LOG_PROCEDURE( 
                    V_PROCEDURE_NAME, 
                    V_ACTION_RESULT, 
                    V_ACTION_STEP, 
                    V_PROCEDURE_ID 
                    ); 
 
                COMMIT; 
               
 
                V_ACTION_RESULT := NULL ; 
                V_ACTION_STEP := 'END'; 
 
                RUN_LOG_PROCEDURE( 
                    V_PROCEDURE_NAME, 
                    V_ACTION_RESULT, 
                    V_ACTION_STEP, 
                    V_PROCEDURE_ID 
                    ); 

                
                       
                 
    END TEST_INSERT_x_UPDATE; 
 
 
    PROCEDURE TEST_DELETE(PROCEDURE_ID NUMBER) IS 
 
        V_PROCEDURE_NAME VARCHAR2(64) := 'TEST_DELETE'; 
        V_ACTION_RESULT VARCHAR2(64) := ''; 
        V_ACTION_STEP VARCHAR2(64) := 'START'; 
        V_PROCEDURE_ID NUMBER := PROCEDURE_ID; 
          
        BEGIN

            EXECUTE IMMEDIATE 'TRUNCATE TABLE ERR_TEST_DELETE'; 
 
            RUN_LOG_PROCEDURE( 
                V_PROCEDURE_NAME, 
                V_ACTION_RESULT, 
                V_ACTION_STEP, 
                V_PROCEDURE_ID 
                ); 
 
            DELETE FROM CARS 
                WHERE VEHICLE_AGE = 4 
            LOG ERRORS INTO CARS_ERR_LOG REJECT LIMIT UNLIMITED; 
 
            V_ACTION_RESULT := 'DELETED FROM CARS' || SQL % ROWCOUNT || 'ROWS' ; 
            V_ACTION_STEP := 'STEP'; 
 
            RUN_LOG_PROCEDURE( 
                V_PROCEDURE_NAME, 
                V_ACTION_RESULT, 
                V_ACTION_STEP, 
                V_PROCEDURE_ID 
                ); 
 
            V_ACTION_RESULT := NULL ; 
            V_ACTION_STEP := 'END'; 
             
            RUN_LOG_PROCEDURE( 
                V_PROCEDURE_NAME, 
                V_ACTION_RESULT, 
                V_ACTION_STEP, 
                V_PROCEDURE_ID 
                ); 
 
            COMMIT; 
 
            
        
    END TEST_DELETE; 
 
END TEST_LOG;
/