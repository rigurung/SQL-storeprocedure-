if db_id('PremierProducts2') is not null
begin
   use master
   alter database PremierProducts2 set SINGLE_USER with rollback immediate
   drop database PremierProducts2
end

create database PremierProducts2
go

USE PremierProducts2;
go

/* create the tables */

CREATE TABLE Rep
(RepNum int Identity(1,1),
LastName VARCHAR(15),
FirstName VARCHAR(15),
Street VARCHAR(15),
City VARCHAR(15),
State VARCHAR(2),
Zip VARCHAR(5),
Commission MONEY,
Rate DECIMAL(3,2),
PRIMARY KEY (RepNum));

go

CREATE TABLE Customer
(CustomerNum int Identity(1,1) PRIMARY KEY,
CustomerName VARCHAR(35) NOT NULL,
Street VARCHAR(15),
City VARCHAR(15),
State VARCHAR(2),
Zip VARCHAR(5),
Balance MONEY,
CreditLimit MONEY,
RepNum INT,
FOREIGN KEY (RepNum) REFERENCES Rep)
;

go

CREATE TABLE Orders
(OrderNum int Identity(10000,1) PRIMARY KEY,
OrderDate DATETIME,
CustomerNum INT references Customer,
Billed BIT)
;

go

CREATE TABLE Part
(PartNum int Identity(100,5) PRIMARY KEY,
Description VARCHAR(15),
OnHand INT,
Class VARCHAR(2),
Warehouse VARCHAR(1),
Price MONEY )
;

go

CREATE TABLE OrderLine
(OrderNum INT references Orders,
PartNum INT references Part,
NumOrdered INT,
NumShipped INT,
QuotedPrice MONEY,
PRIMARY KEY (OrderNum, PartNum) )
;

go

/* Populate the database with initial data */

INSERT INTO Rep (LastName, FirstName, Street, City, State, Zip, Commission, Rate)
VALUES ('Kaiser','Valerie','624 Randall','Grove','FL','33321',20542.50,0.05);
Declare @KaiserNum int
select @KaiserNum = @@Identity

INSERT INTO Rep (LastName, FirstName, Street, City, State, Zip, Commission, Rate)
VALUES ('Hull','Richard','532 Jackson','Sheldon','FL','33553',39216.00,0.07);
Declare @HullNum int
select @HullNum = @@Identity

INSERT INTO Rep (LastName, FirstName, Street, City, State, Zip, Commission, Rate)
VALUES ('Perez','Juan','1626 Taylor','Fillmore','FL','33336',23487.00,0.05);
Declare @PerezNum int
select @PerezNum = @@Identity

INSERT INTO Customer (CustomerName, Street, City, State, Zip, Balance, CreditLimit, RepNum)
VALUES('Al''s Appliance and Sport','2837 Greenway','Fillmore','FL','33336',6550.00,7500.00,@KaiserNum);
Declare @AlApplNum int
select @AlApplNum = @@Identity

INSERT INTO Customer (CustomerName, Street, City, State, Zip, Balance, CreditLimit, RepNum)
VALUES('Brookings Direct','3827 Devon','Grove','FL','33321',431.50,10000.00,@HullNum);
Declare @BrookingsNum int
select @BrookingsNum = @@Identity

INSERT INTO Customer (CustomerName, Street, City, State, Zip, Balance, CreditLimit, RepNum)
VALUES('Ferguson''s','382 Wildwood','Northfield','FL','33146',5785.00,7500.00,@PerezNum);
Declare @FergusonNum int
select @FergusonNum = @@Identity

INSERT INTO Customer (CustomerName, Street, City, State, Zip, Balance, CreditLimit, RepNum)
VALUES('The Everything Shop','1828 Raven','Crystal','FL','33503',5285.25,5000.00,@HullNum);
Declare @EverythingNum int
select @EverythingNum = @@Identity

INSERT INTO Customer (CustomerName, Street, City, State, Zip, Balance, CreditLimit, RepNum)
VALUES('Bargains Galore','3829 Central','Grove','FL','33321',3412.00,10000.00,@PerezNum);
Declare @BargainsNum int
select @BargainsNum = @@Identity

INSERT INTO Customer (CustomerName, Street, City, State, Zip, Balance, CreditLimit, RepNum)
VALUES('Kline''s','838 Ridgeland','Fillmore','FL','33336',12762.00,15000.00,@KaiserNum);
Declare @KlinesNum int
select @KlinesNum = @@Identity

INSERT INTO Customer (CustomerName, Street, City, State, Zip, Balance, CreditLimit, RepNum)
VALUES('Johnson''s Department Store','372 Oxford','Sheldon','FL','33553',2106.00,10000.00,@PerezNum);
Declare @JohnsonNum int
select @JohnsonNum = @@Identity

INSERT INTO Customer (CustomerName, Street, City, State, Zip, Balance, CreditLimit, RepNum)
VALUES('Lee''s Sport and Appliance','282 Evergreen','Altonville','FL','32543',2851.00,5000.00,@HullNum);
Declare @LeesNum int
select @LeesNum = @@Identity

INSERT INTO Customer (CustomerName, Street, City, State, Zip, Balance, CreditLimit, RepNum)
VALUES('Deerfield''s Four Seasons','282 Columbia','Sheldon','FL','33553',248.00,7500.00,@HullNum);
Declare @DeerfieldsNum int
select @DeerfieldsNum = @@Identity

INSERT INTO Customer (CustomerName, Street, City, State, Zip, Balance, CreditLimit, RepNum)
VALUES('All Season','28 Lakeview','Grove','FL','33321',8221.00,7500.00,@KaiserNum);
Declare @AllSeasonNum int
select @AllSeasonNum = @@Identity


INSERT INTO ORDERS (OrderDate, CustomerNum, Billed)
VALUES('20-OCT-2003',@AlApplNum, 1);
Declare @O1Num int
select @O1Num = @@Identity

INSERT INTO ORDERS (OrderDate, CustomerNum, Billed)
VALUES('20-OCT-2003',@FergusonNum, 1);
Declare @O2Num int
select @O2Num = @@Identity

INSERT INTO ORDERS (OrderDate, CustomerNum, Billed)
VALUES('21-OCT-2003',@EverythingNum, 0);
Declare @O3Num int
select @O3Num = @@Identity

INSERT INTO ORDERS (OrderDate, CustomerNum, Billed)
VALUES('21-OCT-2003',@BrookingsNum, 1);
Declare @O4Num int
select @O4Num = @@Identity

INSERT INTO ORDERS (OrderDate, CustomerNum, Billed)
VALUES('23-OCT-2003',@JohnsonNum, 0);
Declare @O5Num int
select @O5Num = @@Identity

INSERT INTO ORDERS (OrderDate, CustomerNum, Billed)
VALUES('23-OCT-2003',@AlApplNum, 0);
Declare @O6Num int
select @O6Num = @@Identity

INSERT INTO ORDERS (OrderDate, CustomerNum, Billed)
VALUES('23-OCT-2003',@JohnsonNum, 0);
Declare @O7Num int
select @O7Num = @@Identity



INSERT INTO PART (Description, OnHand, Class, Warehouse, Price)
VALUES('Iron',50,'HW','3',24.95);
Declare @P1Num int
select @P1Num = @@Identity
INSERT INTO PART
VALUES('Home Gym',45,'SG','2',794.95);
Declare @P2Num int
select @P2Num = @@Identity
INSERT INTO PART
VALUES('Microwave Oven',32,'AP','1',165.00);
Declare @P3Num int
select @P3Num = @@Identity
INSERT INTO PART
VALUES('Cordless Drill',21,'HW','3',129.95);
Declare @P4Num int
select @P4Num = @@Identity
INSERT INTO PART
VALUES('Gas Range',8,'AP','2',495.00);
Declare @P5Num int
select @P5Num = @@Identity
INSERT INTO PART
VALUES('Washer',12,'AP','3',399.99);
Declare @P6Num int
select @P6Num = @@Identity
INSERT INTO PART
VALUES('Stand Mixer',22,'HW','3',159.95);
Declare @P7Num int
select @P7Num = @@Identity
INSERT INTO PART
VALUES('Dryer',12,'AP','1',349.95);
Declare @P8Num int
select @P8Num = @@Identity
INSERT INTO PART
VALUES('Dishwasher',8,'AP','3',595.00);
Declare @P9Num int
select @P9Num = @@Identity
INSERT INTO PART
VALUES('Treadmill',9,'SG','2',1390.00);
Declare @P10Num int
select @P10Num = @@Identity


INSERT INTO OrderLine
VALUES(@O1Num,@P1Num,13,10,21.95);
INSERT INTO OrderLine
VALUES(@O2Num,@P5Num,2,2,495.00);
INSERT INTO OrderLine
VALUES(@O2Num,@P6Num,2,2,399.99);
INSERT INTO OrderLine
VALUES(@O3Num,@P8Num,4,4,329.95);
INSERT INTO OrderLine
VALUES(@O4Num,@P9Num,2,2,595.00);
INSERT INTO OrderLine
VALUES(@O5Num,@P2Num,2,1,794.95);
INSERT INTO OrderLine
VALUES(@O5Num,@P3Num,4,3,150.00);
INSERT INTO OrderLine
VALUES(@O6Num,@P5Num,1,1,495.00);
INSERT INTO OrderLine
VALUES(@O7Num,@P5Num,1,1,495.00);
INSERT INTO OrderLine
VALUES(@O7Num,@P10Num,2,1,1290.00);

go

--	GetAllOrderNums-return the set of order nums from the db 
Create procedure GetAllOrderNums
as 
Select ordernum
from orders
go

create procedure GetNumItemsPerOrder
as
select OrderNum, COUNT(*)as NumOrderLines, SUM(NumOrdered)as TotalParts
from OrderLine
group by OrderNum
go

create procedure GetOrderInfo
as
select * 
from Orders, Customer
where Orders.CustomerNum = Customer.CustomerNum and
OrderNum = 10001

go

--	AddOrder-insert a new order into db and return the id assigned by the dbms

create procedure AddOrder
(@DateOrdered datetime,
@custormerNUm int )
as 
insert into Orders(OrderDate, CustomerNum, Billed) 
values (@DateOrdered, @custormerNUm, 0)
go 

--	DeleteOrdersWithNoItems – remove orders without any items.
create procedure DeleteOrder
as
select * 
from Orders
where OrderNum not in (select OrderNum from OrderLine)
go

--	UpdateQtyOrdered-update the quantity ordered for a part on a particular order

create procedure updateQtyOrdered
(@OrderNumber as int, @partNumber as int, @newQuantity as int)
as 
update OrderLine
set NumOrdered = @newQuantity
where OrderNum = @OrderNumber and PartNum = @partNumber 
go

--	StoreCustomer-support “Save Customer” functionality by adding/updating customer info

Create Procedure StoreCustomer
(@CustomerNum int output,
@CustomerName varchar(35),
@Street varchar (15),
@City varchar(15),
@State varchar(2),
@Zip varchar(5)
)
as
If(Exists(select *
		from customer
		where customernum = @customernum))
begin
   
    Update Customer
	Set CustomerName = @CustomerName,
		Street = @Street,
		City = @City,
		State = @State,
		Zip = @Zip
     Where CustomerNum = @CustomerNum
end
else
begin
    INSERT INTO Customer(CustomerName, Street, City, State, Zip)
           VALUES (@CustomerName, @Street, @City, @State, @Zip)
    SET @CustomerNum = @@Identity
end
go

--	GetParts-retrieve all part information from the database

create procedure GetParts
as 
select * from Part 
go

--	GetPartNums-retrieve all part nums from the database
create procedure GetPartNums
as 
select Description, PartNum
from Part
go

--	GetPart-get all part information for a particular part num
create procedure GetPart
(@partNUm int)
as
select * 
from Part 
where PartNum = @partNUm
go 

--	ReceiveParts-update the db to reflect receipt of inventory (only update the db if the part is found)

create procedure ReceiveParts
(@partNum int, @received int)
as
if (exists(select * 
			from Part	
				where PartNum = @partNum))
	begin 
		update Part 
			set OnHand = OnHand + @received
				where PartNum = @partNum
				end 

go 

--	StorePart-support “Save Part” functionality by add a part and return the id assigned by the dbms if the part isn't in the dbms 
--		 Otherwise, update the part information

create procedure StorePart
(@partNum int,
@desc varchar(35),
@received int,
@class char(2),
@warehouse int, 
@price money)
as
if(exists(select * from Part where PartNum = @partNum))
	begin 
		update Part 
			set Description = @desc
			where partNum = @partNum 
	end 
Else 
	begin 
		Insert into Part ( Description, OnHand, Class, Warehouse, Price)
			values ( @desc, @received, @class, @warehouse, @price)
			set @partNum = @@IDENTITY
				end
 go

--	PartOrderCount-retrieve the number of times a particular part has been ordered.

create procedure PartOrderCount
@partNum int 
as
select COUNT(PartNum)
from OrderLine
where PartNum = @partNum
go

--	PartOrderCountAll-retrieve a list of all parts that have been ordered,
-- along with the number of times that they have been ordered.  
--Hint: use an outer join to make sure that you get the ones that have not been ordered.

create procedure PartOrderCountAll
as
select Part.PartNum, COUNT(Orderline.PartNum)
from OrderLine
Right join Part
on 
OrderLine.PartNum = Part.PartNum 
group by Part.PartNum
go

--	PartsOrderedByCustomer-retrieve a list of all the parts ordered by a particular customer—show the descriptions 
--for a particular customer num.
create procedure PartsOrderedByCustomer
@cusNum as int
as
select Orders.OrderNum,  PartNum, QuotedPrice, NumOrdered, NumShipped
from  Orders, OrderLine
where Orders.OrderNum = OrderLine.OrderNum and
CustomerNum = @cusNum
go




