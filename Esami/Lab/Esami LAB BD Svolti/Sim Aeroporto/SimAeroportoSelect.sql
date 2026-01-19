-- Nome: Alessio Giuseppe Muggittu


-- Selezionare gli id degli aerei del modello 'Airbus' (hint: il modello deve iniziare con Airbus) che partono da Roma e che portano almeno
-- un passeggero nato dopo '2019-01-01'. Ordinare i risultati in base all'id.

select aereo.idAereo
from aeroporto.aereo join aeroporto.volo on aereo.idAereo = volo.aereo
join aeroporto.passeggero on volo.idVolo = passeggero.volo
where aereo.modello like '%Airbus%' and volo.cittaPartenza like 'Roma' and passeggero.dataNascita > '2019-01-01'
order by aereo.idAereo;


-- Selezionare il codice delle coppie di aerei che sono partiti allo stesso orario ma in date differenti. Eliminare gli eventuali duplicati.
-- NB: le coppie devono essere distinte.

select distinct v1.aereo, v2.aereo from aeroporto.volo v1, aeroporto.volo v2
where v1.aereo < v2.aereo and v1.oraPartenza = v2.oraPartenza and v1.data != v2.data;


-- Selezionare, per ogni aereo che effettua almeno 3 voli con più di 50 passeggeri: l'id dell'aereo, la data di nascita del passeggero più giovane, e la
-- data di nascita del passeggero più anziano che ha volato su quell'aereo.

select volo.aereo, min(passeggero.dataNascita), max(passeggero.dataNascita)
from aeroporto.volo join aeroporto.passeggero on passeggero.volo = volo.idVolo
where volo.numPasseggeri > 50
group by volo.aereo having count(volo.aereo) >= 3;


-- Selezionare per ciascun passeggero: nome, cognome, data di nascita e il modello di aereo del volo che ha effettuato più di recente.

select passeggero.nome, passeggero.cognome, passeggero.dataNascita, aereo.modello
from aeroporto.passeggero
join aeroporto.volo on passeggero.volo = volo.idVolo
join aeroporto.aereo on volo.aereo = aereo.idAereo
where (volo.data, volo.oraPartenza) in
(
	select max(v1.data), max(v1.oraPartenza) from aeroporto.volo v1
	where v1.idVolo = passeggero.volo
);


-- All'interno dello schema 'aeroporto', creare una vista 'modelli_preferiti' che contenga i dati degli aerei il cui numero medio dei
-- passeggeri presenti nei loro voli sia superiore al 70% del numero di passeggeri del volo più pieno. Utilizzando tale vista, selezionare
-- l'id degli aerei e la data relativa al volo più recente e quella relativa al volo più vecchio effettuati con gli aerei appartenenti alla vista.

create view aeroporto.modelli_preferiti as
select aereo.* 
from aeroporto.aereo join aeroporto.volo on aereo.idAereo = volo.aereo
group by aereo.idAereo having avg(volo.numPasseggeri) > 0.7 * (select max(numPasseggeri) from aeroporto.volo);

select mp.idAereo, max(volo.data), min(volo.data) 
from aeroporto.modelli_preferiti mp join aeroporto.volo on mp.idAereo = volo.aereo
group by mp.idAereo;