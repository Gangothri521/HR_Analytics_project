use project_hr_analytics;
select * from HR;
-- KPI 1: Total number of employees
select count(*) as total_employee from HR;

-- KPI 1b : CURRENT employees only (excludes those who left)
SELECT COUNT(*) AS current_employees FROM HR WHERE termdate='';
-- Employee left 
SELECT COUNT(*) AS left_employees FROM HR WHERE termdate !='';

-- KPI 2: Percent of workers working remotely and in HQ (In-Office)
SELECT location,
    COUNT(*) AS emp_work_mode,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM HR), 2) AS per_of_total
FROM HR
GROUP BY location;

select location ,count(*) as emp_work_mode,
round(count(*) * 100.0 / (select Count(*) from HR),2) as per_of_total from HR group by location;

-- KPI 3: Average age of employees
select round(AVG(Age), 1) AS average_age FROM HR;

-- KPI 3b: Average age, current employees only
select round(AVG(Age), 1) AS average_age_current from HR where termdate='';

-- For Line chart Hiring Rate By Year
select
    year(str_to_date(hire_date, '%d-%m-%Y')) AS hire_year,
    count(*) AS employees_hired
from HR
group by hire_year
order by hire_year;

select * from HR limit 10;

-- For DONUT CHART - Gender Split
select gender, count(*) as emp_count,
round(count(*) * 100.0 /(select count(*) from HR),2) as per_total from HR
group by gender;

-- For BAR CHARTS Employees by State
select location_state, count(*) as count_of_location_state from HR group by location_state order by count_of_location_state desc;

-- For BAR CHARTS Employees by Department
select department, count(*) as count_of_department_emp from HR group by department order by count_of_department_emp desc;
select distinct department from HR;

-- For BAR CHARTS Employees by Race
select race, count(*) as count_race_wise from HR group by race order by count_race_wise desc;

select race,count(*) as count_race_wise,
round(count(*) * 100.0 / ( select count(*) from HR),2) as per_of_total
from HR group by race order by count_race_wise desc;


SELECT
    ROUND(
        SUM(CASE WHEN termdate IS NOT NULL AND termdate <> '' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS attrition_rate_pct
FROM HR;

SELECT DISTINCT termdate FROM HR LIMIT 20;

 -- Remote vs HQ split by department (any department fully remote/HQ?)
SELECT
    department,
    location,
    COUNT(*) AS headcount
FROM HR
GROUP BY department, location
ORDER BY department, location;

-- Q2.2 Are certain departments skewed younger/older?
SELECT
    department,
    ROUND(AVG(Age), 1) AS avg_age,
    MIN(Age) AS youngest,
    MAX(Age) AS oldest
FROM HR
GROUP BY department
ORDER BY avg_age DESC;

