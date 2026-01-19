-- Nome: Alessio Giuseppe Muggittu


create schema negozio;

create table negozio.vetrina
(
	codiceV smallint primary key,
	nomeVetrina varchar(50) not null,
	nomeReparto varchar(50) check(nomeReparto = any('{uomo, donna, bambino}')) not null,
	metratura smallint check(metratura between 10 and 200),
	unique(nomeVetrina)
);

create table negozio.prodotto
(
	codiceP smallint primary key,
	nomeProdotto varchar(50) not null,
	marca varchar(50) not null,
	categoria varchar(50) not null,
	prezzo numeric(10, 2) check(prezzo > 1) not null
);

create table negozio.presenza
(
	vetrina smallint references negozio.vetrina(codiceV) on delete cascade on update cascade,
	prodotto smallint references negozio.prodotto(codiceP) on delete restrict on update cascade,
	quantita smallint check(quantita > 0),
	primary key(vetrina, prodotto)
);