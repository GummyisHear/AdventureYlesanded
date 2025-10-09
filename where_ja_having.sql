--kuvame kõik müügide produkti nimetus ja hinnd
select EnglishProductName, UnitPrice
from FactInternetSales sale
join DimProduct prod
on prod.ProductKey = sale.ProductKey;

--Selleks, et arvutada kogu müüki toote pealt, siis peame kirjutama GROUP BY päringu:
select EnglishProductName, SUM(UnitPrice) as TotalSales
from FactInternetSales sale
join DimProduct prod
on prod.ProductKey = sale.ProductKey
group by EnglishProductName;

--Kui soovime ainult neid tooteid, kus müük kokku on suurem kui 60000€,
--siis kasutame filtreerimaks tooteid HAVING tingimust.
select EnglishProductName, SUM(UnitPrice) as TotalSales
from FactInternetSales sale
join DimProduct prod
on prod.ProductKey = sale.ProductKey
group by EnglishProductName
having SUM(UnitPrice) > 60000;

--Kui kasutame WHERE klasulit HAVING-u asemel, siis saame süntaksivea. 
--Põhjuseks on WHERE-i mitte töötamine kokku arvutava funktsiooniga, 
--mis sisaldab SUM, MIN, MAX, AVG jne
select EnglishProductName, SUM(UnitPrice) as TotalSales
from FactInternetSales sale
join DimProduct prod
on prod.ProductKey = sale.ProductKey
where SUM(UnitPrice) > 60000
group by EnglishProductName;


--WHERE klausel filtreerib ridu enne kokkuarvutatavat kalkulatsiooni,
--aga HAVING filtreerib ridu peale kokkuarvutatavat kalkulatsiooni toimimist.

--See näide pärib kõik read Sales tabelis, mis näitavad summat 
--ning eemaldavad kõik tooted peale iPhone-i ja Speakerite.
select EnglishProductName, SUM(UnitPrice) as TotalSales
from FactInternetSales sale
join DimProduct prod
on prod.ProductKey = sale.ProductKey
where EnglishProductName in ('AWC Logo Cap')
group by EnglishProductName;

--Kalkuleeri iPhone-i ja Speakerite müüki ja kasutad selleks HAVING klauslit.
select EnglishProductName, SUM(UnitPrice) as TotalSales
from FactInternetSales sale
join DimProduct prod
on prod.ProductKey = sale.ProductKey
group by EnglishProductName
having EnglishProductName in ('AWC Logo Cap');

--Kiiruse seisukohast on HAVING aeglasem, kui WHERE ja peaks võimalusel vältima.



