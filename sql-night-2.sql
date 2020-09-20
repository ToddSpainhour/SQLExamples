select ar.Name, al.Title [Album Title]
from artist ar
	inner join Album al 
		on ar.ArtistId = al.ArtistId

select ar.Name, al.Title [Album Title]
from artist ar 
	left join Album al 
		on ar.ArtistId = al.ArtistId

where al.AlbumId is null

select ar.Name, al.Title [Album Title]
from artist ar
	right join Album al 
		on ar.ArtistId = al.ArtistId


where ar.Name = 'Ac/DC'
--where Name like 'b%'
--where ArtistId > 12

select *
from Album
where ArtistId = 169


-- night 3


-- how much revenue did we make in 2009?
select *
from Invoice
where InvoiceDate between '1/1/2009' and '1/1/2010'

--when using between, the dates you specify are not actual included. is this acurate? 

--gives same results as above
select *
from Invoice
where Year(InvoiceDate) = 2009


-- for each BillingCountry group give me the sum of each of those columns
--select TOP 1 BillingCountry, sum(Total) as [InvoiceTotal], count(1) as [Count of Invoices]   you can also use order by using the index number of a column (like order by 2 would be the same saying order by InvoiceTotal)

select BillingCountry, sum(Total) as [InvoiceTotal], count(1) as [Count of Invoices], AVG(total) as Average, max(Total) as Max, min(total) as Min
from Invoice
group by BillingCountry
order by InvoiceTotal DESC
-- 
select sum(total), count(1)
from Invoice


-- filter it down to just these three customers
select *
from Invoice 
where CustomerId in (1, 2, 3)

--find me all the customers in Berlin
select *
from Customer
where City = 'Berlin'

-- subqueries, combine those two queries, the in column only works with one column 
select *
from Invoice 
where CustomerId in (
						select CustomerId
						from Customer
						where City = 'Berlin'
					)
group by CustomerId






select CustomerId, sum(total)
from Invoice 
where CustomerId in (
						select CustomerId
						from Customer
						where Company is not null
					)
group by CustomerId





-- subqueries must have an alias 
SELECT i.CustomerId, sum(total)
FROM Invoice i
	join (
			select CustomerId
			from Customer
			where Company is not null
		) c
		on i.CustomerId = c.CustomerId
group by i.CustomerId




--correlated subquery (use data from outer query) 

SELECT e.FirstName + ' ' + e.LastName as Name,
		E.EmployeeId,
		e.City,
		(
		select string_agg(FirstName + ' ' + LastName,',')
		from Customer
		where SupportRepId = e.EmployeeId
		) as Customers
	from Employee e





select *
from Employee e
where exists (select 0 from Customer c where c.SupportRepId = e.EmployeeId) 


select distinct e.*
from Employee e
join Customer c
on c.SupportRepId = e.EmployeeId



--multiple datasets
--union (only adds distinct data)
SELECT firstName, lastName, 'Customer' Type
FROM Customer
UNION
select firstName, lastName, 'Employee' Type
from Employee
-- union all (adds duplicates)
except
select 'Andrew', 'Adams', 'Employee'
order by type, LastName


--all employees that don't work hard
select *
FROM Employee
except 
select distinct e.*
from Employee e 
	join Customer c
		on c.SupportRepId = e.EmployeeId