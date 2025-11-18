CREATE SCHEMA prestiti;

CREATE TABLE prestiti.CLIENTE (
    IDcliente CHAR(3) PRIMARY KEY,
    cognome VARCHAR(16) NOT NULL,
    nome VARCHAR(16) NOT NULL,
    citta_residenza VARCHAR(16),
    UNIQUE(cognome, nome)
);

CREATE TABLE prestiti.FILIALE (
    IDfiliale CHAR(3) PRIMARY KEY,
    importo_max DOUBLE NOT NULL,
    citta VARCHAR(16)
);

CREATE TABLE prestiti.PRESTITO (
    IDprestito CHAR(3) PRIMARY KEY, 
    filiale CHAR(3) NOT NULL, 
    importo DOUBLE NOT NULL, 
    data_accensione DATE NOT NULL, 
    data_scadenza DATE NOT NULL,
    CHECK(data_accensione < data_scadenza),
    FOREIGN KEY (filiale) REFERENCES FILIALE(IDfiliale)
);

CREATE TABLE prestiti.ACCORDATO_A (
    prestito CHAR(3),
    cliente CHAR(3),
    PRIMARY KEY(prestito, cliente),
    FOREIGN KEY(prestito) REFERENCES PRESTITO(IDprestito),
    FOREIGN KEY(cliente) REFERENCES CLIENTE(IDcliente)
);