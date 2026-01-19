-- Nome: Alessio Giuseppe Muggittu


-- Selezionare codice, indirizzo, tipo e zona degli immobili venduti prima del primo Gennaio 2005 il cui prezzo di vendita sia inferiore al prezzo richiesto.

select immobile.codiceI, immobile.indirizzo, immobile.tipo, immobile.zona 
from immobili.immobile join immobili.vendita on immobile.codiceI = vendita.codI
where vendita.data < '2005-01-01' and immobile.prezzo_richiesto > vendita.prezzo;


-- Selezionare indirizzo, prezzo richiesto e data delle visite effettuate da agenti di 'CambiaCasa', ordinando i risultati per data, dalla più recente alla meno recente.

select distinct immobile.indirizzo, immobile.prezzo_richiesto, visita.data
from immobili.immobile join immobili.visita on immobile.codiceI = visita.codI
join immobili.agente on visita.codA = agente.codiceA
where agente.agenzia like 'CambiaCasa'
order by visita.data desc;


-- Selezionare il nome delle agenzie i cui agenti abbiano effettuato complessivamente almeno 3 visite dopo il primo Gennaio 2004.

select agente.agenzia
from immobili.agente join immobili.visita on agente.codiceA = visita.codA
where visita.data > '2004-01-01'
group by agente.agenzia having count(*) >= 3;


-- Selezionare i dati degli agenti di 'CambiaCasa' che abbiano effettuato almeno due visite dopo il primo Gennaio 2003, ma nessuna vendita dopo il primo Gennaio 2005.

select agente.*
from immobili.agente join immobili.visita on agente.codiceA = visita.codA
where agente.agenzia like 'CambiaCasa' and visita.data > '2003-01-01' and agente.codiceA not in 
(
	select vendita.codA from immobili.vendita
	where vendita.data > '2005-01-01'
)
group by agente.codiceA having count(*) >= 2;


-- All'interno dello schema "immobili", creare una vista "immobile_invenduto" che contenga i dati di tutti gli immobili che non sono stati ancora venduti.
-- Usando tale vista, per ciascun immobile ancora invenduto (compresi quelli che non sono mai stati visitati), determinare il numero di volte in cui è stato visitato.

create view immobili.immobile_invenduto as
select immobile.* from immobili.immobile
where immobile.codiceI not in
(
	select vendita.codI from immobili.vendita
);

select iv.codiceI, count(visita.codI)
from immobili.immobile_invenduto as iv left join immobili.visita on iv.codiceI = visita.codI
group by iv.codiceI;