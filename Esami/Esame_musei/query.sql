-- a) selezionare il codice, il nome e la città dei musei che espongono almeno un'opera prodotta
-- in un periodo compreso tra il 1300 e il 1600. Ordinare i risultati per nome museo e a parità
-- di nome in ordine decrescente di codice, eliminando eventuali duplicati
SELECT DISTINCT m.codice_m, nome_museo, citta
FROM musei.museo m
         JOIN musei.esposizione e ON m.codice_m = e.museo
         JOIN musei.opera o ON o.codice_o = e.opera
WHERE periodo BETWEEN 1300 AND 1600
ORDER BY nome_museo, codice_m DESC;

-- b) selezionare le coppie di codici di opere aventi lo stesso nome ma diverso artista,
-- escludendo quelle che appartengono allo stesso periodo. NB: le coppie devono essere
-- distinte (es. la coppia 1,5 e 5,1 deve comparire solo una volta.
SELECT o1.codice_o as opera1,
       o2.codice_o as opera2
FROM musei.opera o1
         JOIN musei.opera o2 ON o1.nome_opera = o2.nome_opera
WHERE o1.periodo <> o2.periodo
  AND o1.codice_o < o2.codice_o;

-- c) selezionare, per ogni museo che possiede almeno 2 opere dello stesso artista: il nome del
-- museo, il numero di opere complessive in esso esposte e la loro popolarità media
SELECT nome_museo,
       COUNT(codice_o) AS num_opere,
       AVG(popolarita) AS avg_popolarita
FROM musei.museo m
         JOIN musei.esposizione e ON m.codice_m = e.museo
         JOIN musei.opera o ON o.codice_o = e.opera
GROUP BY m.codice_m
HAVING COUNT(DISTINCT artista) < COUNT(artista);

-- d) Selezionare i dati dell'artista che ha eseguito l'opera esposta al museo 'Louvre' avente minore popolarità
SELECT DISTINCT artista
FROM musei.museo m
         JOIN musei.esposizione e ON m.codice_m = e.museo
         JOIN musei.opera o ON o.codice_o = e.opera
WHERE nome_museo = 'Louvre'
  AND popolarita = (SELECT MIN(popolarita)
                    FROM musei.museo m
                             JOIN musei.esposizione e ON m.codice_m = e.museo
                    WHERE nome_museo = 'Louvre');

-- e) All'interno dello schema 'musei', creare una vista 'musei_espos_dipinto' che contenga i dati
-- dei musei che espongono almeno 2 opere di tipologia dipinto. Usando tale vista, per
-- ciascun museo appartenente a tale vista, selezionare: il nome e la citta del museo, il
-- periodo relativo all'opera più vecchia e il periodo relativo all'opera più recente in
-- esposizione in quel museo
CREATE OR REPLACE VIEW musei.musei_espos_dipinto AS
SELECT m.*
FROM musei.museo m
         JOIN musei.esposizione e ON m.codice_m = e.museo
         JOIN musei.opera o ON o.codice_o = e.opera
WHERE tipologia = 'dipinto'
GROUP BY m.codice_m
HAVING COUNT(*) >= 2;

SELECT nome_museo,
       MIN(periodo) AS min_periodo,
       MAX(periodo) AS max_periodo
FROM musei.musei_espos_dipinto m
         JOIN musei.esposizione e ON m.codice_m = e.museo
         JOIN musei.opera o ON o.codice_o = e.opera
GROUP BY m.nome_museo;










