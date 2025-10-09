--kuvame k�ik m��gide produkti nimetus ja hinnd
select EnglishProductName, UnitPrice
from FactInternetSales sale
join DimProduct prod
on prod.ProductKey = sale.ProductKey;

--Selleks, et arvutada kogu m��ki toote pealt, siis peame kirjutama GROUP BY p�ringu:
select EnglishProductName, SUM(UnitPrice) as TotalSales
from FactInternetSales sale
join DimProduct prod
on prod.ProductKey = sale.ProductKey
group by EnglishProductName;

--Kui soovime ainult neid tooteid, kus m��k kokku on suurem kui 60000�,
--siis kasutame filtreerimaks tooteid HAVING tingimust.
select EnglishProductName, SUM(UnitPrice) as TotalSales
from FactInternetSales sale
join DimProduct prod
on prod.ProductKey = sale.ProductKey
group by EnglishProductName
having SUM(UnitPrice) > 60000;

--Kui kasutame WHERE klasulit HAVING-u asemel, siis saame s�ntaksivea. 
--P�hjuseks on WHERE-i mitte t��tamine kokku arvutava funktsiooniga, 
--mis sisaldab SUM, MIN, MAX, AVG jne
select EnglishProductName, SUM(UnitPrice) as TotalSales
from FactInternetSales sale
join DimProduct prod
on prod.ProductKey = sale.ProductKey
where SUM(UnitPrice) > 60000
group by EnglishProductName;


--WHERE klausel filtreerib ridu enne kokkuarvutatavat kalkulatsiooni,
--aga HAVING filtreerib ridu peale kokkuarvutatavat kalkulatsiooni toimimist.

--See n�ide p�rib k�ik read Sales tabelis, mis n�itavad summat 
--ning eemaldavad k�ik tooted peale iPhone-i ja Speakerite.
select EnglishProductName, SUM(UnitPrice) as TotalSales
from FactInternetSales sale
join DimProduct prod
on prod.ProductKey = sale.ProductKey
where EnglishProductName in ('AWC Logo Cap')
group by EnglishProductName;

--Kalkuleeri iPhone-i ja Speakerite m��ki ja kasutad selleks HAVING klauslit.
select EnglishProductName, SUM(UnitPrice) as TotalSales
from FactInternetSales sale
join DimProduct prod
on prod.ProductKey = sale.ProductKey
group by EnglishProductName
having EnglishProductName in ('AWC Logo Cap');

--Kiiruse seisukohast on HAVING aeglasem, kui WHERE ja peaks v�imalusel v�ltima.



