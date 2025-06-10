@echo off
REM Activate Python virtual environment
call C:\Users\vinayak.kumar\project\dbt-env\Scripts\activate.bat
 
REM Change to dbt project directory
cd C:\Users\vinayak.kumar\project
 
REM Run dbt commands
dbt deps
dbt run
dbt test
 
REM Optional: Log time of completion
echo dbt finished at %DATE% %TIME% >> C:\Users\vinayak.kumar\project\dbt_log.txt