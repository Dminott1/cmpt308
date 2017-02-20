-- Dio Minott
-- 2/20/17

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

-- 1)
select city 
from agents a
inner join orders o
	on o.aid = a.aid and o.cid='c006';
    
-- 2)
Select distinct pid
From customers c, orders o
Where o.cid = c.cid
and c.city = 'kyoto'
Order by pid Desc;
     
     
-- 3)
select distinct name 
from customers
where not cid in 
	(select cid from Orders); 
    
-- 4)
select distinct name 
from customers c
left outer join orders o
     on c.cid = o.cid
where o.cid is null;

-- 5)
select distinct c.name, a.name 
from customers c, agents a, orders o
where c.city = a.city and o.aid = a.aid and o.cid = c.cid;

-- 6)
select distinct c.name, a.name 
from customers c, agents a, orders o
where c.city = a.city;

-- 7)
select c.name, c.city
from customers c
where c.city in (Select city
		 From products
		 Group by City
		 Order by count(pid) ASC
		 Limit 1);

