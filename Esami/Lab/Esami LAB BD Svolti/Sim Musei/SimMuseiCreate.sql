-- Nome: Alessio Giuseppe Muggittu


create schema musei;

create table musei.museo
(
	codiceM smallint primary key,
	nomeMuseo varchar(50) not null,
	citta varchar(50),
	categoria varchar(50) check(categoria = any('{arte, archeologia, etnologia}')),
	numVisitatori int check(numVisitatori > 0),
	unique(nomeMuseo)
);

create table musei.opera
(
	codiceO smallint primary key,
	nomeOpera varchar(50) not null,
	artista varchar(50) not null,
	periodo smallint not null,
	tipologia varchar(50) check(tipologia = any('{dipinto, incisione, scultura}')),
	unique(nomeOpera)
);

create table musei.esposizione
(
	museo smallint references musei.museo(codiceM) on delete cascade on update cascade,
	opera smallint references musei.opera(codiceO) on delete restrict on update cascade,
	popolarita smallint check(popolarita between 0 and 10),
	primary key(museo, opera)
);