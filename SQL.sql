create table Customers (CustomerID int primary key,
customeres_Name varchar,
Age int, 
Gender varchar, 
Region varchar,
Email varchar);


create table  Products (ProductID int primary key,
ProductName varchar, 
Category varchar,
Price int,
StockQuantity int);

create table Sales (SaleID int primary key, 
salesDate date, 
CustomerID int REFERENCES Customers(CustomerID),
ProductID int REFERENCES Products(ProductID), Quantity int,
TotalAmount real );

create table Returnss (ReturnID varchar primary key,
SaleID int REFERENCES Sales(SaleID), 
ReturnDate date, 
Reason varchar);



 copy Customers from 'C:/ass/customers1.cvs' delimiter ',' csv header;
 copy Products from 'C:/ass/products.cvs' delimiter ',' csv header;
 copy Sales from 'C:/ass/sales.cvs' delimiter ',' csv header;
 copy Returnss from 'C:/ass/returns.cvs' delimiter ',' csv header;

-- Write a query to calculate monthly sales trends for each region and product category.

     select salesdate,c.region,p.productname,sum(totalamount) from sales s join customers c on s.customerid = c.customerid 
	  join products p on p.productid = s.productid 
	  group by salesdate,c.region,p.productname ,extract (month from salesdate);

-- Identify top 5 customers contributing to revenue using window functions.
       
select * from 
(select distinct (customerid),
sum(totalamount)
over(partition by customerid  order by totalamount  ) as Revenue
from sales)s
order by s.revenue desc limit 5;

--Implement a trigger to update stock automatically after each sale or return.

     create or replace trigger stockupdate()
	 returns as trigger as $$
	 begin
	      update on products set stockquantity = stockquantity 
	 end;
	 $$ language plpgsql


















