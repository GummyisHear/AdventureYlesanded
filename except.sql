--loome tabelid and lisame andmed
Create Table TableA
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10)
)

Insert into TableA values (1, 'Mark', 'Male')
Insert into TableA values (2, 'Mary', 'Female')
Insert into TableA values (3, 'Steve', 'Male')
Insert into TableA values (4, 'John', 'Male')
Insert into TableA values (5, 'Sara', 'Female')
Go

Create Table TableB
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10)
)
Go

Insert into TableB values (4, 'John', 'Male')
Insert into TableB values (5, 'Sara', 'Female')
Insert into TableB values (6, 'Pam', 'Female')
Insert into TableB values (7, 'Rebeka', 'Female')
Insert into TableB values (8, 'Jordan', 'Male')
Go

--tagastab unikaalse ridade arvu vasakust tabelist, mida ei ole paremas tabelis.
Select Id, Name, Gender
From TableA
Except
Select Id, Name, Gender
From TableB

--loome uus tabel ja lisame andmed
Create table tblEmployees
(
Id int identity primary key,
Name nvarchar(100), Gender nvarchar(10),
Salary int
)
Go

Insert into tblEmployees values ('Mark', 'Male', 52000)
Insert into tblEmployees values ('Mary', 'Female', 55000)
Insert into tblEmployees values ('Steve', 'Male', 45000)
Insert into tblEmployees values ('John', 'Male', 40000)
Insert into tblEmployees values ('Sara', 'Female', 48000)
Insert into tblEmployees values ('Pam', 'Female', 60000)
Insert into tblEmployees values ('Tom', 'Male', 58000)
Insert into tblEmployees values ('George', 'Male', 65000)
Insert into tblEmployees values ('Tina', 'Female', 67000)
Insert into tblEmployees values ('Ben', 'Male', 80000)
Go

--Except operaatorit saab kasutada ka ühe tabeli peal
--Order by nõuet võib kasutada ainult kord peale paremat päringut:
select Id, Name, Gender, Salary
from tblEmployees
where Salary >= 50000
except
select Id, Name, Gender, Salary
from tblEmployees
where salary >= 60000
order by Name;