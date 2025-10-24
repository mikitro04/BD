SET search_path TO prodotti;

--a
SELECT PRODOTTO.codP, PRODOTTO.nome FROM PRODOTTO
JOIN MAGAZZINO ON MAGAZZINO.prodotto = PRODOTTO.codP
JOIN INVENTARIO ON INVENTARIO.magazzino = MAGAZZINO.codM
WHERE MAGAZZINO.indirizzo LIKE 'Via Giove%' 
    AND INVENTARIO.prezzo < 50.00
;

--b
SELECT INVENTARIO.prodotto, PRODOTTO.nome, INVENTARIO.quantita FROM INVENTARIO
JOIN PRODOTTO ON PRODOTTO.codP = INVENTARIO.prodotto
WHERE INVENTARIO.magazzino LIKE '%M0%'
ORDER BY INVENTARIO.prezzo;

--c
SELECT DISTINCT (i1.magazzino, i2.magazzino) FROM INVENTARIO as i1
JOIN INVENTARIO AS i2 ON i1.prodotto = i2.prodotto AND i1.magazzino > i2.magazzino
JOIN PRODOTTO ON i1.prodotto = PRODOTTO.codP
WHERE PRODOTTO.categoria <> 'alimentari';

--d
SELECT MAGAZZINO.* FROM MAGAZZINO AS m
JOIN INVENTARIO AS i ON i.magazzino = m.codM
JOIN PRODOTTO AS p ON i.prodotto = p.codP
WHERE p.nome IN ('biscotti', 'frigo', 'forno') AND i.quantita > 20;

--e
SELECT DISTINCT i.magazzino, p.categoria FROM INVENTARIO AS i
JOIN PRODOTTO AS p ON i.prodotto = p.codP
WHERE i.prezzo BETWEEN 50 AND 500
ORDER BY p.categoria, i.magazzino DESC;