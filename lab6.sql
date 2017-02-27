-- Dio Minott
-- 2/27/17

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Agents;
DROP TABLE IF EXISTS Products;


-- Customers --
CREATE TABLE Customers (
  cid      char(4) not null,
  name     text,
  city     text,
  discount decimal(5,2),
 primary key(cid)
);


-- Agents --
CREATE TABLE Agents (
  aid           char(3) not null,
  name          text,
  city          text,
  commissionPct decimal(5,2),
 primary key(aid)
);        


-- Products --
CREATE TABLE Products (
  pid      char(3) not null,
  name     text,
  city     text,
  quantity integer,
  priceUSD numeric(10,2),
 primary key(pid)
);


-- Orders -- 
CREATE TABLE Orders (
  ordNumber integer not null,
  month     char(3),    
  cid       char(4) not null references customers(cid),
  aid       char(3) not null references agents(aid),
  pid       char(3) not null references products(pid),
  qty       integer,
  totalUSD  numeric(12,2),
 primary key(ordNumber)
);



-- SQL statements for loading example data 

-- Customers --
INSERT INTO Customers( cid, name, city, discount )
  VALUES('c001', 'Tiptop', 'Duluth', 10.00);

INSERT INTO Customers( cid, name, city, discount )
  VALUES('c002', 'Tyrell', 'Dallas', 12.00);

INSERT INTO Customers( cid, name, city, discount )
  VALUES('c003', 'Allied', 'Dallas', 8.00);

INSERT INTO Customers( cid, name, city, discount )
  VALUES('c004' ,'ACME' ,'Duluth', 8.50);

INSERT INTO Customers( cid, name, city, discount )
  VALUES('c005' ,'Weyland', 'Risa', 0.00);

INSERT INTO Customers( cid, name, city, discount )
  VALUES('c006' ,'ACME' ,'Kyoto' ,0.00);


-- Agents --
INSERT INTO Agents( aid, name, city, commissionPct )
VALUES('a01', 'Smith', 'New York', 6.50 ),
      ('a02', 'Jones', 'Newark', 6.00 ),
      ('a03', 'Perry', 'Tokyo', 7.00 ),
      ('a04', 'Grey', 'New York', 6.00 ),
      ('a05', 'Otasi', 'Duluth', 5.00 ),
      ('a06', 'Smith', 'Dallas', 5.00 ),
      ('a08', 'Bond', 'London', 7.07 );


-- Products --
INSERT INTO Products( pid, name, city, quantity, priceUSD )
  VALUES('p01', 'comb', 'Dallas', 111400, 0.50 );

INSERT INTO Products( pid, name, city, quantity, priceUSD )
  VALUES('p02', 'brush', 'Newark', 203000, 0.50 );

INSERT INTO Products( pid, name, city, quantity, priceUSD )
  VALUES('p03', 'razor', 'Duluth', 150600, 1.00 );

INSERT INTO Products( pid, name, city, quantity, priceUSD )
  VALUES('p04', 'pen', 'Duluth', 125300, 1.00 );

INSERT INTO Products( pid, name, city, quantity, priceUSD )
  VALUES('p05', 'pencil', 'Dallas', 221400, 1.00 );

INSERT INTO Products( pid, name, city, quantity, priceUSD )
  VALUES('p06', 'trapper','Dallas', 123100, 2.00 );

INSERT INTO Products( pid, name, city, quantity, priceUSD )
  VALUES('p07', 'case', 'Newark', 100500, 1.00 );

INSERT INTO Products( pid, name, city, quantity, priceUSD )
  VALUES('p08', 'eraser', 'Newark', 200600, 1.25 );


-- Orders --
INSERT INTO Orders( ordNumber, month, cid, aid, pid, qty, totalUSD )
VALUES(1011, 'Jan', 'c001', 'a01', 'p01', 1000,  450.00),
      (1012, 'Jan', 'c002', 'a03', 'p03', 1000,  880.00),
      (1015, 'Jan', 'c003', 'a03', 'p05', 1200, 1104.00),
      (1016, 'Jan', 'c006', 'a01', 'p01', 1000,  500.00),
      (1017, 'Feb', 'c001', 'a06', 'p03',  600,  540.00),
      (1018, 'Feb', 'c001', 'a03', 'p04',  600,  540.00),
      (1019, 'Feb', 'c001', 'a02', 'p02',  400,  180.00),
      (1020, 'Feb', 'c006', 'a03', 'p07',  600,  600.00),
      (1021, 'Feb', 'c004', 'a06', 'p01', 1000,  460.00),
      (1022, 'Mar', 'c001', 'a05', 'p06',  400,  720.00),
      (1023, 'Mar', 'c001', 'a04', 'p05',  500,  450.00),
      (1024, 'Mar', 'c006', 'a06', 'p01',  800,  400.00),
      (1025, 'Apr', 'c001', 'a05', 'p07',  800,  720.00),
      (1026, 'May', 'c002', 'a05', 'p03',  800,  744.00);


-- SQL statements for displaying the example data

select *
from Customers;

select *
from Agents;

select *
from Products;

select *
from Orders;

-- 1) Display the name and city of customers who live in any city that makes the most different kinds of products.
-- (There are two cities that make make the most different products. Return the name and city of customers from either one of those.
select name, city
from customers
where city in (select city
		from products
		group by city
		order by count (products.city) desc limit 1);
        
-- 2) Display the names of products whose priceUSD is strictly above the avg priceUSD in reverse-alphabetical order.
select name
from products p
where priceUSD > (select avg (priceUSD)
                  from products)
order by name desc;
        
-- 3) Display	the	customer name, pid ordered, and the	total for all orders, sorted by	total from low to high
SELECT customers.name, orders.pid, orders.dollars
FROM orders 
INNER JOIN customers
ON orders.cid = customers.cid
ORDER BY orders.dollars DESC;

-- 4) Display all customer	names (in alphabetical order) and their	total ordered, and	nothing	more. Use coalesce to avoid	showing	NULLs.	
select customers.name, coalesce(sum(orders.qty), 0) as "total ordered"
from orders
right outer join customers
on orders.cid = customers.cid
group by customers.name
order by customers.name ASC;

-- 5)Display the names of all customers	who	bought products	from agents	based in Newark	along with the names of	the	products they ordered, and the names of	the	
-- agents who sold it to	them
select customers.name, products.name, agents.name
from orders 
inner join customers
on orders.cid = customers.cid
inner join products
on orders.pid = products.pid
inner join agents
on orders.aid = agents.aid
where agents.city = 'newark';

-- 6) Write a	query to check	the	accuracy of	the	totalUSD column	in the Orders table. This means	calculating	Orders.totalUSD	from data in other tables and comparing	those	
-- values to the values	in Orders.totalUSD.	Display	all	rows in	Orders where Orders.totalUSD is	incorrect, if any
select *
from (select o.*, o.qty*p.priceusd*(1-(discount/100)) as money
      from orders o
      inner join products p on o.pid = p.pid
      inner join customers c on o.cid = c.cid) as temptable
where dollars != money;

-- 7) What’s the difference	between	a LEFT OUTER JOIN and a	RIGHT OUTER	JOIN? Give example queries in SQL to demonstrate.	
/* In the left outer join, all rows from the left table will be displayed, regardless if it matches columns on the right table. 
In the right outer join all rows from the right table will be displayed regardless if it matches the columns on left table. for example: 

select *
from orders
left outer join customers
on customers.cid = orders.cid; 

all of the orders table and values for parts of the customers table.

select *
from orders
right outer join customers 
on customers.cid = orders.cid;

all of the customers table and NULL values for parts of the orders table.

*/