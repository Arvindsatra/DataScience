--1) Display the count of customer in each region who has done the transaction 
--in year 2020
select ct.region_name, count(distinct c.customer_id) as NumOfCustomers
from Customers c
join Continent ct on c.region_id = ct.region_id
join Transactions t on t.customer_id = c.customer_id
where year(t.txn_date) = 2020
group by ct.region_name

--2) Display the maximum, minimum of transaction amount of each transaction type.
select txn_type, max(txn_amount) as MaxAmount, min(txn_amount) as MinAmount
from Transactions
group by txn_type

--3) Display customer id, region name and transaction amount where transaction
--type is deposit and transaction amount > 2000.
select t.customer_id, ct.region_name, t.txn_amount
from Transactions t
join Customers c on t.customer_id = c.customer_id 
join Continent ct on c.region_id = ct.region_id
where t.txn_type = 'deposit' and t.txn_amount > 2000

--4) Find duplicate records in a customer table.
select customer_id, count(*) as duplicate_count
from customers
group by customer_id
having count(*) > 1

--5) Display the detail of customer id, region name, transaction type and 
--transaction amount for the minimum transaction amount in deposit.
select t.customer_id, ct.region_name, t.txn_type, min(t.txn_amount)MinTxnAmount
from Transactions t
join Customers c on t.customer_id = c.customer_id 
join Continent ct on c.region_id = ct.region_id
where t.txn_type = 'deposit'
group by t.customer_id, ct.region_name, t.txn_type
order by t.customer_id


--6) Create a stored procedure to display details of customer and transaction
--table where transaction date is greater than Jun 2020.
create procedure CustomerAndTransactions
as 
begin
select * from Customers c
join Transactions t on c.customer_id = t.customer_id
where t.txn_date > '2020-06-30'
end

exec CustomerAndTransactions

--7) Create a stored procedure to insert a record in the continent table.
create procedure InsertNew (@region_id int, @region_name varchar(50))
as 
begin
	insert into Continent
	values (@region_id, @region_name)
end

exec InsertNew 0,'India'

select region_id, region_name from Continent
where region_id = 0

delete from Continent
where region_id = 0 and region_name = 'India'


--8) Create a stored procedure to display the details of transactions that 
--happened on a specific day.
create procedure Tans_details (@txn_date date)
as 
begin 
	select * from Transactions
	where txn_date = @txn_date
end

exec Tans_details '2020-01-13'

--9) Create a user defined function to add 10% of the transaction amount in a table.

create function addTansactionamount(@amount decimal(18,2))
returns decimal(18,2)
as 
begin
	declare @result decimal(18,2)
	set @result = @amount + (@amount*0.1)
	return @result
end

SELECT txn_amount, dbo.addTansactionamount(txn_amount) AS increased_amount
FROM Transactions


--10) Create a user defined function to find the total transaction amount for 
--a given transaction type.
create function transaction_amt(@transtype varchar(50))
returns int
begin
	declare @totalAmount int

	select @totalAmount = sum(txn_amount)
	from Transactions
	where txn_type = @transtype

	return @totalAmount
end

select dbo.transaction_amt('deposit') as TotalDepositAmount


--11) Create a table value function which comprises of the following columns 
--customer_id, region_id ,txn_date , txn_type , txn_amount which will retrieve
--data from the above table.

create function gettransactiondate()
returns table
as
return 
	select c.customer_id, ct.region_id, t.txn_date, t.txn_type, t.txn_amount
	from Transactions t
	join Customers c on t.customer_id = c.customer_id
	join Continent ct on c.region_id = ct.region_id

--12) Create a try catch block to print a region id and region name in a single 
--column.
begin try
	select region_id +'-'+region_name as region
	from Continent
end try
begin catch
	declare @ErrorMessage nvarchar(4000) = error_message()
	raiserror('An error occured: %s',16,1,@ErrorMessage)
end catch

--13) Create a try catch block to insert a value in the continent table.
begin try
	insert into Continent( region_id, region_name)
	values (1,'North America')
end try
begin catch
	declare @ErrorMessage nvarchar(4000) = error_message()
	raiserror('An error occurred: %s', 1, 1, @ErrorMessage)
end catch

--14) Create a trigger to prevent deleting a table in a database.
create trigger PreventDelete
on database
instead of delete
as 
begin
	raiserror('Deleting tables is not allowed.',16,1)
	rollback transaction
end

--15) Create a trigger to audit the data in a table.


--16) Create a trigger to prevent login of the same user id in multiple pages.


--17) Display top n customers on the basis of transaction type.
SELECT customer_id, txn_type, transaction_count
FROM (
    SELECT customer_id, txn_type, COUNT(*) AS transaction_count,
           ROW_NUMBER() OVER (PARTITION BY txn_type ORDER BY COUNT(*) DESC) AS row_num
    FROM Transactions
    GROUP BY customer_id, txn_type
) AS subquery
WHERE row_num <= 5;


--18) Create a pivot table to display the total purchase, withdrawal and deposit for all the customers.

SELECT *
FROM (
    SELECT customer_id, txn_type, txn_amount
    FROM Transactions
) AS src
PIVOT (
    SUM(txn_amount)
    FOR txn_type IN ([purchase], [withdrawal], [deposit])
) AS pivot_table;
