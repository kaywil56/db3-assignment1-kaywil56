/*  START  */

/*
Create data on QuoteCompilation database to support
ID705 Databases 3 assignment.

****************************WARNING******************************************************
Object names used in this script require that
you must have implemented the database as specified on the assignment ERD


*/

--support functions, views and sp
--create function dbo.getCategoryID
--create function dbo.getAssemblySupplierID()
--create proc addSubComponent
-- Using variables : @ABC int, @XYZ int, @CDBD int, @BITManf int- capture the ContactID

drop proc if exists createAssembly
drop proc if exists addSubComponent
drop function if exists dbo.getCategoryID
drop function if exists dbo.getAssemblySupplierID

ALTER TABLE Component NOCHECK CONSTRAINT FK_Component_Supplier;

go
create function getCategoryID(@categoryName nvarchar(100))
returns int
as
begin
	return(select CategoryID from Category where CategoryName = @categoryName)
end
go

go
create function getAssemblySupplierID()
returns int
as
begin
	return(select ContactID from Contact where ContactName = 'BIT Manufacturing Ltd.')
end
go

go
create proc addSubcomponent(@assemblyName nvarchar(100), @subComponentName nvarchar(100), @quantity int)
as
	declare @assemblyID int
	declare @subcomponentID int

	set @assemblyID = (select ComponentID from Component where ComponentName = @assemblyName)
	set @subcomponentID = (select ComponentID from Component where ComponentName = @subComponentName)

	insert AssemblySubcomponent(AssemblyID, SubcomponentID, Quantity)
	values(@assemblyID, @subcomponentID, @quantity)
go

go
create proc createAssembly(@componentName nvarchar(100), @componentDescription nvarchar(100))
as
begin
	insert Component (ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
	values (@componentName, @componentDescription, dbo.getAssemblySupplierID(), 0, 0, 0, dbo.getCategoryID('Assembly'))
end
go

go
create proc createAssembly(@componentName nvarchar(100), @componentDescription nvarchar(100))
as
begin
	insert Component (ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
	values (@componentName, @componentDescription, dbo.getAssemblySupplierID(), 0, 0, 0, dbo.getCategoryID('Assembly'))
end
go

--create categories
insert Category (CategoryName) values ('Black Steel')
insert Category (CategoryName) values ('Assembly')
insert Category (CategoryName) values ('Fixings')
insert Category (CategoryName) values ('Paint')
insert Category (CategoryName) values ('Labour')


--create contacts
--Using variables : @ABC int, @XYZ int, @CDBD int, @BITManf int- capture the ContactID
-- This will mean you don't have to hard code these later.

declare @ABC int
declare @XYZ int
declare @CDBD int
declare @BITManf int

insert Contact (ContactName, ContactPostalAddress, ContactWWW, ContactEmail, ContactPhone, ContactFax)
values ('ABC Ltd.', '17 George Street, Dunedin', 'www.abc.co.nz', 'info@abc.co.nz', '	471 2345', null)

set @ABC = @@IDENTITY

insert Contact (ContactName, ContactPostalAddress, ContactWWW, ContactEmail, ContactPhone, ContactFax)
values ('XYZ Ltd.', '23 Princes Street, Dunedin', null, 'xyz@paradise.net.nz', '4798765', '4798760')

set @XYZ = @@IDENTITY

insert Contact (ContactName, ContactPostalAddress, ContactWWW, ContactEmail, ContactPhone, ContactFax)
values ('CDBD Pty Ltd.',	'Lot 27, Kangaroo Estate, Bondi, NSW, Australia 2026', '	www.cdbd.com.au', 'support@cdbd.com.au', '+61 (2) 9130 1234', null)

set @CDBD = @@IDENTITY

insert Contact (ContactName, ContactPostalAddress, ContactWWW, ContactEmail, ContactPhone, ContactFax)
values ('BIT Manufacturing Ltd.', 'Forth Street, Dunedin', 'bitmanf.tekotago.ac.nz', 'bitmanf@tekotago.ac.nz', '0800 SMARTMOVE', null)

set @BITManf = @@IDENTITY

-- create components
-- Note this script relies on you having captured the ContactID to insert into SupplierID

set IDENTITY_INSERT component on

insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30901, 'BMS10', '10mm M6 ms bolt', @ABC, 0.20, 0.17, 0.5, dbo.getCategoryID('Fixings'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30902, 'BMS12', '12mm M6 ms bolt', @ABC, 0.25, 0.2125,	0.5, dbo.getCategoryID('Fixings'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30903, 'BMS15', '15mm M6 ms bolt', @ABC, 0.32, 0.2720, 0.5, dbo.getCategoryID('Fixings'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30904, 'NMS10', '10mm M6 ms nut', @ABC, 0.05, 0.04, 0.5, dbo.getCategoryID('Fixings'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30905, 'NMS12', '12mm M6 ms nut', @ABC, 0.052, 0.0416, 0.5, dbo.getCategoryID('Fixings'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30906, 'NMS15', '15mm M6 ms nut', @ABC, 0.052, 0.0416, 0.5, dbo.getCategoryID('Fixings'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30911, 'BMS.3.12', '3mm x 12mm flat ms bar', @XYZ, 1.20, 1.15, 	0.75, dbo.getCategoryID('Black Steel'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30912, 'BMS.5.15', '5mm x 15mm flat ms bar', @XYZ, 2.50, 2.45, 	0.75, dbo.getCategoryID('Black Steel'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30913, 'BMS.10.25', '10mm x 25mm flat ms bar', @XYZ, 8.33, 8.27, 0.75, dbo.getCategoryID('Black Steel'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30914, 'BMS.15.40', '15mm x 40mm flat ms bar', @XYZ, 20.00, 19.85, 0.75, dbo.getCategoryID('Black Steel'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30931, '27', 'Anti-rust paint, silver', @CDBD, 74.58, 63.85, 0, dbo.getCategoryID('Paint'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30932, '43', 'Anti-rust paint, red', @CDBD, 74.58, 63.85, 0, dbo.getCategoryID('Paint'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30933, '154', 'Anti-rust paint, blue', @CDBD, 74.58, 63.85, 0, dbo.getCategoryID('Paint'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30921, 'ARTLAB', 'Artisan labour', @BITManf, 42.00, 42.00, 0	, dbo.getCategoryID('Labour'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30922, 'DESLAB', 'Designer labour', @BITManf, 54.00, 54.00, 0, dbo.getCategoryID('Labour'))
insert Component (ComponentID, ComponentName, ComponentDescription, SupplierID, ListPrice, TradePrice, TimeToFit, CategoryID)
values (30923, 'APPLAB', 'Apprentice labour', @BITManf, 23.50, 23.50, 0, dbo.getCategoryID('Labour'))

set IDENTITY_INSERT component off
alter table Component check constraint FK_Component_Supplier;

exec createAssembly  'SmallCorner.15', '15mm small corner'
exec dbo.addSubComponent 'SmallCorner.15', 'BMS.5.15', 0.120
exec dbo.addSubComponent 'SmallCorner.15', 'APPLAB', 0.33333
exec dbo.addSubComponent 'SmallCorner.15', '43', 0.0833333

exec dbo.createAssembly 'SquareStrap.1000.15', '1000mm x 15mm square strap'
exec dbo.addSubComponent 'SquareStrap.1000.15', 'BMS.5.15', 4
exec dbo.addSubComponent 'SquareStrap.1000.15', 'SmallCorner.15', 4
exec dbo.addSubComponent 'SquareStrap.1000.15', 'APPLAB', 25
exec dbo.addSubComponent 'SquareStrap.1000.15', 'ARTLAB', 10
exec dbo.addSubComponent 'SquareStrap.1000.15', '43', 0.185
exec dbo.addSubComponent 'SquareStrap.1000.15', 'BMS10', 8

exec dbo.createAssembly 'CornerBrace.15', '15mm corner brace'
exec dbo.addSubComponent 'CornerBrace.15', 'BMS.5.15', 0.090
exec dbo.addSubComponent 'CornerBrace.15', 'BMS10', 2

drop proc createAssembly
drop proc addSubComponent
drop function dbo.getCategoryID
drop function dbo.getAssemblySupplierID

go
create proc createCustomer(@name nvarchar(100),
@phone char(50),
@postalAddress nvarchar(100),
@email nvarchar(50) = null,
@www nvarchar(100) = null,
@fax nvarchar(100) = null,
@mobilePhone char(50) = null)
as
	declare @customerID int

	insert Contact(ContactPhone, ContactPostalAddress, ContactEmail, ContactWWW, ContactFax, ContactMobilePhone)
	values(@phone, @postalAddress, @email, @www, @fax, @mobilePhone)

	set @customerID = @@IDENTITY

	return @customerID
go

go
create proc createQuote(
@quoteDescription nvarchar(100),
@quoteDate datetime = null,
@quotePrice decimal(18, 4) = null,
@quoteCompiler nvarchar(100),
@customerID int)
as
begin
	declare @quoteID int

	if @quoteDate is null
		set @quoteDate = GETDATE()

	insert Quote(QuoteDescription, QuoteDate, QuotePrice, QuoteCompiler, CustomerID)
	values(@quoteDescription, @quoteDate, @quotePrice, @quoteCompiler, @customerID)
	
	set @quoteID = @@IDENTITY

	return @quoteID
end
go


go
create proc addQuoteComponent
    @quoteID int,
    @componentID int,
    @quantity int
as
begin
	declare @tradePrice decimal (18, 4);
	declare @listPrice decimal (18, 4);
	declare @timeToFit decimal (18, 4);

	set @tradePrice = (select TradePrice from Component where ComponentID = @componentID)
	set @listPrice = (select ListPrice from Component where ComponentID = @componentID)
	set @timeToFit = (select TimeToFit from Component where ComponentID = @componentID)

	insert QuoteComponent(QuoteID, ComponentID, Quantity, TradePrice, ListPrice, TimeToFit)
	values(@quoteID, @componentID, @quantity, @tradePrice, @listPrice, @timeToFit)
end
go


--create proc createCustomer(@name nvarchar(100),
--@phone char(50),
--@postalAddress nvarchar(100),
--@email nvarchar(50) = null,
--@www nvarchar(100) = null,
--@fax nvarchar(100) = null,
--@mobilePhone char(50) = null)

--create proc createQuote(
--@quoteDescription nvarchar(100),
--@quoteDate datetime = null,
--@quotePrice decimal(18, 4) = null,
--@quoteCompiler nvarchar(100),
--@customerID int)
--as


declare @customerID int
declare @quoteID int

exec @customerID = dbo.createCustomer 'Bimble & Hat', '444 5555', '123 Digit Street, Dunedin', NULL, NULL, 'guy.little@bh.biz.nz', NULL
exec @quoteID = dbo.createQuote 'Craypot frame', NULL, NULL, 'comp', @customerID
--exec dbo.addQuoteComponent @quoteID, 