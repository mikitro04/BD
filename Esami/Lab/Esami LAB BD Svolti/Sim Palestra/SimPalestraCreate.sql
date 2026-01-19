-- Nome: Alessio Giuseppe Muggittu


create schema palestra;

create table palestra.corso
(
	codiceC smallint primary key,
	nomeCorso varchar(50) not null,
	nomeIstruttore varchar(50) not null,
	capienza smallint check(capienza between 15 and 30),
	unique(nomeCorso)
);

create table palestra.atleta
(
	codiceA smallint primary key,
	nomeAtleta varchar(50) not null,
	cognomeAtleta varchar(50) not null,
	eta smallint,
	categoria varchar(50) check(categoria = any('{principiante, intermedio, esperto}'))
);

create table palestra.iscrizione
(
	corso smallint references palestra.corso(codiceC) on delete cascade on update cascade,
	atleta smallint references palestra.atleta(codiceA) on delete restrict on update cascade,
	abbonamento varchar(30) check(abbonamento = any('{open, singolo}')),
	primary key(corso, atleta)
);