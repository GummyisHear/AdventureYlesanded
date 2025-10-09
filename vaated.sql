
--päring join kasutusega, SalesTerritoryRegion võtame DimSalesTerritory tabelist
select EmployeeKey, FirstName, BaseRate, Gender, SalesTerritoryRegion
from DimEmployee e
join DimSalesTerritory s
on e.SalesTerritoryKey = s.SalesTerritoryKey;

--loome vaade selle päringule
create view EmployeesByTerritory
as
select EmployeeKey, FirstName, BaseRate, Gender, SalesTerritoryRegion
from DimEmployee e
join DimSalesTerritory s
on e.SalesTerritoryKey = s.SalesTerritoryKey;

--käivitame seda vaade
select * FROM EmployeesByTerritory;

-- view mis ainult tagastab töötajad Southwest territory's
create view SouthwestEmployees
as
select EmployeeKey, FirstName, BaseRate, Gender, SalesTerritoryRegion
from DimEmployee e
join DimSalesTerritory s
on e.SalesTerritoryKey = s.SalesTerritoryKey
where s.SalesTerritoryRegion = 'Southwest';
--käivitame SouthwestEmployees vaade
select * from SouthwestEmployees;

-- view mis ei näita palganumbrit
create view EmployeesByTerritoryNonConfidentialData
as
select EmployeeKey, FirstName, Gender, SalesTerritoryRegion
from DimEmployee e
join DimSalesTerritory s
on e.SalesTerritoryKey = s.SalesTerritoryKey;

--view mis tagastab summeeritud andmed töötajate koondarvest
create view EmployeesCountByTerritory
as
select SalesTerritoryRegion, count(e.EmployeeKey) as TotalEmployees
from DimEmployee e
join DimSalesTerritory s
on e.SalesTerritoryKey = s.SalesTerritoryKey
group by s.SalesTerritoryRegion;
--käivitame
select * from EmployeesCountByTerritory;

--alter view, drop view

----------------------------------------------------------------------
-- 40. View uuendused

--view tagastab peaaegu kõik veerud, aga va BaseRate veerg.
create view EmployeesDataExceptSalary
as
select EmployeeKey, FirstName, Gender, SalesTerritoryKey
from DimEmployee
--käivitame
select * from EmployeesDataExceptSalary;

--Järgnev päring uuendab FirstName veerus olevat nime Guy Mikey peale
update EmployeesDataExceptSalary
set FirstName = 'Mikey' where EmployeeKey = 1;

--Samas on võimalik sisestada ja kustutada ridu baastabelis ning kasutada view-d.
delete from EmployeesDataExceptSalary where EmployeeKey = 1;
insert into EmployeesDataExceptSalary values ('FirstName', 'M', 11);

--Loome view, mis ühendab kaks eelpool käsitletud tabelit:
create view EmployeeDetailsByTerritory
as
select EmployeeKey, FirstName, BaseRate, Gender, SalesTerritoryRegion
from DimEmployee e
join DimSalesTerritory s
on e.SalesTerritoryKey = s.SalesTerritoryKey;

select * from EmployeeDetailsByTerritory;

--Nüüd uuendame John osakonda HR pealt IT peale. Hetkel on kaks töötajat HR osakonnas
update EmployeeDetailsByTerritory
set SalesTerritoryRegion='Southwest' where FirstName = 'Kevin'

--update käsklus ei uuendanud tblEmployees väärtust, vaid tblDepartmenti all






