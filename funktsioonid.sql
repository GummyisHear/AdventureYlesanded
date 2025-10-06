use AdventureWorksDW2019;

--funktsioonid

select * from DimEmployee

--Tabelisisev��rtusega funktsioon e Inline Table Valued function (ILTVF) koodin�ide:
create function GetEmployees()
returns table
as
return
(select EmployeeKey, concat(FirstName, ' ', LastName) as Name, cast(BirthDate as Date) as DOB from DimEmployee)
--k�ivita funktsiooni
select * from GetEmployees()

--Mitme avaldisega tabeliv��rtusega funktsioonid e multi-statement table valued function (MSTVF):
create function GetEmployees2()
returns @table table (Id int, Name nvarchar(40), DOB Date)
as begin
insert into @table
select EmployeeKey, concat(FirstName, ' ', LastName), cast(BirthDate as Date) 
from DimEmployee
return
end
--k�ivita funktsiooni 2
select * from GetEmployees2()

select * from GetEmployees()
update GetEmployees() set Name='Sam1' where EmployeeKey=1;


-------------------------------------------------------------------------------
-- �lesanne 33
select * from DimEmployee;

-- Skaleeritav funktsioon ilma kr�pteerimata
create function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
as begin
return (select concat(FirstName, ' ', LastName) from DimEmployee Where EmployeeKey=@Id)
end
--k�ivitame funktsiooni
select EmployeeKey, dbo.fn_GetEmployeeNameById(EmployeeKey) as Name 
from DimEmployee;
--N�itab funktsiooni kood
sp_helptext 'fn_GetEmployeeNameById';

--N��d muudame funktsiooni ja kr�pteerime selle �ra:
alter function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with encryption
as begin
return (select concat(FirstName, ' ', LastName) from DimEmployee Where EmployeeKey=@Id)
end
-- k�ivitame funktsiooni
select EmployeeKey, dbo.fn_GetEmployeeNameById(EmployeeKey) as Name 
from DimEmployee;
--N�itab: The text for object 'fn_GetEmployeeNameById' is encrypted.
sp_helptext 'fn_GetEmployeeNameById';

--N��d muuda funktsiooni ja kasuta k�sklust WITH SCHEMABINDING valikut.
alter function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with SchemaBinding
as begin
return (select concat(FirstName, ' ', LastName) from dbo.DimEmployee Where EmployeeKey=@Id)
end
-- Could not drop object 'DimEmployee' because it is referenced by a FOREIGN KEY constraint.
drop table DimEmployee;
-- Schemabinding t�psustab, et funktsioon on seotud andmebaasi objektiga. 
-- Selle kasutamisel ei saa baasobjekti muuta

---------------------------------------------------------------------------------
-- 34. Ajutised Tabelid

-- loome ajutise tabel ja lisame andmed
create table #PersonDetails(Id int primary key identity(1,1),
Name nvarchar(20))
insert into #PersonDetails values ('Mike')
insert into #PersonDetails values ('John')
insert into #PersonDetails values ('Todd')
-- vaatame sisu tabelil
select * from #PersonDetails;
-- otsime loodud tabel tempdb alla, kasutuseks sysobjects
select name from tempdb..sysobjects
where name like '#PersonDetails%';
-- v�ib kustutada seda �ra ise, v�i seda automaatselt kustutakse kui db �hendus l�ppeb
drop table #PersonDetails;

--loome protseduur kus loome uus ajutine tabel, ja see tabel kustutakse kui protseduur l�ppeb
create procedure spCreateLocalTempTable
as begin
create table #PersonDetails(Id int primary key identity(1,1),
Name nvarchar(20))
insert into #PersonDetails values ('Mike')
insert into #PersonDetails values ('John')
insert into #PersonDetails values ('Todd')

select * from #PersonDetails
end
--kutsume protseduur
exec spCreateLocalTempTable
--otsime tabel, peab tagastada t�hi name, sest tabel on kustutatud
select name from tempdb..sysobjects
where name like '#PersonDetails%';
