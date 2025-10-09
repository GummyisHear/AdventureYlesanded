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

--Except operaatorit saab kasutada ka �he tabeli peal
--Order by n�uet v�ib kasutada ainult kord peale paremat p�ringut:
select Id, Name, Gender, Salary
from tblEmployees
where Salary >= 50000
except
select Id, Name, Gender, Salary
from tblEmployees
where salary >= 60000
order by Name;


----------------------------------------------------------------------
--88. Erinevus Except ja not in operaatoril

--J�rgnev p�ring tagastab read vasakust p�ringust, mis ei ole paremas tabelis
select Id, Name, Gender from TableA
except
select Id, Name, Gender from TableB

--Sama tulemuse v�ib saavutada NOT IN operaatoriga:
select Id, Name, Gender from TableA
where Id not in (select Id from TableB)

--Mis erinevus on neil kahel operaatoril.
--Except filtreerib korduvaid andmeid ja tagastab ainult erinevaid ridu vasakust p�ringust, mis ei ole parema rea p�ringu tulemuses. 
--NOT IN ei filtreeri duplikaate.

--lisame duplikaat tabelile A
insert into TableA values (1, 'Mark', 'Male');

--n��d k�ivitame sama p�ring
select Id, Name, Gender from TableA
except
select Id, Name, Gender from TableB

--n��d k�ivita NOT IN opetaatoriga, n�itab duplikaati
select Id, Name, Gender from TableA
where Id not in (select Id from TableB)

--EXCEPT operaator  ootab sama arvu veerge m�lemas p�ringus ja NOT IN ei oota seda.
--NOT IN v�rdleb �ksikut veergu v�lisest p�ringust koos �ksiku veeruga alamp�ringust.

--J�rgnevas p�ringus on meelega veergude arv erinev
select Id, Name, Gender from TableA
except
select Id, Name from TableB
--veateate

--J�rgnevas p�ringus alamp�ring tagastab mitu veergu:
select Id, Name, Gender from TableA
where Id not in (select Id, Name from TableB)




















