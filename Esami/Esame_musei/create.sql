-- Schema)
CREATE DATABASE db65959;

CREATE SCHEMA IF NOT EXISTS musei;

CREATE TABLE musei.museo
(
    codice_m       int PRIMARY KEY,
    nome_museo     varchar(50) NOT NULL,
    citta          varchar(50),
    categoria      varchar(12) CHECK ( categoria IN ('arte', 'archeologia', 'etnologia') ),
    num_visitatori int CHECK ( num_visitatori > 0 ),
    UNIQUE (nome_museo)
);

CREATE TABLE musei.opera
(
    codice_o   int PRIMARY KEY,
    nome_opera varchar(50) NOT NULL,
    artista    varchar(50) NOT NULL,
    periodo    smallint    NOT NULL,
    tipologia  varchar(10) CHECK ( tipologia IN ('dipinto', 'incisione', 'scultura') ),
    UNIQUE (nome_opera)
);

CREATE TABLE musei.esposizione
(
    museo      int,
    opera      int,
    popolarita smallint CHECK (popolarita BETWEEN 0 AND 10),
    PRIMARY KEY (museo, opera),
    FOREIGN KEY (museo) REFERENCES musei.museo (codice_m) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (opera) REFERENCES musei.opera (codice_o) ON DELETE RESTRICT ON UPDATE CASCADE
)
