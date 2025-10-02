--funktsioonid

select * from DimEmployee

--Tabelisisev‰‰rtusega funktsioon e Inline Table Valued function (ILTVF) koodin‰ide:
create function GetEmployees()
returns table
as
return
(select EmployeeKey, concat(FirstName, ' ', LastName) as Name, cast(BirthDate as Date) as DOB from DimEmployee)
--k‰ivita funktsiooni
select * from GetEmployees()

--Mitme avaldisega tabeliv‰‰rtusega funktsioonid e multi-statement table valued function (MSTVF):
create function GetEmployees2()
returns @table table (Id int, Name nvarchar(40), DOB Date)
as begin
insert into @table
select EmployeeKey, concat(FirstName, ' ', LastName), cast(BirthDate as Date) 
from DimEmployee
return
end
--k‰ivita funktsiooni 2
select * from GetEmployees2()




