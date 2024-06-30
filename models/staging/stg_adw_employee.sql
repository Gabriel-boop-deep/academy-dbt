with
    source_employee as (
        select *
        from {{ source('sap_adw', 'employee') }}
    )

    , formatted_employee as (
        select
            businessentityid as employee_id
            , jobtitle as job_tittle
            , birthdate as birth_date
            , hiredate as hire_date
            , vacationhours as vacation_hours
            , sickleavehours as sick_leave_hours
            , currentflag as current_flag
        from source_employee
    )

select *
from formatted_employee
