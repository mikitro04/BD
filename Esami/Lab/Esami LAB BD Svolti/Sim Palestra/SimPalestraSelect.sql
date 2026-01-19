-- Nome: Alessio Giuseppe Muggittu


-- Selezionare nome, cognome e categoria degli atleti maggiorenni (età maggiore o uguale a 18) iscritti a corsi tenuti dall'istruttore 'Roberto', ordinati
-- per nome ed eliminando i duplicati.

select distinct atleta.nomeAtleta, atleta.cognomeAtleta, atleta.categoria 
from palestra.atleta join palestra.iscrizione on atleta.codiceA = iscrizione.atleta
join palestra.corso on iscrizione.corso = corso.codiceC
where atleta.eta >= 18 and corso.nomeIstruttore like 'Roberto'
order by atleta.nomeAtleta;


-- Selezionare il codice delle coppie di atleti che hanno stesso nome ma che appartengono a categorie diverse.

select a1.codiceA, a2.codiceA from palestra.atleta a1, palestra.atleta a2
where a1.codiceA < a2.codiceA and a1.nomeAtleta = a2.nomeAtleta and a1.categoria != a2.categoria;


-- Selezionare, per ogni corso a cui sono iscritti almeno 3 atleti diversi, il nome del corso e l'età media degli atleti iscritti a quel corso.

select corso.nomeCorso, avg(atleta.eta) 
from palestra.corso join palestra.iscrizione on corso.codiceC = iscrizione.corso
join palestra.atleta on iscrizione.atleta = atleta.codiceA
group by corso.nomeCorso having count(distinct atleta.codiceA) >= 3;


-- Selezionare, per ogni corso: il nome del corso, e il nome, il cognome e la categoria dell'atleta più giovane iscritto a quel corso.

select corso.nomeCorso, atleta.nomeAtleta, atleta.cognomeAtleta, atleta.categoria, atleta.eta
from palestra.corso join palestra.iscrizione on corso.codiceC = iscrizione.corso
join palestra.atleta on iscrizione.atleta = atleta.codiceA
where atleta.eta in
(
	select min(atleta.eta) 
	from palestra.atleta join palestra.iscrizione on atleta.codiceA = iscrizione.atleta
	where corso.codiceC = iscrizione.corso
)
group by corso.nomeCorso, atleta.nomeAtleta, atleta.cognomeAtleta, atleta.categoria, atleta.eta;


-- All'interno dello schema 'palestra', creare una vista 'corsi_abbonamento_open' che contenga i dati dei corsi che abbiano un numero di abbonamenti
-- 'open' superiore a 3. Usando tale vista, per ciascun corso con un numero di abbonamenti 'open' superiore a 3, selezionare: il nome del corso,
-- e l'età dell'atleta più vecchio e di quello più giovane che sono iscritti a quel corso.

create view palestra.corsi_abbonamento_open as
select corso.* 
from palestra.corso join palestra.iscrizione on corso.codiceC = iscrizione.corso
where iscrizione.abbonamento like 'open'
group by corso.codiceC having count(iscrizione.abbonamento) > 3;

select cao.nomeCorso, max(atleta.eta), min(atleta.eta)
from palestra.corsi_abbonamento_open cao join palestra.iscrizione on cao.codiceC = iscrizione.corso
join palestra.atleta on iscrizione.atleta = atleta.codiceA
group by cao.nomeCorso;