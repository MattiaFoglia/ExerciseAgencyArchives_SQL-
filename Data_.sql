drop database if exists quintaa_aziendacommerciale;
create database if not exists quintaa_aziendacommerciale;
use quintaa_aziendacommerciale;

CREATE TABLE Categorie(
Id_Categoria INT,
Descrizione VARCHAR(60),
CONSTRAINT PrimaryKey PRIMARY KEY(Id_Categoria)
);

CREATE TABLE Clienti(
ID_Cliente VARCHAR(5),
Ragione_Sociale VARCHAR(40) NOT NULL,
Indirizzo VARCHAR(60),
Citta VARCHAR(15),
Provincia VARCHAR(15),
CAP VARCHAR(10),
N_Telefono VARCHAR(24),
CONSTRAINT PrimaryKey PRIMARY KEY(ID_Cliente)
);

CREATE TABLE Fornitori(
Id_Fornitore INT,
Ragione_Sociale VARCHAR(40) NOT NULL,
Indirizzo VARCHAR(60),
Citta VARCHAR(15),
Provincia VARCHAR(15),
CAP VARCHAR(10),
N_Telefono VARCHAR(24),
CONSTRAINT PrimaryKey PRIMARY KEY(Id_Fornitore)
);

CREATE TABLE Ordini(
Id_Ordine INT,
Id_Cliente VARCHAR(5),
Data_Ricezione DATE,
Data_Evasione DATE,
Spese_Trasporto DOUBLE,
costo_unitario double,
CONSTRAINT PrimaryKey PRIMARY KEY(Id_Ordine),
CONSTRAINT ClientiOrdini FOREIGN KEY(Id_Cliente)
REFERENCES Clienti(ID_Cliente)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Prodotti(
Id_Prodotto INT,
Descrizione VARCHAR(40) NOT NULL,
Id_Fornitore INT,
Id_Categoria INT,
Prezzo_Acquisto DOUBLE,
Prezzo_Vendita DOUBLE,
Giacenza INT,
CONSTRAINT PrimaryKey PRIMARY KEY(Id_Prodotto),
CONSTRAINT CategorieProdotti FOREIGN KEY(Id_Categoria)
REFERENCES Categorie(Id_Categoria)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FornitoriProdotti FOREIGN KEY(Id_Fornitore)
REFERENCES Fornitori(Id_Fornitore)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Dettaglio_Ordini(
Id_Ordine INT,
Id_Prodotto INT NOT NULL,
Quantita INT NOT NULL,
CONSTRAINT PrimaryKey PRIMARY KEY(Id_Ordine,Id_Prodotto),
CONSTRAINT OrdiniDettaglio_Ordini FOREIGN KEY(Id_Ordine)
REFERENCES Ordini(Id_Ordine),
CONSTRAINT ProdottiDettaglio_Ordini FOREIGN KEY(Id_Prodotto)
REFERENCES Prodotti(Id_Prodotto)
);

insert into categorie(Id_Categoria, Descrizione)
values (1, 'Sanitari'),
(2, 'Arredamento'),
(3, 'Elettronica');

insert into clienti(Id_Cliente, Ragione_Sociale, Indirizzo, Citta, Provincia, CAP, N_Telefono)
values (1, 'S.S. Mario Rossi', 'Via Roma', 'Firenze', 'Fi', '50100', '055 8489324'),
(2, 'S.N.C. Lisi Alfredo e figli', 'Via della stazione', 'Firenze', 'Fi','50100' , '055 848009'),
(3, 'S.A.S Luigi Verdi', 'Via Cassia', 'Roma', 'Roma', '00100', '066 7812345');
select * from clienti;

insert into fornitori(id_fornitore, ragione_sociale, indirizzo, citta, provincia, cap, n_telefono)
values (1, 'S.P.A. Lorenzo Malavolti', 'Via degli arcipressi','Firenze', 'Fi', '50100', '331 7441472'),
(2, 'S.P.A. Francesco Toccafondi', 'via Pietro Toselli', 'Firenze', 'Fi', '50100', '333 7958692'),
(3, 'S.R.L. LavacchiniCalzature', 'Via Trieste', 'Firenze', '50100', 'Fi', '342 0629123');

insert into ordini(id_ordine, id_cliente, data_ricezione, data_evasione, spese_trasporto, costo_unitario)
values(1, 1, '2019-12-1', '2019-12-4', 400, 300),
(2, 1, '2019-11-25', '2019-11-30', 1500, 400),
(3, 3, '2019-02-12', '2019-02-23', 500, 500);
select * from ordini;

insert into prodotti(id_prodotto, descrizione, id_fornitore, id_categoria, prezzo_acquisto, prezzo_vendita, giacenza)
values (1, 'P01', 1, 2, 1000, 1500, 30),
(2, 'P41', 2, 2, 500, 1000, 20),
(3, 'P35', 3, 1, 2000, 3000, 30);

insert into dettaglio_ordini(id_ordine, id_prodotto, quantita)
values(1, 1, 2),
(2, 1, 1),
(3, 3, 3);
select * from dettaglio_ordini;