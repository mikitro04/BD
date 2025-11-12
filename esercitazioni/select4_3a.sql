--a) Selezionare il budget più alto, più basso, e medio dei progetti.
SELECT MAX(budget), MIN(budget), AVG(budget) FROM PROGETTO;

--b) Selezionare il nome del progetto col budget più elevato.
SELECT nome FROM PROGETTO
ORDER BY budget DESC
LIMIT 1;

--c) Selezionare il nome dei progetti il cui budget è superiore alla media.
SELECT nome FROM PROGETTO
WHERE budget > (SELECT AVG(budget) FROM PROGETTO);

--d) Selezionare i dati dei progetti cui partecipano almeno un dipendente di Cagliari e un dipendente di Sassari.
SELECT pr.* FROM PROGETTO AS pr
JOIN PARTECIPA AS pa ON pa.progetto = pr.codP
JOIN DIPENDENTE AS d ON pa.dipendente = d.codD
WHERE d.citta IN ('Cagliari', 'Sassari')
GROUP BY pr.codP
HAVING (COUNT(DISTINCT d.citta) = 2);

--e) Selezionare il cognome e il nome dei dipendenti che non partecipano a nessun progetto iniziato prima del 2005.
SELECT d.cognome, d.nome FROM DIPENDENTE AS d
WHERE NOT EXISTS (
    SELECT * FROM PARTECIPA AS pa
    JOIN PROGETTO AS pr ON pr.codP = pa.progetto
    WHERE d.codD = pa.dipendente 
    AND pr.anno < 2005
);

--f) Selezionare il cognome e il nome dei dipendenti che partecipano esclusivamente a progetti del 2005.
SELECT DISTINCT d.cognome, d.nome FROM DIPENDENTE AS d
JOIN PARTECIPA AS pa ON pa.dipendente = d.codD
JOIN PROGETTO AS pr ON pr.codP = pa.progetto
WHERE pr.anno = 2005 
AND NOT EXISTS (
    SELECT * FROM PARTECIPA AS pa1
    JOIN PROGETTO AS pr1 ON pr1.codP = pa1.progetto
    WHERE pr1.anno <> 2005 
    AND pa1.dipendente = d.codD     --mancava questa riga e mettere px1 anziche' solo px, c'ero molto vicino
);          --TIPS: mettere nelle subquery sempre nomi univoci rispetto alla query esterna

--g) Per ogni dipendente (che ha preso parte ad almeno un progetto), selezionare il codice del progetto in cui egli ha lavorato per il maggior numero di mesi.
SELECT DISTINCT ON (dipendente) pa.progetto FROM PARTECIPA AS pa
ORDER BY pa.dipendente, mesi DESC
/*
    Per leggerla meglio partire da giu'
        1. ORDER BY pa.dipendente, mesi DESC
            semplicemente ordina per dipendente e per mesi in maniera decrescente, quindi a parita' di dipendente guarda il mese
            la tabella risultante sara' D01 su una o piu' righe poi i suoi mesi dal piu' grande al piu' piccolo
        2. DISTINCT ON (dipendente)
            la query restituira' solamente la prima riga che trova con un pa.dipendente, quindi la seconda riga con D01 verra' scartata
        3. SELECT .... pa.progetto FROM PARTECIPA
            una semplice select con il punto 2. dentro
            TIPS: La DISTINCT va sempre dopo SELECT
*/

