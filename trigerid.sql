--DDL trigger saab luua konkreetsesse andmebaasi v�i serveri tasemel.
--J�rgnev trigger k�ivitab vastuseks CREATE_TABLE DDL s�ndmuse: sp_rename
create trigger myFirstTrigger
on Database 
for CREATE_TABLE
as
begin
print 'New table created'
end

--kirjutab New table created
create table test(Id int)

--Kui soovid, et see trigger k�ivitatakse mitu korda nagu muuda ja kustuta tabel, siis eralda s�ndmused ning kasuta koma.
alter trigger myFirstTrigger
on Database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
print 'A table has just been created, modified or deleted'
end

--Kui n��d lood, muudad ja kustutad tabeli, siis trigger k�ivitub automaatselt ja saad s�numi: 
--A table has just been created, modified or deleted.  

--N��d vaatame n�idet, kuidas �ra hoida kasutajatel loomaks, muutmaks v�i kustatamiseks tabelit. 
alter trigger myFirstTrigger
on Database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
Rollback
print 'You cannot create, alter or drop a table'
end
--Selleks, et luua, muuta ja kustutada, siis selleks pead maha v�tma v�i kustutama triggeri.

--kui lubada triggerit
disable trigger myFirstTrigger on Database

--Kuidas kustutada triggerit:
drop trigger myFirstTrigger on Database;

--rename trigger
create trigger renameTable
on database
for RENAME
as
begin
print 'You just renamed something'
end

----------------------------------------------------------------------------
-- 93. Server-Scoped DDL triggerid

--K�sitletav trigger on andmebaasi vahemikus olev trigger. See ei luba luua, 
-- muuta ja kustutada tabeleid andmebaasist sinna, kuhu see on loodud.
create trigger databaseScopeTrigger
on database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
rollback;
print 'you cannot create, alter or drop a table in the current database'
end;

--Loo Serveri-vahemikus olev DDL trigger: See on nagu andembaasi vahemiku 
--trigger, aga erinevus seisneb, et sa pead lisama koodis s�na ALL peale:
create trigger serverScopeTrigger
on all server
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
rollback;
print 'you cannot create, alter or drop a table in any database on the server'
end;

--kuidas t�histada
disable trigger serverScopeTrigger on all server;
--kuidas lubada
enable trigger serverScopeTrigger on all server;
--kuidas kustutada
drop trigger serverScopeTrigger on all server;














