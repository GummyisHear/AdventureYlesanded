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
-- võib kustutada seda ära ise, või seda automaatselt kustutakse kui db ühendus lõppeb
drop table #PersonDetails;

--loome protseduur kus loome uus ajutine tabel, ja see tabel kustutakse kui protseduur lõppeb
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
--otsime tabel, peab tagastada tühi name, sest tabel on kustutatud
select name from tempdb..sysobjects
where name like '#PersonDetails%';

--Loome globaalne ajutine tabel, seda nähtavad kõikidele ühendustele serveris
create table ##EmployeeDetails(Id int primary key identity(1,1),
Name nvarchar(20))

select * from DimEmployee;