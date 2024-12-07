-- a) fornitore/i da cui si acquista il prodotto/i più costoso/i (lista del tipo fornitore, prodotto, prezzo_acquisto);

select fornitori.Id_Fornitore, prodotti.Id_Prodotto, prodotti.Prezzo_Acquisto
from fornitori
join prodotti on fornitori.Id_Fornitore = prodotti.Id_Fornitore
where prodotti.Prezzo_Acquisto in (
select max(prodotti.Prezzo_Acquisto)
    from prodotti
);

-- b) dati dei clienti che nell’anno in corso hanno acquistato sia il prodotto P01 che il
-- prodotto P41, ma non il prodotto P35;

SELECT Distinct clienti.*
FROM clienti
JOIN Ordini on clienti.id_cliente = ordini.id_cliente
WHERE Clienti.id_cliente in (
	select Ordini.id_cliente
	From Ordini
	JOIN Dettaglio_ordini ON Dettaglio_ordini.id_ordine = ordini.id_ordine
	JOIN Prodotti ON Dettaglio_ordini.id_Prodotto = Prodotti.id_Prodotto
	where Prodotti.Descrizione = "P01"
	AND Ordini.id_cliente in (
		select Ordini.id_cliente
		From Ordini
		JOIN Dettaglio_ordini ON Dettaglio_ordini.id_ordine = ordini.id_ordine
		JOIN Prodotti ON Dettaglio_ordini.id_Prodotto = Prodotti.id_Prodotto
		where Prodotti.Descrizione = "P41"
		AND Ordini.id_cliente NOT IN(
			select Ordini.id_cliente
			From Ordini
			JOIN Dettaglio_ordini ON Dettaglio_ordini.id_ordine = ordini.id_ordine
			JOIN Prodotti ON Dettaglio_ordini.id_Prodotto = Prodotti.id_Prodotto
			where Prodotti.Descrizione = "P35"
			)
		)
)
AND Ordini.Data_Ricezione BETWEEN
"2019-01-01" AND "2019-12-31"
;


-- c) ammontare del valore dei prodotti evasi nel mese di gennaio 2009;

select sum(prodotti.Prezzo_Vendita) as totValProdotti
from ordini
join dettaglio_ordini on ordini.Id_Ordine = dettaglio_ordini.Id_Ordine
join prodotti on dettaglio_ordini.Id_Prodotto = prodotti.Id_Prodotto
where ordini.Data_Evasione between '2019-01-01' and '2019-12-31';


-- d) lista del tipo cliente, importo totale ordini per l’anno 2010;

select clienti.ID_Cliente, sum(ordini.costo_unitario)
from clienti
join ordini on clienti.ID_Cliente = ordini.Id_Cliente
join dettaglio_ordini on ordini.Id_Ordine = dettaglio_ordini.Id_Ordine
where ordini.Data_Ricezione between '2019-01-01' and '2019-12-31'
group by clienti.ID_Cliente;


-- e) per ogni prodotto, quantità ordinata dai clienti nel 2011 suddivisa per provincia;

select fornitori.Provincia, count(ordini.Id_Ordine)
from prodotti
join dettaglio_ordini on prodotti.Id_Prodotto = dettaglio_ordini.Id_Prodotto
join ordini on dettaglio_ordini.Id_Ordine = ordini.Id_Ordine
join clienti on ordini.Id_Cliente = clienti.ID_Cliente
join fornitori on prodotti.Id_Fornitore = fornitori.Id_Fornitore
where ordini.Data_Evasione between '2019-01-01' and '2019-12-31'
group by fornitori.Provincia;


-- f) categoria/e che nel 2010 è stata la più redditizia in termini economici (guadagno).

select categorie.Id_Categoria, sum(prodotti.Prezzo_Vendita) as tot
from categorie
join prodotti on categorie.Id_Categoria = prodotti.Id_Categoria
group by categorie.Id_Categoria
having tot in (
select max(totPrezzo)
    from(
select categorie.Id_Categoria, sum(prodotti.Prezzo_Vendita) as totPrezzo
        from categorie
        join prodotti on categorie.Id_Categoria = prodotti.Id_Categoria
        group by categorie.Id_Categoria
    ) as sumPrezzo
);