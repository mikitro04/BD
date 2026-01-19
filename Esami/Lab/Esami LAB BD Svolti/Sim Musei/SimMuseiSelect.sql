-- Nome: Alessio Giuseppe Muggittu


/*
a) Selezionare il codice, il nome e la città dei musei che espongono almeno un'opera prodotta in un periodo compreso tra il 1300 e il 1600.
   Ordinare i risultati per nome museo e, a parità di nome, in ordine decrescente il codice, eliminando eventuali duplicati.
*/

select distinct museo.codiceM, museo.nomeMuseo, museo.citta 
from musei.museo
join musei.esposizione on museo.codiceM = esposizione.museo
join musei.opera on esposizione.opera = opera.codiceO
where opera.periodo between 1300 and 1600
order by museo.nomeMuseo asc, museo.codiceM desc;


/*
b) Selezionare le coppie di codici di opere aventi lo stesso nome ma diverso artista, escludendo quelle che appartengono allo stesso periodo.
   NB: le coppie devono essere distinte.
*/

select distinct o1.codiceO, o2.codiceO
from musei.opera o1, musei.opera o2
where o1.codiceO < o2.codiceO and o1.nomeOpera = o2.nomeOpera 
and o1.artista != o2.artista and o1.periodo != o2.periodo;


/*
c) Selezionare, per ogni museo che possiede 2 opere dello stesso artista: il nome del museo, il numero di opere complessive in esso esposte e la loro popolarità media.
*/

select museo.nomeMuseo, count(esposizione.opera), avg(esposizione.popolarita)
from musei.museo join musei.esposizione on museo.codiceM = esposizione.museo
where museo.codiceM in
(
	select esposizione.museo
	from musei.esposizione e1 join musei.opera on e1.opera = opera.codiceO
	group by e1.museo having count(opera.artista) >= 2
)
group by museo.nomeMuseo;


/*
d) Selezionare i dati dell'artista che ha eseguito l'opera esposta al museo 'Louvre' avente minore popolarità.
*/

select opera.artista 
from musei.opera 
join musei.esposizione on opera.codiceO = esposizione.opera
join musei.museo on esposizione.museo = museo.codiceM
where museo.nomeMuseo like 'Louvre' and esposizione.popolarita in
(
	select min(esposizione.popolarita) from musei.esposizione
);


/*
e) All'interno dello schema 'musei', creare una vista 'musei_espos_dipinto' che contenga i dati dei musei che espongono almeno 2 opere di
   tipologia "dipinto". Usando tale vista, per ciascun museo appartenente a tale vista, selezionare: il nome e la citta del museo, il periodo 
   relativo all'opera più vecchia e il periodo relativo all'opera più recente in esposizione in quel museo.
*/

create view musei.musei_espos_dipinto as
select museo.* from musei.museo
join musei.esposizione on museo.codiceM = esposizione.museo
join musei.opera on esposizione.opera = opera.codiceO
where opera.tipologia like 'dipinto'
group by museo.codiceM having count(opera.codiceO) >= 2;


select med.nomeMuseo, med.citta, min(opera.periodo) as piuVecchia, max(opera.periodo) as piuRecente
from musei.musei_espos_dipinto med 
join musei.esposizione on med.codiceM = esposizione.museo
join musei.opera on esposizione.opera = opera.codiceO
group by med.nomeMuseo, med.citta;