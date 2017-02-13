--Dio Minott
--2/13/17

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

-- 1) Get the cities of agents booking an order for a customer whose cid is 'c006'.	
select city 
from Agents 
where aid 
	in(select aid  from Orders
       where cid = 'c006');
       
-- 2) Get the distinct ids of products ordered through any agent who takes at least	one.	
-- order from a	customer in	Kyoto, sorted by pid from highest to lowest.
select distinct pid 
from Orders 
where aid in 
	(select aid from Orders
      where cid in
     	(select cid from Customers
			where city = 'Kyoto'));
 
-- 3) Get the ids and names	of customers who did not place an order	through	agent a01.	
select cid, name from customers
where cid not in 
(select cid from orders 
	where aid = 'a01');


-- 4) Get the ids of customers who ordered both product	p01	and	p07.	
select distinct cid, name from customers
where cid in
(select cid from orders 
 where pid = 'p01' and pid = 'p07');
 
-- 5) Get the ids of products not ordered by any customers who placed any order	through	
-- agent a08 in	pid	order from highest to lowest.	
select distinct pid
from Orders
where cid not in 
(select cid
	from Orders
	where aid = 'a08')
order by pid desc;


-- 6) Get the name, discount, and city for all customers who place orders through agents in Tokyo or New York.	
select name,discount,city
from customers
where cid in 
(select cid
	from orders where aid in 
 	(Select aid
		from agents
		where city = 'Tokyo' or city = 'New York'));
        
-- 7) Get all customers	who	have the same discount as that of any customers	in Duluth or London
select * from customers
where discount in 
(select discount 
 from customers where city = 'Duluth' or city = 'London');
 

/* Check constraints is a type of constraint which specifies a requirement that must be met by each row in a database table. Check constraints can be a simple limit on values
such as an enumeration of legal values or an arithmetic inequality. Also, constraints are used to ensure the validity of data in a database and to provide data integrity.
The advantage of putting that sort of thing inside the database is so user wont have a negative price or negative quantity.                                                         
*/
 

 
