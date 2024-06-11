-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Clientes (
CNH Varchar(16) Not Null PRIMARY KEY,
Telefone Varchar(15) Not Null,
Nome Varchar(40) Not Null,
Cartao Varchar(16) Not Null
);

CREATE TABLE Carro (
Placa Varchar(10) Not Null PRIMARY KEY,
Ano Int Not Null,
Modelo Varchar(25) Not Null,
CNH Varchar(16) Not Null,
Numero_Ag Int Not Null,
FOREIGN KEY(CNH) REFERENCES Clientes (CNH)
);

CREATE TABLE Agencia (
Numero_Ag Int Not Null PRIMARY KEY,
Contato Varchar(15) Not Null,
Endereco Varchar(25) Not Null
);

ALTER TABLE Carro ADD FOREIGN KEY(Numero_Ag) REFERENCES Agencia (Numero_Ag);
