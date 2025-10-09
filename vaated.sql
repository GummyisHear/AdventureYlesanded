
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