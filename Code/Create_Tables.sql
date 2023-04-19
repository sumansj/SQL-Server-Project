--Create Tables
Create Table Customers(
Id int Identity(1,1) Primary Key,
First_Name varchar(20),
Last_Name varchar(20),
emailID varchar(40),
Joining_Date Date
);

Alter Table Customers ADD Phone_Number Varchar(15);


Create Table Stores(
Id int Identity(100,1),
Store_Name varchar(10),
Website varchar(30),
Address varchar(15),
Created_On Date
);

Alter Table dbo.Stores
ADD Constraint U_Name Unique (Store_Name);

Create Table Products(
Id int Identity(1000,1),
P_Name varchar(20),
Is_Available bit,
S_Id int,
Price int,
Is_Discount bit,
Discount_Price int,
Actual_Price int,
Last_Updated Date Not NULL
);

Alter Table Products ADD P_Status Varchar(20);

Alter Table Products
ADD Constraint P_S_Default Default 'Not Submitted' for P_Status;

Alter Table Products
Alter Column P_Status Varchar(20) NOT NULL;

Create Table Orders(
Id int Identity(10000,1),
Order_On DateTime Not NULL,
C_Id int Not Null,
P_Id int Not Null,
S_Id int Not Null,
O_Status bit
);

Alter Table Orders Alter Column O_Status varchar(15);

Create Table Delivery(
Id int Identity(5000,1),
O_Id int Not Null,
S_Id int Not Null,
C_Id int Not Null,
D_Start_On DateTime,
D_End_On DateTime,
D_Status varchar(20) Not Null,
Duration int
);

Alter Table Delivery Drop Column Duration;
Alter Table Delivery Add P_Id int Not Null;
