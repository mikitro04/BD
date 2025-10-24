SET search_path TO segreteria;

--a
SELECT corsi.cod_corso, corsi.nome FROM corsi
JOIN docenti ON corsi.docente = docenti.matricola
WHERE docenti.cognome LIKE '%n_'
    OR docenti.cognome LIKE '%r_'
;

--b
SELECT esami.*, AGE(current_timestamp, studenti.data_nascita) FROM esami
JOIN studenti ON studenti.matricola = esami.studente
ORDER BY studenti.anno_corso;

--c
SELECT corsi.*, esami.data_superamento from esami 
JOIN corsi on esami.corso = corsi.cod_corso
WHERE (corsi.nome = 'Programmazione'
    OR corsi.nome = 'Algebra')
    AND esami.voto >= 21 AND esami.voto <= 27
ORDER BY esami.data_superamento;

--d
SELECT * FROM docenti
LEFT JOIN corsi ON docenti.cod_docente = corsi.docente
WHERE docenti.indirizzo LIKE '%Roma'
ORDER BY cod_corso DESC;