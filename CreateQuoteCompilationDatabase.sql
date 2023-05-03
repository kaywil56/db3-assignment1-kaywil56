drop schema if exists quote_compilation
create schema quote_compilation
use quote_compilation

create table Category(
	CategoryID int primary key not null,
	CategoryName nvarchar(100) not null
)

create table Supplier(
	SupplierID
)

create table Component(
	ComponentID int primary key not null,
	ComponentName nvarchar(100) not null,
	ComponentDescription nvarchar(100) not null,
	TradePrice int not null,
	TimeToFit decimal not null, 
	constraint fk_category foreign key (CategoryID) references Category(CategoryID)
	constraint fk_supplier foreign key (SupplierID) references Supplier(SuplierID)
)
