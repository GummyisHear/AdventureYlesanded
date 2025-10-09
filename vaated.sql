
--p�ring join kasutusega, SalesTerritoryRegion v�tame DimSalesTerritory tabelist
select EmployeeKey, FirstName, BaseRate, Gender, SalesTerritoryRegion
from DimEmployee e
join DimSalesTerritory s
on e.SalesTerritoryKey = s.SalesTerritoryKey;

--loome vaade selle p�ringule
create view EmployeesByTerritory
as
select EmployeeKey, FirstName, BaseRate, Gender, SalesTerritoryRegion
from DimEmployee e
join DimSalesTerritory s
on e.SalesTerritoryKey = s.SalesTerritoryKey;

--k�ivitame seda vaade
select * FROM EmployeesByTerritory;

-- view mis ainult tagastab t��tajad Southwest territory's
create view SouthwestEmployees
as
select EmployeeKey, FirstName, BaseRate, Gender, SalesTerritoryRegion
from DimEmployee e
join DimSalesTerritory s
on e.SalesTerritoryKey = s.SalesTerritoryKey
where s.SalesTerritoryRegion = 'Southwest';
--k�ivitame SouthwestEmployees vaade
select * from SouthwestEmployees;

-- view mis ei n�ita palganumbrit
create view EmployeesByTerritoryNonConfidentialData
as
select EmployeeKey, FirstName, Gender, SalesTerritoryRegion
from DimEmployee e
join DimSalesTerritory s
on e.SalesTerritoryKey = s.SalesTerritoryKey;

--view mis tagastab summeeritud andmed t��tajate koondarvest
create view EmployeesCountByTerritory
as
select SalesTerritoryRegion, count(e.EmployeeKey) as TotalEmployees
from DimEmployee e
join DimSalesTerritory s
on e.SalesTerritoryKey = s.SalesTerritoryKey
group by s.SalesTerritoryRegion;
--k�ivitame
select * from EmployeesCountByTerritory;

--alter view, drop view

----------------------------------------------------------------------
-- 40. View uuendused

--view tagastab peaaegu k�ik veerud, aga va BaseRate veerg.
create view EmployeesDataExceptSalary
as
select EmployeeKey, FirstName, Gender, SalesTerritoryKey
from DimEmployee
--k�ivitame
select * from EmployeesDataExceptSalary;

--J�rgnev p�ring uuendab FirstName veerus olevat nime Guy Mikey peale
update EmployeesDataExceptSalary
set FirstName = 'Mikey' where EmployeeKey = 1;

--Samas on v�imalik sisestada ja kustutada ridu baastabelis ning kasutada view-d.
delete from EmployeesDataExceptSalary where EmployeeKey = 1;
insert into EmployeesDataExceptSalary values ('FirstName', 'M', 11);

--Loome view, mis �hendab kaks eelpool k�sitletud tabelit:
create view EmployeeDetailsByTerritory
as
select EmployeeKey, FirstName, BaseRate, Gender, SalesTerritoryRegion
from DimEmployee e
join DimSalesTerritory s
on e.SalesTerritoryKey = s.SalesTerritoryKey;

select * from EmployeeDetailsByTerritory;

--N��d uuendame John osakonda HR pealt IT peale. Hetkel on kaks t��tajat HR osakonnas
update EmployeeDetailsByTerritory
set SalesTerritoryRegion='Southwest' where FirstName = 'Kevin'

--update k�sklus ei uuendanud tblEmployees v��rtust, vaid tblDepartmenti all






