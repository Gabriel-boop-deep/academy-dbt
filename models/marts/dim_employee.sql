with 
    sales_person as (
        select *
        from {{ ref('stg_adw_sales_person') }}
    )

    , employee as (
        select *
        from {{ ref('stg_adw_employee') }}
    )

    , person as (
        select *
        from {{ ref('stg_adw_person') }}
    )

    , dim_employee as (
        select 
            sales_person.sales_person_id
            , sales_person.territory_id
            , person.person_name
            , employee.job_tittle
            , employee.birth_date
            , employee.gender
            , employee.hire_date
            , employee.vacation_hours
            , employee.sick_leave_hours
            , sales_person.bonus
            , sales_person.commission_pct
            , employee.current_flag
            , sales_person.sales_quota
            , sales_person.sales_ytd
            , sales_person.sales_last_year
        from sales_person
        left join employee
            on sales_person.sales_person_id = employee.employee_id
        left join person
            on sales_person.sales_person_id = person.person_id
    )

    , dim_employee_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['sales_person_id']) }} as employee_sk
            , *
        from dim_employee
    )

select *
from dim_employee_sk