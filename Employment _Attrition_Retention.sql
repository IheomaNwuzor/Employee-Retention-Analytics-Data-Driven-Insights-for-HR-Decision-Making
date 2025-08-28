--HR Database
--Question 1: 
--Retrieve a combined dataset of employees by joining the three tables
select *
from table1 t1
join table2 t2 on t1.emp_no=t2.emp_no
join table3 t3 on t1.emp_no=t3.emp_no


--Question 2
-- Identify the top 5 highest-paid employees.
select emp_no, monthly_income
from table2
order by monthly_income desc
limit 5;

-- Question 3
-- Find the average monthly income per department.
select t1.department, round(avg(t2.monthly_income),2) as "Monthly Income"
from table1 t1
left join table2 t2 on t1.emp_no=t2.emp_no
group by department;

-- Question 4
-- Determine the correlation between job satisfaction and attrition 
select round(avg(t2.job_satisfaction),2) AS "Average Job Satisfaction"
from table1 t1
join table2 t2 on t2.emp_no=t1.emp_no
group by t1.attrition;


--Question 5
-- List employees who have worked at multiple companies
SELECT emp_no, num_companies_worked
FROM table3
WHERE Num_Companies_worked>1;


-- Question 6
-- Find the department with the highest attrition rate.
SELECT department, COUNT(*) As "Attrition Rate"
FROM table1
WHERE attrition = 'Yes'
GROUP BY department
ORDER BY "Attrition Rate" DESC
LIMIT 1;


--Question 7
-- Analyze the impact of training on employee performance
SELECT t2.training_times_last_year, ROUND(AVG(t3.performance_rating),2) 
FROM table2 t2
JOIN table3 t3 ON t2.emp_no=t3.emp_no
GROUP BY t2.training_times_last_year
ORDER BY t2.training_times_last_year ASC;


-- Question 8
--  Identify employees who received a salary hike but still left the company
SELECT percent_salary_hike
FROM table3 t3
JOIN table1 t1 on t3.emp_no=t1.emp_no
WHERE  percent_salary_hike >0 AND t1.attrition ='Yes';



-- Question 9
-- Determine the average work-life balance score of employees by job role
SELECT t1.job_role, round(AVG(work_life_balance),2) AS "Average Work_Life Balance Score"
FROM table1 t1 
JOIN table3 t3 ON t1.emp_no=t3.emp_no
GROUP BY job_role
ORDER BY "Average Work_Life Balance Score" DESC



-- Question 10
--  Calculate the percentage of employees who work overtime in each department.
SELECT department,
SUM(CASE WHEN over_time = 'Yes' THEN 1 ELSE 0 END) *100/COUNT(*) AS "employees who work overtime"
FROM table1 t1
GROUP BY department



==Question 11
-- Categorize Employees Based on Their Attrition Risk.
SELECT emp_no, years_at_company, CASE WHEN years_at_company >20 THEN 'Low Rist'
WHEN years_at_company BETWEEN 20 AND 30 THEN 'Medium Risk' ELSE 'Low Risk' END
FROM table3;


-- Question 12
--Replace Missing Last Promotion Years with Default Value.
SELECT emp_no, years_since_last_promotion,
COALESCE (years_since_last_promotion,
AVG(years_since_last_promotion))
FROM table3
GROUP BY emp_no;


-- Question 13
-- Find the Most Common Year When Employees Leave.
SELECT DATE_PART('year', date) As "year", COUNT (*) AS "Number of Attritions"
FROM table3 t3
JOIN table1 t1 on t1.emp_no=t3.emp_no
WHERE Attrition='Yes'
GROUP BY Year
ORDER BY "Number of Attritions" DESC
LIMIT 1;


