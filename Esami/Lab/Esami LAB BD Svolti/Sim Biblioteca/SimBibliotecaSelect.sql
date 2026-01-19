-- Nome: Alessio Giuseppe Muggittu


/*
a) Selezionare titolo, autore e editore dei libri che sono stati presi in prestito da un 'docente' per una durata superiore a 40 giorni, ordinare
   il risultato per titolo e a parità di titolo per codice docente decrescente.
*/

select libro.titolo, libro.autore, libro.editore, utente.codiceU
from biblioteca.libro join biblioteca.prestito on libro.codiceL = prestito.libro
join biblioteca.utente on prestito.utente = utente.codiceU
where utente.categoria like 'docente' and prestito.durata > 40
order by libro.titolo asc, utente.codiceU desc;


/*
b) Selezionare il titolo dei libri, considerati a coppie, aventi stesso editore.
*/

select l1.titolo, l2.titolo
from biblioteca.libro l1, biblioteca.libro l2
where l1.codiceL < l2.codiceL and l1.editore = l2.editore;


/*
c) Selezionare per ogni libro: il codice libro, il numero di 'studenti' distinti che lo hanno preso in prestito e la 
   durata totale dei prestiti ad esso relativo
*/

select libro.codiceL, count(distinct utente.codiceU), sum(prestito.durata)
from biblioteca.libro join biblioteca.prestito on libro.codiceL = prestito.libro
join biblioteca.utente on prestito.utente = utente.codiceU
where utente.categoria like 'studente' 
group by libro.codiceL;


/*
d) Selezionare, per ogni docente che ha preso in prestito almeno 3 libri: il codice docente, il nome, e 
   la data del prestito più "vecchio" ad esso relativo.
*/

select utente.codiceU, utente.nome, min(prestito.data)
from biblioteca.utente join biblioteca.prestito on utente.codiceU = prestito.utente
where utente.categoria like 'docente'
group by utente.codiceU having count(prestito.libro) >= 3;


/*
e) All'interno dello schema 'biblioteca', creare una vista 'statistiche_utenti' che contenga i dati degli utenti che hanno preso in prestito
   almeno 2 libri di editori diversi, e riportare la durata totale e la durata media dei prestiti a essi relativi. Utilizzando tale vista
   selezionare l'utente avente la durata media maggiore di tutti, e riportare, il titolo del libro più vecchio da esso preso in prestito.
*/

-- view

create view biblioteca.statistiche_utenti as
select utente.*, sum(prestito.durata) as durataTotale, avg(prestito.durata) as durataMedia
from biblioteca.utente join biblioteca.prestito on utente.codiceU = prestito.utente
join biblioteca.libro on prestito.libro = libro.codiceL
group by utente.codiceU having count(distinct libro.editore) >= 2;

-- query con view

select utente.codiceU, libro.titolo
from biblioteca.utente join biblioteca.prestito on utente.codiceU = prestito.utente
join biblioteca.libro on prestito.libro = libro.codiceL
where utente.codiceU =
(
	select stat.codiceU from biblioteca.statistiche_utenti stat
	order by stat.durataMedia desc limit 1
)
order by prestito.data asc limit 1;