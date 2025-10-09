
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