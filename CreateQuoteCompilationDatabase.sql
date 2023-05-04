drop table if exists Supplier
drop table if exists Category
drop table if exists Component
drop table if exists Contact
drop table if exists Customer
drop table if exists Quote
drop table if exists QuoteComponent

create table Supplier(
	SupplierID int primary key not null,
	SupplierGST decimal not null
)

create table Category(
	CategoryID int primary key not null,
	CategoryName nvarchar(100) not null
)

create table Component(
	ComponentID int primary key not null,
	ComponentName nvarchar(100) not null,
	ComponentDescription nvarchar(100) not null,
	TradePrice int not null,
	TimeToFit decimal not null, 
	CategoryID int not null,
	SupplierID int not null,
	constraint fk_category foreign key (CategoryID) references Category(CategoryID),
	constraint fk_supplier foreign key (SupplierID) references Supplier(SupplierID)
)

create table Contact(
	ContactName nvarchar(100) not null,
	ContactPhone bigint not null,
	ContactFax bigint,
	ContactMobilePhone bigint,
	ContactEmail nvarchar(50),
	ContactWWW nvarchar(100),
	ContactPostalAddress nvarchar(100) not null
)

--create table AssemblySubcomponent(
--	AssemblyID int primary key not null, 
--	SubcomponentID int primary key not null,
--	Quantity int
--)

create table Customer(
	CustomerID int primary key not null
)

create table Quote(
	QuoteID int primary key not null,
	QuoteDescription nvarchar(100) not null,
	QuoteDate date not null,
	QuotePrice decimal not null,
	--QuoteCompiler???,
	constraint fk_customer foreign key (CustomerID) references Customer(CustomerID)
)

create table QuoteComponent(
	Quantity int not null,
	TradePrice decimal not null,
	ListPrice decimal not null,
	TimeToFit decimal not null,
	constraint fk_component foreign key (ComponentID) references Component(ComponentID),
	constraint fk_quote foreign key (QuoteID) references Quote(QuoteID)
)