--DDL trigger saab luua konkreetsesse andmebaasi või serveri tasemel.
--Järgnev trigger käivitab vastuseks CREATE_TABLE DDL sündmuse: sp_rename
create trigger myFirstTrigger
on Database 
for CREATE_TABLE
as
begin
print 'New table created'
end

--kirjutab New table created
create table test(Id int)

--Kui soovid, et see trigger käivitatakse mitu korda nagu muuda ja kustuta tabel, siis eralda sündmused ning kasuta koma.
alter trigger myFirstTrigger
on Database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
print 'A table has just been created, modified or deleted'
end

--Kui nüüd lood, muudad ja kustutad tabeli, siis trigger käivitub automaatselt ja saad sõnumi: 
--A table has just been created, modified or deleted.  

--Nüüd vaatame näidet, kuidas ära hoida kasutajatel loomaks, muutmaks või kustatamiseks tabelit. 
alter trigger myFirstTrigger
on Database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
Rollback
print 'You cannot create, alter or drop a table'
end
--Selleks, et luua, muuta ja kustutada, siis selleks pead maha võtma või kustutama triggeri.

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