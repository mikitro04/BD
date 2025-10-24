SET search_path TO segreteria;

ALTER TABLE esami
ADD FOREIGN KEY (studente) REFERENCES studenti(matricola)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE esami
ADD FOREIGN KEY (corso) REFERENCES corsi(cod_corso)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE corsi
ADD FOREIGN KEY (docente) REFERENCES docenti(cod_docente)
ON DELETE NO ACTION
ON UPDATE CASCADE;

DELETE FROM segreteria.studenti WHERE matricola = 451100;

DELETE FROM segreteria.studenti WHERE matricola = 424200;

UPDATE segreteria.docenti SET cod_docente = '101010' WHERE cod_docente = '100100'

ALTER TABLE segreteria.studenti
ALTER COLUMN anno_corso
SET DEFAULT 3;

ALTER TABLE segreteria.docenti
ADD COLUMN num_telefono CHAR(10) DEFAULT NULL;

/*'matricola', 'cognome', 'nome', 'b-date', anno);*/
INSERT INTO segreteria.studenti VALUES ('664700', 'WiFi', 'Free', '1884-01-07', 1);


DELETE FROM segreteria.studenti WHERE (data_nascita < DATE '1900-01-01');

ALTER TABLE segreteria.studenti
ADD CHECK (data_nascita > DATE '1900-01-01');
