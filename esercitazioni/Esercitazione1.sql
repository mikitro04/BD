CREATE SCHEMA segreteria;

CREATE DOMAIN segreteria.votazione AS INTEGER
	CHECK (
		(VALUE BETWEEN 18 AND 30) OR (VALUE = 33)
	)
;

CREATE TABLE segreteria.studenti (
	matricola CHAR(6) PRIMARY KEY, /*PRIMARY KEY => UNIQUE, NOT NULL*/
	cognome VARCHAR(16) NOT NULL, 
	nome VARCHAR(16) NOT NULL,
	data_nascita DATE NOT NULL,
	anno_corso INTEGER DEFAULT 1 NOT NULL CHECK(anno_corso BETWEEN 1 AND 3),
	UNIQUE(cognome, nome, data_nascita)
);

/*docenti (cod_docente, cognome, nome, indirizzo)*/
CREATE TABLE segreteria.docenti (
	cod_docente CHAR(6) PRIMARY KEY,
	cognome VARCHAR(16) NOT NULL,
	nome VARCHAR(16) NOT NULL,
	indirizzo VARCHAR(64)
);

/*corsi (cod_corso, nome, docente)*/
CREATE TABLE segreteria.corsi (
	cod_corso CHAR(3) PRIMARY KEY,
	nome VARCHAR(16),
	docente CHAR(6) NOT NULL,
	UNIQUE (nome, docente)
);

/*esami (studente, corso, data, voto)*/
CREATE TABLE segreteria.esami (
	studente CHAR(6) NOT NULL,
	corso CHAR(3) NOT NULL,
	data_superamento DATE NOT NULL,
	voto segreteria.votazione NOT NULL,
	PRIMARY KEY(studente, corso)
);