WITH 
    source_employee AS (
        SELECT *
        FROM {{ source('sap_adw', 'employee') }}
    ),

    formatted_employee AS (
        SELECT 
            businessentityid AS employee_id
            , jobtitle AS job_tittle
            , birthdate AS birth_date
            , hiredate AS hire_date
            , vacationhours AS vacation_hours
            , sickleavehours AS sick_leave_hours
            , currentflag AS current_flag
            , case 
                when gender = "F" then "Female"
                when gender = "M" then "Masculine"
                else gender
              end as gender
        FROM source_employee
    )

SELECT *
FROM formatted_employee
