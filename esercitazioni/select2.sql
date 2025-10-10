SET search_path TO segreteria;

--a
SELECT esami.studente FROM esami
JOIN corsi ON esami.corso = corsi.cod_corso 
WHERE corsi.nome = 'Basi di dati' AND esami.voto > 27;

--b
SELECT DISTINCT studenti.cognome, studenti.nome FROM studenti
JOIN esami ON studenti.matricola = esami.studente
WHERE esami.data_superamento >= '2007-01-01' AND esami.data_superamento < '2008-01-01';

--c
SELECT esami.* FROM esami 
JOIN studenti ON esami.studente = studenti.matricola
WHERE studenti.nome = 'Mario' AND studenti.cognome = 'Monti'
ORDER BY esami.voto DESC, esami.data_superamento ASC;

--d
SELECT (s1.matricola, s2.matricola) AS Omonimi FROM studenti s1
JOIN studenti s2 ON s1.nome = s2.nome AND s1.cognome = s2.cognome AND s1.matricola < s2.matricola;
--non uso <> perchè altrimenti avrei sia la coppia (A, B) che (B, A)

--e
SELECT studenti.*, esami.corso, esami.voto FROM studenti 
LEFT JOIN esami ON studenti.matricola = esami.studente
WHERE studenti.anno_corso = 1;

--f
SELECT docenti.*, corsi.nome FROM docenti
LEFT JOIN corsi ON docenti.cod_docente = corsi.docente;