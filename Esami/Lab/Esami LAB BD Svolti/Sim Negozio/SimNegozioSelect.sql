-- Nome: Alessio Giuseppe Muggittu


/*
a) Selezionare nome, marca e categoria dei prodotti presenti in vetrine del reparto 'donna' il cui prezzo sia inferiore a 130, ordinati per 
   marca ed eliminando i duplicati
*/

select distinct prodotto.nomeProdotto, prodotto.marca, prodotto.categoria 
from negozio.prodotto 
join negozio.presenza on prodotto.codiceP = presenza.prodotto
join negozio.vetrina on presenza.vetrina = vetrina.codiceV
where vetrina.nomeReparto like 'donna' and prodotto.prezzo < 130.00
order by prodotto.marca;


/*
b) Selezionare la metratura della vetrina più piccola in cui è presente almeno un prodotto di marca 'Trussardi'.
*/

select vetrina.codiceV, min(vetrina.metratura)
from negozio.vetrina
join negozio.presenza on vetrina.codiceV = presenza.vetrina
join negozio.prodotto on presenza.prodotto = prodotto.codiceP
where prodotto.marca like 'Trussardi';


/*
c) Selezionare i dati delle vetrine che vendono esclusivamente prodotti il cui costo sia superiore al costo medio dei prodotti.
*/

select distinct vetrina.* 
from negozio.vetrina
join negozio.presenza on vetrina.codiceV = presenza.vetrina
join negozio.prodotto on presenza.prodotto = prodotto.codiceP
where prodotto.prezzo >
(
	select avg(prodotto.prezzo) from negozio.prodotto
);


/*
d) Selezionare i dati dei prodotti che sono presenti in almeno 2 vetrine, esclusi i prodotti presenti nelle vetrine il cui reparto è 'bambino'.
*/

select prodotto.* from negozio.prodotto
join negozio.presenza on prodotto.codiceP = presenza.prodotto
join negozio.vetrina on presenza.vetrina = vetrina.codiceV
where vetrina.nomeReparto not like 'bambino'
group by presenza.prodotto having count(presenza.vetrina) >= 2


/*
e) Selezionare il codice delle coppie di prodotti che sono venduti dalla stessa vetrina.
*/

select pr1.prodotto, pr2.prodotto
from negozio.presenza pr1, negozio.presenza pr2
where pr1.prodotto < pr2.prodotto and pr1.vetrina = pr2.vetrina;