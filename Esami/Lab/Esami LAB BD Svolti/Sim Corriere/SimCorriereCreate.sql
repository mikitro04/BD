-- Nome: Alessio Giuseppe Muggittu


create schema corriere;

create table corriere.utente
(
	codiceU smallint primary key,
	nome varchar(30) not null,
	cognome varchar(30),
	indirizzo varchar(50) not null,
	telefono varchar(20) not null,
	unique(telefono)
);

create table corriere.pacco
(
	codiceP smallint primary key,
	nomeCorriere varchar(50) not null,
	mittente smallint references corriere.utente(codiceU) on update cascade,
	peso smallint check(peso > 0)
);

create table corriere.consegna
(
	pacco smallint primary key references corriere.pacco(codiceP) on update cascade on delete cascade,
	destinatario smallint references corriere.utente(codiceU) on update cascade on delete restrict,
	data date not null,
	tipologia varchar(30) check(tipologia = any('{prioritario, economico, fragile}')) not null
);