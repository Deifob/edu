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
-- Задача 3
with all_ as (	
	select 
		e.first_name,
		d.department_name ,
		e.salary,
		RANK() OVER(partition by e.department_id order by e.salary) as rnk,
		COUNT(d.department_name) OVER(partition by d.department_name ) as summ
	from employees e
	join departments d 
	on e.department_id = d.department_id 
)
select 
	first_name,
	department_name,
	salary
from all_ 
where summ > 2 and rnk = 1
-- Задача 4
with all_ as(	
	select 
		o.order_id,
		c.customer_name,
		o.amount,
		rank() OVER(partition by o.customer_id order by o.amount DESC) as rnk
	from orders o 
	join customers c 
	on o.customer_id = c.customer_id
)
select *
from all_ 
where amount > 1000
-- Задача 5
with all_ as(
	select 
		e.first_name,
		d.department_name,
		e.hire_date,
		rank() over(partition by d.department_name order by e.hire_date desc ) as rnk
	from employees e 
	join departments d 
	on e.department_id = d.department_id 
)
select *
from all_
where rnk = 1
-- Задача 6
with cust as(
	select 
		customer_id,
		SUM(amount) as sum_cust,
		count(customer_id) as count_cust
	from orders
	group by customer_id
)
select 
	cu.customer_name,
	c.sum_cust,
	c.sum_cust /(sum(c.sum_cust) over()) as part
from cust as c
inner join customers as cu
on c.customer_id = cu.customer_id 
where c.count_cust > 1
-- Задача 7
with rang as (
	select 
		*,
		rank() over(partition by department_id order by salary desc) as rnk
	from employees
),
summ as (
	select
		department_id,
		count(id) as cnt
	from employees
	group by department_id
)
select 
	r.rnk,
	1.0*r.rnk/s.cnt as part, 
	r.salary,
	d.department_name 
from rang r
join departments d 
on r.department_id = d.department_id 
join summ s
on r.department_id = s.department_id 
where 1.0*r.rnk/s.cnt <= 0.1
