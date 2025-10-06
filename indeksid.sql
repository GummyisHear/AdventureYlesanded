-----------------------------------------------------------------------------------
-- 35. Indeksid serveris

-- kuvame andmed
select EmployeeKey, FirstName, BaseRate, Gender from DimEmployee;
-- kuvame ainult need töötajad kelle tasu on vahemikus 20 kuni 50
select EmployeeKey, FirstName, BaseRate, Gender from DimEmployee
where BaseRate > 20 and BaseRate < 50;
--Nüüd loome indeksi, mis aitab päringut: Loome indeksi Salary veerule.
create index IX_DimEmployee_BaseRate
on DimEmployee(BASERATE ASC)
-- kuvab kõik indeksid tabelis
Execute sp_helptext DimEmployee
--kustutame indeks
drop index DimEmployee.IX_DimEmployee_BaseRate