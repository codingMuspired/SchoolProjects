-- Name: Bryan Aguiar
-- Class: CST 363 - Intro to Database Systems
-- Date: 1/12/21
-- e5.1 Exercises from chapter 5
--
-- Before you begin:
-- create the tables and data using the script 
--   zagimore_schema.sql
--
-- 1  Display all records in the REGION table
select *
from region;

-- 2 Display StoreID and StoreZIP for all stores
select storeid, storezip
from store;

-- 3 Display CustomerName and CustomerZip for all customers
--   sorted alphabetically by CustomerName
select customername, customerzip
from customer
order by customername;

-- 4 Display the RegionIDs where we have stores 
--   and do not display duplicates
select distinct regionid
from store;

-- 5 Display all information for all stores in RegionID C 
select *
from store
where regionid = 'C';

-- 6 Display CustomerID and CustomerName for customers who name 
--   begins with the letter T
select customerid, customername
from customer
where customername like 'T%';

-- 7 Display ProductID, ProductName and ProductPrice for 
--   products with a price of $100 or higher
select productid, productname, productprice
from product
where productprice >= 100;

-- 8 Display ProductID, ProductName, ProductPrice and VendorName
--   for products sorted by ProductID
select productid, productname, productprice, vendorname
from product, vendor
where product.vendorid = vendor.vendorid
order by productid;

-- 9 Display ProductID, ProductName, ProductPrice,  VendorName and CategoryName
--   for products.  Sort by ProductID
select productid, productname, productprice, vendorname, categoryname
from product, vendor, category
where product.vendorid = vendor.vendorid and product.categoryid = category.categoryid
order by productid;

-- 10 Display ProductID, ProductName, ProductPrice  
--   for products in category "Camping" sorted by ProductID
select productid, productname, productprice
from product
where product.categoryid in 
	(select categoryid
	from category
	where categoryname = 'Camping')
order by productid;

-- 11 Display ProductID, ProductName, ProductPrice  
--   for products sold in zip code "60600" sorted by ProductID
select productid, productname, productprice
from product
where product.productid in
	(select productid 
    from includes, store, salestransaction
    where includes.tid = salestransaction.tid 
    and salestransaction.storeid = store.storeid
    and store.storezip = '60600')
order by productid;

-- 12 Display ProductID, ProductName and ProductPrice for VendorName "Pacifica Gear" and were
--    sold in the region "Tristate".  Do not show duplicate information.
select distinct productid, productname, productprice
from product, vendor
where product.vendorid = vendor.vendorid
and vendor.vendorname = 'Pacifica Gear'
and product.productid in
	(select includes.productid
    from includes, salestransaction, store, region
    where includes.tid = salestransaction.tid
    and salestransaction.storeid = store.storeid
    and store.regionid = region.regionid
    and region.regionname = 'Tristate'
    );

-- 13 Display TID, CustomerName and TDate for any customer buying a product "Easy Boot"
--    Sorted by TID.
select salestransaction.tid, customer.customername, salestransaction.tdate
from salestransaction, customer
where salestransaction.customerid = customer.customerid
and salestransaction.tid  in
	(select includes.tid
    from includes, product
    where includes.productid = product.productid
    and productname = 'Easy Boot'
    )
order by tid;


-- 14 Create table and insert the following data

-- create table company with columns
--    companyid char(3), name varchar(50), ceo varchar(50)
--    make column companyid the primary key
create table company
(		companyid		char(3)			NOT NULL,
		name			varchar(50)		NOT NULL,
        CEO				varchar(50)		NOT NULL,
        primary key (companyid)); 

-- insert the following data 
--    companyid   name          ceo
--    ACF         Acme Finance  Mike Dempsey
--    TCA         Tara Capital  Ava Newton
--    ALB         Albritton     Lena Dollar
insert into company values ('ACF', 'Acme Finance', 'Mike Dempsey');
insert into company values ('TCA', 'Tara Capital', 'Ava Newton');
insert into company values ('ALB', 'Albritton', 'Lena Dollar');

-- create a table security with columns
--     secid, name, type
--     secid should be the primary key
create table security
(		secid		char(2)			NOT NULL,
		name		varchar(50)		NOT NULL,
        type		varchar(50)		NOT NULL,
        primary key (secid)); 

-- insert the following data
--    secid    name                type
--    AE       Abhi Engineering    Stock
--    BH       Blues Health        Stock
--    CM       County Municipality Bond
--    DU       Downtown Utlity     Bond
--    EM       Emmitt Machines     Stock
insert into security values ('AE', 'Abhi Engineering', 'Stock');
insert into security values ('BH', 'Blues Health', 'Stock');
insert into security values ('CM', 'County Municipality', 'Bond');
insert into security values ('DU', 'Downtown Utility', 'Bond');
insert into security values ('EM', 'Emmitt Machines', 'Stock');

-- create the following table called fund 
--  with columns companyid, inceptiondate, fundid, name
--   fundid should be the primary key
--   companyid should be a foreign key referring to the company table.
create table fund
(		companyid			char(3)			NOT NULL,
		inceptiondate		date			NOT NULL,
        fundid				char(2)			NOT NULL,
        name				varchar(50)		NOT NULL,
        primary key (fundid),
        foreign key (companyid) references company(companyid)); 
        
-- CompanyID  InceptionDate   FundID Name
--    ACF      2005-01-01     BG     Big Growth
--    ACF      2006-01-01     SG     Steady Growth
--    TCA      2005-01-01     LF     Tiger Fund
--    TCA      2006-01-01     OF     Owl Fund
--    ALB      2005-01-01     JU     Jupiter
--    ALB      2006-01-01     SA     Saturn
insert into fund values ('ACF', '2005-01-01', 'BG', 'Big Growth');
insert into fund values ('ACF', '2006-01-01', 'SG', 'Steady Growth');
insert into fund values ('TCA', '2005-01-01', 'LF', 'Tiger Fund');
insert into fund values ('TCA', '2006-01-01', 'OF', 'Owl Fund');
insert into fund values ('ALB', '2005-01-01', 'JU', 'Jupiter');
insert into fund values ('ALB', '2006-01-01', 'SA', 'Saturn');

-- create table holdings with columns
--   fundid, secid, quantity
--   make (fundid, secid) the primary key
--   fundid is also a foreign key referring to the fund  table
--   secid is also a foreign key referring to the security table
create table holdings
(		fundid			char(2)				NOT NULL,
		secid			char(2)				NOT NULL,
        quantity		numeric(6, 0)		NOT NULL,
        primary key (fundid, secid),
        foreign key (fundid) references fund(fundid),
        foreign key (secid) references security(secid)); 

--    fundid   secid    quantity
--     BG       AE           500
--     BG       EM           300
--     SG       AE           300
--     SG       DU           300
--     LF       EM          1000
--     LF       BH          1000
--     OF       CM          1000
--     OF       DU          1000
--     JU       EM          2000
--     JU       DU          1000
--     SA       EM          1000
--     SA       DU          2000
insert into holdings values('BG', 'AE', 500); 
insert into holdings values('BG', 'EM', 300); 
insert into holdings values('SG', 'AE', 300); 
insert into holdings values('SG', 'DU', 300); 
insert into holdings values('LF', 'EM', 1000); 
insert into holdings values('LF', 'BH', 1000); 
insert into holdings values('OF', 'CM', 1000); 
insert into holdings values('OF', 'DU', 1000); 
insert into holdings values('JU', 'EM', 2000); 
insert into holdings values('JU', 'DU', 1000); 
insert into holdings values('SA', 'EM', 1000); 
insert into holdings values('SA', 'DU', 2000);

-- 15 Use alter table command to add a column "price" to the 
--    security table.  The datatype should be numeric(7,2)
alter table security add (price numeric(7,2)); 

-- 16 drop tables company, security, fund, holdings.
--    You must drop them in a certain order.
drop table holdings;
drop table fund;
drop table security;
drop table company; 

-- 17 Try to delete the row for product with productid '5X1'
delete from product
where productid = '5X1';

-- 18 Explain why does the delete in question 17 fails.
-- The reason why question 17 fails is it is a parent row for vendor(vendorid)

-- 19 Try to delete the row for product with productid '5X2'
delete from product
where productid = '5X2';

-- 20 Re-insert productid '5X2'
insert into product values('5X2', 'Action Sandal', 70.00, 'PG', 'FW');

-- 21  update the price of '5X2', 'Action Sandal' by $10.00
update product
set productprice = 10.00
where productid = '5x2'
and productname = 'Action Sandal';

-- 22 increase the price of all products in the 'CY' category by 5%
update product
set productprice = productprice * 1.05
where  categoryid = 'CY';

-- 23 decrease the price of all products made by vendorname 'Pacifica Gear' by $5.00
update product
set productprice = productprice - 5
where vendorid in
(select vendorid
from vendor
where vendorname = 'Pacifica Gear');

-- 24 List productid and productprice for all products.  Sort by productid;
select productid, productprice
from product
order by productid;

