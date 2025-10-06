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

--kui indeks on kustutatud, siis see töötab
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

-- kui kustutame, siis saame andmed lisada sest nüüd Id ei pea unikaalne olla
insert into DimEmployee(EmployeeKey, FirstName) values (1, 'Mike')
insert into DimEmployee(EmployeeKey, FirstName) values (1, 'John')

--Kuidas saab luua unikaalset mitte-klastreeritud indeksit FirstName ja LastName veeru põhjal
Create Unique NonClustered Index UIX_DimEmployee_FirstName_LastName
On DimEmployee(FirstName, LastName)

--Kui peaksid lisama unikaalse piirangu, siis unikaalne indeks luuakse tagataustal.
ALTER TABLE DimEmployee
ADD CONSTRAINT UQ_DimEmployee_EmailAddress
UNIQUE NONCLUSTERED (EmailAddress)
--kuvame kõik piirangud tabelis
sp_helpconstraint DimEmployee

--Kui soovin ainult viie rea tagasi lükkamist ja viie mitte korduva sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY valikut.
CREATE UNIQUE INDEX IX_DimEmployee_EmailAddress
ON DimEmployee(EmailAddress)
WITH IGNORE_DUP_KEY

------------------------------------------------------------------------------------------
-- 38. Indeksi plussid ja miinused

--Loo mitte-klastreeritud indeks Salary veerule:
create nonclustered index IX_DimEmployee_BaseRate
on DimEmployee(BaseRate);
-- kuva BaseRate veerg
select BaseRate from DimEmployee;

--Järgnev SELECT päring saab kasu Salary veeru indeksist 
-- kuva töötajad kelle tasu on 20 kuni 50 vahemikus
select * from DimEmployee where BaseRate > 20 and BaseRate < 50;

--Mitte ainult SELECT käsklus, vaid isegi DELETE ja UPDATE väljendid saavad indeksist kasu.
-- kustuta töötaja
delete from DimEmployee where BaseRate=24.5192
--uuenda töötajate tasu
update DimEmployee set BaseRate=30 where BaseRate=25.00

--Indeksid saavad aidata päringuid
--väljastab read sorteeritud järjestuses
select * from DimEmployee order by BaseRate
--tagurpidi skanneerimine
select * from DimEmployee order by BaseRate desc

--GROUP BY päringud saavad kasu indeksitest. 
--Kuna järjestikuses registrikirjes on vastavaid palku, siis tuleb kiiresti lugeda töötajate koguarv igal palgal.
select BaseRate, COUNT(BaseRate) as Total
from DimEmployee
group by BaseRate;

--Indeksi miinused:
--Lisa ruumi kõvakettal
--Sisestatud uuendus ja kustutamise käsud võivad olla aeglased