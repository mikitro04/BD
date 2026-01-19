-- Nome: Alessio Giuseppe Muggittu


create schema immobili;

create table immobili.immobile
(
	codiceI varchar(3) primary key,
	indirizzo varchar(50) not null,
	tipo varchar(50) not null check(tipo = any('{appartamento, villetta, magazzino}')),
	zona varchar(50) not null check(zona = any('{residenziale, centro, periferia}')),
	prezzo_richiesto numeric(10, 2) not null
);

create table immobili.agente
(
	codiceA varchar(3) primary key,
	cognome varchar(30),
	nome varchar(30),
	agenzia varchar(50) not null
);

create table immobili.visita
(
	codI varchar(3) references immobili.immobile(codiceI) on update cascade on delete cascade,
	codA varchar(3) references immobili.agente(codiceA) on update cascade on delete restrict,
	data date,
	primary key(codI, codA, data)
);

create table immobili.vendita
(
	codI varchar(3) primary key references immobili.immobile(codiceI) on update cascade on delete restrict,
	codA varchar(3) references immobili.agente(codiceA) on update cascade on delete restrict not null,
	data date,
	prezzo numeric(10, 2) not null
);