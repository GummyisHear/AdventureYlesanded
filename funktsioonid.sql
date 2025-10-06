use AdventureWorksDW2019;

--funktsioonid

select * from DimEmployee

--Tabelisiseväärtusega funktsioon e Inline Table Valued function (ILTVF) koodinäide:
create function GetEmployees()
returns table
as
return
(select EmployeeKey, concat(FirstName, ' ', LastName) as Name, cast(BirthDate as Date) as DOB from DimEmployee)
--käivita funktsiooni
select * from GetEmployees()

--Mitme avaldisega tabeliväärtusega funktsioonid e multi-statement table valued function (MSTVF):
create function GetEmployees2()
returns @table table (Id int, Name nvarchar(40), DOB Date)
as begin
insert into @table
select EmployeeKey, concat(FirstName, ' ', LastName), cast(BirthDate as Date) 
from DimEmployee
return
end
--käivita funktsiooni 2
select * from GetEmployees2()

select * from GetEmployees()
update GetEmployees() set Name='Sam1' where EmployeeKey=1;


-------------------------------------------------------------------------------
-- ülesanne 33
select * from DimEmployee;

-- Skaleeritav funktsioon ilma krüpteerimata
create function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
as begin
return (select concat(FirstName, ' ', LastName) from DimEmployee Where EmployeeKey=@Id)
end
--käivitame funktsiooni
select EmployeeKey, dbo.fn_GetEmployeeNameById(EmployeeKey) as Name 
from DimEmployee;
--Näitab funktsiooni kood
sp_helptext 'fn_GetEmployeeNameById';

--Nüüd muudame funktsiooni ja krüpteerime selle ära:
alter function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with encryption
as begin
return (select concat(FirstName, ' ', LastName) from DimEmployee Where EmployeeKey=@Id)
end
-- käivitame funktsiooni
select EmployeeKey, dbo.fn_GetEmployeeNameById(EmployeeKey) as Name 
from DimEmployee;
--Näitab: The text for object 'fn_GetEmployeeNameById' is encrypted.
sp_helptext 'fn_GetEmployeeNameById';

--Nüüd muuda funktsiooni ja kasuta käsklust WITH SCHEMABINDING valikut.
alter function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with SchemaBinding
as begin
return (select concat(FirstName, ' ', LastName) from dbo.DimEmployee Where EmployeeKey=@Id)
end
-- Could not drop object 'DimEmployee' because it is referenced by a FOREIGN KEY constraint.
drop table DimEmployee;
-- Schemabinding täpsustab, et funktsioon on seotud andmebaasi objektiga. 
-- Selle kasutamisel ei saa baasobjekti muuta




