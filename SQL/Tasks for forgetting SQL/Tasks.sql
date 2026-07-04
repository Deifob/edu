-- Задача 1
with all_ as (
	select 
		e.first_name as name,
		d.department_name as department,
		rank()	over(partition by e.department_id order by e.salary desc ) as rank
	from employees e 
	full join orders o 
	on e.id = o.customer_id 
	full join departments d 
	on e.department_id = d.department_id 
	full join customers c 
	on e.id = c.customer_id 
	where e.salary > 30000
)
select *
from all_
where rank < 4
-- Задача 2
with all_ as (
	select 
		id,
		department_id,
		salary,
		AVG(salary) OVER(partition by department_id) as avg
	from employees 
)
select 
	a.id,
	ROUND(a.salary - a.avg) as delta,
	d.department_name 
from all_ a
join departments d 
on a.department_id = d.department_id 
where salary > avg