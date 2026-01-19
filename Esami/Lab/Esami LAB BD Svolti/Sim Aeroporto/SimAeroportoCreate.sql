-- Nome: Alessio Giuseppe Muggittu


create schema aeroporto;

create table aeroporto.aereo
(
	idAereo varchar(10) primary key,
	modello varchar(30) check(modello = any('{Boeing 737, Boeing 757, Airbus A320, Airbus A330}')),
	numPosti smallint
);

create table aeroporto.volo
(
	idVolo varchar(10) primary key,
	aereo varchar(10) references aeroporto.aereo(idAereo) on update cascade on delete restrict not null,
	data date not null,
	oraPartenza time not null,
	oraArrivo time,
	cittaPartenza varchar(30) not null,
	cittaArrivo varchar(30) not null,
	numPasseggeri smallint check(numPasseggeri >= 0),
	unique(aereo, data, oraPartenza)
);

create table aeroporto.passeggero
(
	id smallint primary key,
	nome varchar(30) not null,
	cognome varchar(30) not null,
	dataNascita date not null,
	volo varchar(10) references aeroporto.volo(idVolo) on update cascade on delete cascade not null
);