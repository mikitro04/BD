-- Nome: Alessio Giuseppe Muggittu


create schema biblioteca;

create table biblioteca.libro
(
	codiceL smallint primary key,
	titolo varchar(50) not null,
	autore varchar(50),
	editore varchar(50),
	isbn varchar(50) not null
);

create table biblioteca.utente
(
	codiceU smallint primary key,
	nome varchar(30) not null,
	cognome varchar(30),
	indirizzo varchar(50) not null,
	telefono varchar(20) not null,
	categoria varchar(30) check(categoria = any('{studente, docente}')),
	unique(telefono)
);

create table biblioteca.prestito
(
	libro smallint references biblioteca.libro(codiceL) on delete cascade on update cascade,
	utente smallint references biblioteca.utente(codiceU) on delete restrict on update cascade,
	data date,
	durata smallint check(durata between 1 and 180) not null,
	primary key(libro, utente, data)
);