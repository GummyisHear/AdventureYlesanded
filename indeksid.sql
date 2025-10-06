-----------------------------------------------------------------------------------
-- 35. Indeksid serveris

-- kuvame andmed
select EmployeeKey, FirstName, BaseRate, Gender from DimEmployee;
-- kuvame ainult need t��tajad kelle tasu on vahemikus 20 kuni 50
select EmployeeKey, FirstName, BaseRate, Gender from DimEmployee
where BaseRate > 20 and BaseRate < 50;
--N��d loome indeksi, mis aitab p�ringut: Loome indeksi Salary veerule.
create index IX_DimEmployee_BaseRate
on DimEmployee(BASERATE ASC)
-- kuvab k�ik indeksid tabelis
Execute sp_helpindex DimEmployee
--kustutame indeks
drop index DimEmployee.IX_DimEmployee_BaseRate

----------------------------------------------------------------------------------
-- 36. Klastreeritud ja mitte-klastreeritud indeksid

--loome klastreeritud indeks
create clustered index IX_DimEmployee_Name
on DimEmployee(FirstName)
-- Annab viga:
-- Cannot create more than one clustered index on table 'DimEmployee'. 
-- Drop the existing clustered index 'PK_DimEmployee_EmployeeKey' before creating another.

--kustutame indeks Id veerus
Drop index DimEmployee.PK_DimEmployee_EmployeeKey;
-- Annab viga, sest meil on foreign key 

--kui indeks on kustutatud, siis see t��tab
create clustered index IX_DimEmployee_Gender_Salary
on DimEmployee(Gender DESC, BaseRate ASC);

--loome mitte-klastreeritud indeks
create NonClustered index IX_DimEmployee_FirstName
on DimEmployee(FirstName)

-----------------------------------------------------------------------------------
-- 37. Unikaalne ja mitte-unikaalne indeks

sp_helpindex DimEmployee
-- ei saa need andmed lisada sest Id peab olema unikaalne
insert into DimEmployee(EmployeeKey, FirstName) values (1, 'Mike')
insert into DimEmployee(EmployeeKey, FirstName) values (1, 'John')
-- ei saa kustutada
drop index DimEmployee.PK_DimEmployee_EmployeeKey;

-- kui kustutame, siis saame andmed lisada sest n��d Id ei pea unikaalne olla
insert into DimEmployee(EmployeeKey, FirstName) values (1, 'Mike')
insert into DimEmployee(EmployeeKey, FirstName) values (1, 'John')

--Kuidas saab luua unikaalset mitte-klastreeritud indeksit FirstName ja LastName veeru p�hjal
Create Unique NonClustered Index UIX_DimEmployee_FirstName_LastName
On DimEmployee(FirstName, LastName)

--Kui peaksid lisama unikaalse piirangu, siis unikaalne indeks luuakse tagataustal.
ALTER TABLE DimEmployee
ADD CONSTRAINT UQ_DimEmployee_EmailAddress
UNIQUE NONCLUSTERED (EmailAddress)
--kuvame k�ik piirangud tabelis
sp_helpconstraint DimEmployee

--Kui soovin ainult viie rea tagasi l�kkamist ja viie mitte korduva sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY valikut.
CREATE UNIQUE INDEX IX_DimEmployee_EmailAddress
ON DimEmployee(EmailAddress)
WITH IGNORE_DUP_KEY







