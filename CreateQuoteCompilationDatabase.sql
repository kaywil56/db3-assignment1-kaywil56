DROP TABLE IF EXISTS QuoteComponent;
DROP TABLE IF EXISTS Quote;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS AssemblySubcomponent;
DROP TABLE IF EXISTS Component;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Contact;
DROP TABLE IF EXISTS Category;

create table Category(
	CategoryID int identity(1,1) primary key not null,
	CategoryName nvarchar(100) not null
)

create table Contact(
	ContactID int identity(1,1) primary key not null,
	ContactName nvarchar(100) not null,
	ContactPhone varchar(50) not null,
	ContactFax varchar(50),
	ContactMobilePhone varchar(50),
	ContactEmail nvarchar(50),
	ContactWWW nvarchar(100),
	ContactPostalAddress nvarchar(100) not null
)

create table Supplier(
	SupplierID int primary key not null,
	SupplierGST decimal(18, 4) not null default 0,
	constraint FK_Supplier_Contact foreign key (SupplierID) references Contact(ContactID) on update no action on delete no action,
)

create table Component(
	ComponentID int identity(30924, 1) primary key not null,
	ComponentName nvarchar(100) not null,
	ComponentDescription nvarchar(100) not null,
	TradePrice int not null check (TradePrice >= 0),
	TimeToFit decimal(18, 4) not null check (TimeToFit >= 0),
	ListPrice decimal(18, 4) not null check (ListPrice >= 0), 
	CategoryID int not null,
	SupplierID int not null,
	constraint FK_Component_Category foreign key (CategoryID) references Category(CategoryID) on update no action on delete no action,
	constraint FK_Component_Supplier foreign key (SupplierID) references Supplier(SupplierID) on update no action on delete no action
)

create table AssemblySubcomponent(
	AssemblyID int not null,
	SubcomponentID int not null,
	primary key (AssemblyID, SubcomponentID),
	constraint FK_Assembly_Component foreign key (AssemblyID) references Component(ComponentID) on delete no action,
	constraint FK_Subcomponent_Component foreign key (SubcomponentID) references Component(ComponentID) on delete no action,
	Quantity int not null
)

create table Customer(
	CustomerID int primary key not null,
	constraint FK_Customer_Contact foreign key (CustomerID) references Contact(ContactID) on update cascade on delete cascade
)

create table Quote(
	QuoteID int identity(1, 1) primary key,
	QuoteDescription nvarchar(100) not null,
	QuoteDate date not null,
	QuotePrice decimal(18, 4) default 0 check (QuotePrice >= 0),
	QuoteCompiler nvarchar(100) not null,
	CustomerID int not null,
	constraint FK_Quote_Customer foreign key (CustomerID) references Customer(CustomerID) on update cascade on delete no action,
)

create table QuoteComponent(
	Quantity int not null,
	TradePrice decimal(18, 4) not null check (TradePrice >= 0),
	ListPrice decimal(18, 4) not null check (ListPrice >= 0),
	TimeToFit decimal(18, 4) not null  check (TimeToFit >= 0),
	ComponentID int not null,
	QuoteID int not null,
	primary key (ComponentID, QuoteID),
	constraint FK_QuoteComponent_Component foreign key (ComponentID) references Component(ComponentID) on delete no action,
	constraint FK_QuoteComponent_Quote foreign key (QuoteID) references Quote(QuoteID) on update cascade on delete cascade,
)