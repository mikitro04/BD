SET search_path TO segreteria;

--a
SELECT * FROM esami WHERE voto < 21 OR voto > 27;

--b
SELECT cod_docente, cognome FROM docenti WHERE indirizzo IS NULL; --per confrontare con NULL o NOT NULL si usa la keyword IS

--c
SELECT matricola FROM studenti WHERE cognome LIKE 'M%i' OR nome LIKE 'N%i';

--d
SELECT studente FROM esami WHERE (data_superamento > '2006-01-01' AND data_superamento < '2008-01-01') AND (voto = 30 OR voto = 33);

--e
SELECT DISTINCT cognome, nome FROM studenti WHERE data_nascita < '1984-01-01';

--f
SELECT * FROM studenti WHERE anno_corso < 2 ORDER BY data_nascita DESC, cognome DESC, nome DESC;