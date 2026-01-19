-- Nome: Alessio Giuseppe Muggittu


/*
a) Selezionare i dettagli dei pacchi (con le informazioni relative alla sua consegna: destinatario, data, tipologia) che sono stati consegnati a utenti di Cagliari
   (hint: l'indirizzo deve terminare con la sottostringa 'Cagliari'), la cui consegna è della tipologia 'fragile', ordinati per nomeCorriere e, a parità
   di corriere, in ordine decrescente di data (dalla più recente alla più vecchia).
*/

select pacco.*, consegna.destinatario, consegna.data, consegna.tipologia
from corriere.consegna join corriere.pacco on consegna.pacco = pacco.codiceP
join corriere.utente on consegna.destinatario = utente.codiceU
where utente.indirizzo like '%Cagliari' and consegna.tipologia like 'fragile'
order by pacco.nomeCorriere asc, consegna.data desc;


/*
b) Selezionare, per ogni consegna effettuata dal corriere 'brt', il nome e il cognome del mittente e il nome e cognome del destinatario di tale consegna.
*/

select mitt.nome as nomeMittente, mitt.cognome as cognomeMittente, dest.nome as nomeDestinatario, dest.cognome as cognomeDestinatario
from corriere.pacco join corriere.utente mitt on pacco.mittente = mitt.codiceU
join corriere.consegna on pacco.codiceP = consegna.pacco
join corriere.utente dest on consegna.destinatario = dest.codiceU
where pacco.nomeCorriere like 'brt';


/*
c) Selezionare, per ogni destinatario che ha ricevuto almeno 4 pacchi in data successiva al '2009-03-08', il peso del pacco più pesante tra quelli consegnati.
*/

select consegna.destinatario, max(pacco.peso)
from corriere.consegna join corriere.pacco on consegna.pacco = pacco.codiceP
where consegna.data > '2009-03-08'
group by consegna.destinatario having count(consegna.pacco) >= 4;


/*
d) Selezionare il nome dei corrieri che non hanno fatto nessuna consegna.
*/

select distinct pacco.nomeCorriere from corriere.pacco
where pacco.codiceP not in
(
	select consegna.pacco from corriere.consegna
);


/*
e) All'interno dello schema 'corriere', creare una vista 'destinatari_consegne_leggere' che contenga i dati degli utenti che hanno ricevuto almeno 3 pacchi
   con peso inferiore al 50% del peso del pacco più pesante. Per ciascun utente appartenente a questa vista, selezionare il codice, il nome dell'utente e il
   numero di pacchi consegnati dal corriere 'dhl'.
*/

create view corriere.destinatari_consegne_leggere as
select utente.*
from corriere.utente join corriere.consegna on utente.codiceU = consegna.destinatario
join corriere.pacco on consegna.pacco = pacco.codiceP
where pacco.peso < 
(
	select max(pacco.peso) * 0.5 from corriere.pacco
)
group by utente.codiceU having count(consegna.pacco) >= 3;


select dcl.codiceU, dcl.nome, count(consegna.pacco)
from corriere.destinatari_consegne_leggere dcl 
join corriere.consegna on dcl.codiceU = consegna.destinatario
join corriere.pacco on consegna.pacco = pacco.codiceP
where pacco.nomeCorriere like 'dhl'
group by dcl.codiceU, dcl.nome;