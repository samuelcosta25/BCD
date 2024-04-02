CREATE DATABASE samuelCostaBancoSQL; --Criando banco de dados

-- Exercicio 1

SELECT * FROM samuelCostaBancoSQL; --Selecionando banco de dados

 CREATE TABLE Fornecedor( --Criando tabela
Fcodigo INT NOT NULL PRIMARY KEY,
Fnome VARCHAR(30) NOT NULL,
Status INT,
Cidade VARCHAR (30)
);

CREATE TABLE Peca( --Criando tabela
Pcodigo INT NOT NULL PRIMARY KEY,
Pnome VARCHAR(30) NOT NULL,
Cor VARCHAR(30) NOT NULL,
Peso INT NOT NULL,
Cidade VARCHAR (30) NOT NULL
);

CREATE TABLE Instituicao( --Criando tabela
Icodigo INT NOT NULL PRIMARY KEY, 
nome VARCHAR(30) NOT NULL
);

CREATE TABLE Projeto( --Criando tabela
PRcodigo INT NOT NULL PRIMARY KEY,
Pnome VARCHAR(30) NOT NULL,
Cidade VARCHAR (30),
Icodigo INT NOT NULL,
FOREIGN KEY (Icodigo) REFERENCES Instituicao -- Caso o nome da variavel na tabela de destino seja diferente da tabela de referencia seria necessário referenciar da seguinte forma: FOREIGN KEY (NomeLocal) REFERENCES Instituicao (Icodigo)
);

CREATE TABLE Fornecimento( --Criando tabela
Fcodigo INT NOT NULL,
FOREIGN KEY (Fcodigo) REFERENCES Fornecedor, -- Caso o nome da variavel na tabela de destino seja diferente da tabela de referencia seria necessário referenciar da seguinte forma: FOREIGN KEY (NomeLocal) REFERENCES Fornecedor (Fcodigo)

Pcodigo INT NOT NULL,
FOREIGN KEY (Pcodigo) REFERENCES Peca, -- Caso o nome da variavel na tabela de destino seja diferente da tabela de referencia seria necessário referenciar da seguinte forma: FOREIGN KEY (NomeLocal) REFERENCES Peca (Pcodigo)

PRcodigo INT NOT NULL,
FOREIGN KEY (PRcodigo) REFERENCES Projeto, -- Caso o nome da variavel na tabela de destino seja diferente da tabela de referencia seria necessário referenciar da seguinte forma: FOREIGN KEY (NomeLocal) REFERENCES Projeto (PRcodigo)

Quantidade INT NOT NULL
);

ALTER TABLE Fornecedor ALTER COLUMN Status SET DEFAULT 'ATIVO';

--Exercicio 2

SELECT * from Fornecedor;

ALTER TABLE Fornecedor 

DROP TABLE Instituicao;