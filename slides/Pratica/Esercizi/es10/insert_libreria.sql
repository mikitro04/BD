
-- Popolamento della tabella LIBRO
INSERT INTO libreria.libro (titolo, autore, genere, prezzo) VALUES
('Il nome della rosa', 'Umberto Eco', 'romanzo', 12.99),
('Sapiens', 'Yuval Noah Harari', 'saggio', 18.50),
('Divina Commedia', 'Dante Alighieri', 'poesia', 10.00),
('Clean Code', 'Robert C. Martin', 'manuale', 25.99),
('L’amico ritrovato', 'Fred Uhlman', 'romanzo', 8.50);

-- Popolamento della tabella UTENTE
INSERT INTO libreria.utente (nome, cognome, dataNascita, tipoUtente) VALUES
('Mario', 'Rossi', '2000-05-15', 'studente'),
('Giulia', 'Bianchi', '1985-07-20', 'docente'),
('Luca', 'Verdi', '1995-11-30', 'esterno'),
('Anna', 'Neri', '2003-03-08', 'studente'),
('Sara', 'Fontana', '1978-09-25', 'docente');

-- Popolamento della tabella PRESTITO
INSERT INTO libreria.prestito (libro, utente, dataInizio, dataFine) VALUES
(1, 1, '2023-09-01', '2023-09-15'),
(2, 2, '2023-08-10', '2023-08-30'),
(3, 3, '2023-09-05', '2023-09-20'),
(4, 4, '2023-09-01', '2023-09-10'),
(1, 5, '2023-07-15', '2023-07-25'),
(2, 3, '2023-06-01', '2023-06-15'),
(5, 1, '2023-08-01', '2023-08-10'),
(4, 2, '2023-05-01', '2023-05-20'),
(1, 3, '2023-09-15', '2023-09-30');
