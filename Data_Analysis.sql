
/***************************combine the first name and last name to single column in customer table********************/

Select Id,Concat(First_Name,' ',Last_Name) As Name,emailId,Joining_Date from Customers;

/*************************Correct the email Id which are incorrect*************************/

--Fetch records missing .com in the email Id
Select Id,emailId from Customers where emailId not like '%.com%';

--Update the incorrect email Id by adding .com to it
Update Customers set emailId = Concat(emailId,'.com');

/***********************Correct the Phone Number which are incorrect*********************/

--Fetch the record that containing special characters(!@#$%&*.) in Phone Number.
select Id,Phone_Number from Customers where Phone_Number like '%[A-Za-z#!@$%&*.]%';

--Update the Phone Number by removing the special characters. Used Stuff() to remove the special character from column. Used PatIndex() to get position of special character
Update Customers Set Phone_Number = Stuff(Phone_Number,PatIndex('%[A-Za-z#!@$%&*.]%',Phone_Number),1,'') where Phone_Number like '%[A-Za-z#!@$%&*.]%';

/***********************Correct the length of Phone Number***************************************/

--Fetch records having length Phone Number not equal to 10
Select Id,Phone_Number from Customers where len(Phone_Number) <> 10;

--Used Case statement to check for length of Phone_Numbers which are greater than 10 and which are less than 10 and update accordingly. If 
--length of Phone_Number is less than 10
Update Customers set Phone_Number = Case When len(Phone_Number) > 10 Then SUBSTRING(Phone_Number,1,10)
When len(Phone_Number) < 10 Then '0000000000' Else Phone_Number END;

/***************************List all the Products Details along with their stores***********************/

--Using Sub Query
Select * from Products where S_Id in(Select Id from Stores);

--Using Join
Select P.Id,P_Name,S.Id from Products P 
Inner Join Stores S On P.S_Id = S.Id;

/***************************List out the Product Details for Store Bengaluru where Actual Price greater than or equal to 3000 for Product 'Headphone'**********/

Select P.Id,P.P_Name,S.Id,S.Store_Name from Products P
Inner Join Stores S On P.S_Id=S.Id where S.Store_Name ='Bengaluru' and P.Actual_Price >=3000 and P.P_Name='Headphone'; 

/************************List down only those customers who have ordered 'Speaker' or 'LED' or 'Watch'*******************/

Select C.Id AS CustomerId,Concat(C.First_Name,' ',C.Last_Name) AS FullName,
P.Id AS ProductId,P.P_Name from Customers C
Inner Join Orders O on C.Id = O.C_Id
Inner Join Products P on P.Id = O.P_Id
where P.P_Name in ('Speaker','LED','Watch');

/***********************List down the Customers who ordered the costliest product******************************************/

Select C.Id,Concat(C.First_Name,' ',C.Last_Name) AS Name,C.emailId,C.Phone_Number from Customers C
inner join Orders O on C.Id = O.C_Id
inner join Products P on O.P_Id = P.Id 
where P.Actual_Price in(Select Max(Actual_Price) from Products)
Order by O.Order_On;

/*******************Find the maximum price of a product*********************/

Select MAX(Actual_Price) AS Maximum_Price from Products;

/********************Find the minimum cost product******************************/

Select Min(Actual_Price) from Products;

/***********************List down the Customers who ordered the cheapest product******************************************/

Select C.Id,Concat(C.First_Name,' ',C.Last_Name)As Name,C.emailId,C.Phone_Number from Customers C
inner Join Orders O on C.Id=O.C_Id
inner join Products P on P.Id = O.P_Id
where P.Actual_Price in(Select Min(Actual_Price) from Products);