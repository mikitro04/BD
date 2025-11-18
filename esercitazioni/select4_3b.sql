--h) Selezionare il codice di quei dipendenti che partecipano ai progetti con almeno tre ruoli distinti.
SELECT pa.dipendente FROM PARTECIPA AS pa
GROUP BY pa.dipendente
HAVING COUNT(DISTINCT ruolo) >= 3
;

--i) Selezionare, per ogni dipendente e per ogni ruolo che ricopre, il numero di progetti in cui ricopre quel ruolo.
SELECT pa.dipendente, pa.ruolo, COUNT(pa.progetto) FROM PARTECIPA as pa
GROUP BY pa.dipendente, pa.ruolo;

--j) Selezionare, per ogni anno, il budget complessivo destinato ai progetti di quell'anno.
SELECT pr.anno, SUM(pr.budget) FROM PROGETTO AS pr
GROUP BY pr.anno;

--k) Selezionare, per ogni progetto a cui partecipano dipendenti per un numero complessivo di mesi superiore a 15, il numero distinto di ruoli 
   -- che partecipano a quel progetto.
SELECT pa.progetto, COUNT(DISTINCT pa.ruolo) FROM PARTECIPA AS pa
GROUP BY pa.progetto
HAVING SUM(pa.mesi) > 15; /*Ordine delle clausole: SELECT > GROUP BY > HAVING*/

--l) Selezionare, per ogni progetto, il numero complessivo di mesi destinati ad ogni ruolo (tra quelli che partecipano al progetto).
SELECT pa.progetto, pa.ruolo, SUM(pa.mesi) FROM PARTECIPA AS pa
GROUP BY pa.progetto, pa.ruolo;

--m) Selezionare il progetto a cui sono destinati complessivamente più mesi.
SELECT pa.progetto FROM PARTECIPA AS pa
GROUP BY pa.progetto
HAVING SUM(pa.mesi) >= ALL (
    SELECT SUM(mesi) FROM PARTECIPA GROUP BY progetto
);

--n) Selezionare i dati dei progetti cui partecipano almeno tre dipendenti che abitano a Cagliari o a Sassari.
SELECT pr.* FROM PROGETTO AS pr
WHERE pr.codP IN (
    SELECT pa.progetto FROM PARTECIPA AS pa
    JOIN DIPENDENTE AS d ON d.codD = pa.dipendente
    WHERE d.citta IN ('Cagliari', 'Sassari')
    GROUP BY pa.progetto
    HAVING COUNT(pa.dipendente) >= 3
);
