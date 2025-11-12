create schema biblioteca;

create table biblioteca.LIBRO (
	codiceL INT primary key,
	titolo varchar(30) not null,
	autore varchar(30),
	editore varchar(30),
	isbn varchar(20) not null
);

create table biblioteca.UTENTE (
	codiceU int primary key,
	nome varchar(20) not null,
	cognome varchar(20),
	indirizzo varchar(30) not null,
	telefono varchar(20) not null unique,
	categoria varchar(20) check(categoria in('studente','docente'))
);

create table biblioteca.PRESTITO (
	libro int references biblioteca.libro(codiceL) on update cascade on delete cascade,
	utente int references biblioteca.utente(codiceU) on update cascade,
	data date,
	durata int not null check(durata between 1 and 180),
	primary key(libro, utente, data)
);

-- a)
select titolo, autore, editore from biblioteca.libro
join biblioteca.prestito on codiceL=libro
join biblioteca.utente on utente=codiceU
where categoria='docente' and durata>40
order by titolo, codiceU desc;

-- b)
select L1.titolo, L2.titolo from biblioteca.libro L1, biblioteca.libro L2
where L1.codiceL>L2.codiceL and L1.editore=L2.editore;

-- c)
select libro, count(distinct utente) as num_studenti, sum(durata) as durata_tot
from biblioteca.prestito join biblioteca.utente on utente=codiceU
where categoria='studente' group by libro;

-- d)
select codiceU, nome, data from biblioteca.utente
join biblioteca.prestito on codiceU=utente
where categoria='docente' and codiceU in
(select utente from biblioteca.prestito group by utente having count(*)>2)
and data in
(select min(data) from biblioteca.prestito group by utente having count(*)>2);

-- e)
create or replace view biblioteca.statistiche_utenti as(
	select utente.*, sum(durata) as durata_totale, avg(durata) as durata_media
	from biblioteca.utente join biblioteca.prestito on codiceU=utente where codiceU in
		(select utente from biblioteca.prestito join biblioteca.libro on libro=codiceL
		group by utente having count(distinct editore)>1)
	group by utente.codiceU
);

select codiceU, titolo from biblioteca.statistiche_utenti
join biblioteca.prestito on codiceU=utente join biblioteca.libro on libro=codiceL
where durata_media>=all (select durata_media from biblioteca.statistiche_utenti)
and data in (select min(data) from biblioteca.prestito group by utente);
