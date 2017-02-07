Select ordNumber , totalUSD from Orders;

Select name, city from Agents

Where  name = ‘Smith’ ;

Select pid, name, priceUSD from Products;
	Where  quantity > 200100;

Select name, city from Customers
    Where city = ‘Duluth’ ;

Select name from Products
	Where city not in (‘New York’,  ‘Duluth’) ;

Select * from Agents 
	Where city not in (‘Dallas’,  ‘Duluth’)  and priceUSD >=  1 ;

Select * from Orders
	where  month  =   ‘Feb’  or  month  =  ‘May’ ;

Select * from Orders
	where  month  =   ‘Feb’  and priceUSD  >=  600;
	
	
Select * from Orders
	where cid   =  ‘C005’ ;



