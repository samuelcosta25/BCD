--Exercicio 1

-- DDL

CREATE DATABASE DB_SA04_EX1;

--1.
CREATE TABLE Clientes (
    id_clientes SERIAL NOT NULL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

SELECT * FROM Clientes;

--2.
ALTER TABLE Clientes ADD CONSTRAINT email UNIQUE (email); 

--3.
CREATE TABLE Pedidos (
    id_Pedidos SERIAL NOT NULL PRIMARY KEY,
    cliente_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes (id_clientes),
    data_pedido DATE NOT NULL,
    total INT NOT NULL
);

SELECT * FROM Pedidos;

--4.
ALTER TABLE Pedidos ADD CONSTRAINT cliente_existente FOREIGN KEY (cliente_id) REFERENCES Clientes (id_clientes);

--5.
ALTER TABLE Pedidos
ADD Status VARCHAR(20) CHECK (Status IN ('Cancelado', 'Em andamento', 'Finalizado'));

--DML

--1.
INSERT INTO Clientes (nome, sobrenome, email) VALUES ('fulano', 'santos', 'fulano@gmail.com');

INSERT INTO Clientes (nome, sobrenome, email) VALUES ('cicrano', 'silva', 'cicrano@gmail.com');

INSERT INTO Clientes (nome, sobrenome, email) VALUES ('beltrano', 'rocha', 'beltrano@gmail.com');

--2.
INSERT INTO Pedidos (cliente_id, data_pedido, total, Status) VALUES ('1', '2024-02-20', '5', 'Em andamento');

INSERT INTO Pedidos (cliente_id, data_pedido, total, Status) VALUES ('2', '2023-11-05', '10', 'Cancelado');

INSERT INTO Pedidos (cliente_id, data_pedido, total, Status) VALUES ('3', '2020-02-22', '25', 'Finalizado');

INSERT INTO Pedidos (cliente_id, data_pedido, total, Status) VALUES ('2', '2013-01-05', '100', 'Em andamento');

--3.
UPDATE Pedidos SET Total = 30
WHERE id_Pedidos = 1;
 
SELECT * FROM PEDIDOS;

--4.
DELETE FROM Clientes WHERE id_clientes=1;
DELETE FROM Pedidos WHERE cliente_id=1;