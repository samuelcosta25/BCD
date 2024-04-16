-- Avaliação Somativa

--DDL

CREATE DATABASE SA05_SamuelCosta; -- Criação do banco de dados

--1
CREATE TABLE IF NOT EXISTS Clientes ( -- Criação da tabela Clientes
    id SERIAL PRIMARY KEY,
    nome_cliente VARCHAR(50) NOT NULL,
    sobrenome_cliente VARCHAR(50),
    email_cliente VARCHAR(50) UNIQUE
);

--2
CREATE TABLE IF NOT EXISTS Pedidos ( -- Criação da tabela Pedidos
    id SERIAL PRIMARY KEY,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id),
    data_pedido DATE NOT NULL,
    total INT NOT NULL
);

--3
CREATE TABLE IF NOT EXISTS Produtos ( -- Criação da tabela Produtos
    id SERIAL PRIMARY KEY,
    nome_produto VARCHAR(50) NOT NULL,
    descricao_produto VARCHAR(50) NOT NULL,
    preco_produto INT NOT NULL,
    CONSTRAINT validar_preco CHECK (preco_produto > 0)
);

--4
CREATE TABLE IF NOT EXISTS Categorias ( -- Criação da tabela Categorias
    id SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL
);

--5
CREATE TABLE IF NOT EXISTS Pedidos_Produtos ( --Criação da tabela Pedidos-Produtos
    id_pedido INT,
    id_produto INT,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id)
);

--6
CREATE TABLE IF NOT EXISTS Produtos_Categorias ( --Criação da tabela Produtos_Categorias
    id_produto INT,
    id_categoria INT,
    PRIMARY KEY (id_produto, id_categoria),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id),
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id)
);

--7
CREATE TABLE IF NOT EXISTS Empregados ( --Criação da tabela Empregados
    id SERIAL PRIMARY KEY,
    nome_empregado VARCHAR(50) NOT NULL,
    sobrenome_empregado VARCHAR(50) NOT NULL,
    cargo_empregado VARCHAR(25) NOT NULL,
    CONSTRAINT validar_cargo CHECK (cargo_empregado IN ('Gerente', 'Supervisor', 'Vendedor', 'Consultor', 'Auxiliar'))
);

--8
CREATE TABLE IF NOT EXISTS Vendas ( --Criação da tabela Vendas
    id SERIAL PRIMARY KEY,
    id_produto INT NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES Produtos(id),
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id),
    data_venda DATE NOT NULL,
    quantidade INT NOT NULL
);

--9
    --1
ALTER TABLE Clientes --Adicionar a tabela Clientes a Cloluna Telefone.
ADD Telefone VARCHAR(20);

    --2
ALTER TABLE Produtos -- Remover propriedade NOT NULL da descrição do produto
ALTER COLUMN descricao_produto TYPE VARCHAR(50);

    --3
ALTER TABLE Pedidos -- Remover chave estrangeira id_cliente da tabela pedidos
DROP CONSTRAINT pedidos_id_cliente_fkey;

    --4
    ALTER TABLE Empregados
    RENAME TO Funcionarios;

--DML

--1
INSERT INTO Clientes (id, nome_cliente, sobrenome_cliente, email_cliente) VALUES -- Adicionar valores a tabela Clientes
(1, 'Ana', 'Silva', 'ana.silva@gmail.com'), 
(2, 'Carlos', 'Oliveira','carlos.oliveira@gmail.com'), 
(3, 'Patrícia', 'Santos','patricia.santos@gmail.com'),
(4, 'André', 'Martins','andre.martins@gmail.com'), 
(5, 'Mariana', 'Costa','mariana.costa@gmail.com');

--2
INSERT INTO Pedidos (id_cliente, data_pedido, total) VALUES --adiconar 10 pedidos associando aos clientes
(1, '2024-04-15', 100), 
(4, '2024-04-15', 150), 
(1, '2024-04-14', 75),   
(4, '2024-04-14', 200),  
(1, '2024-04-13', 120),  
(2, '2024-04-13', 90),   
(2, '2024-04-12', 180),  
(3, '2024-04-12', 220),  
(5, '2024-04-11', 130),   
(5, '2024-04-11', 250); 

--3
INSERT INTO Produtos (nome_produto, descricao_produto, preco_produto)
VALUES
    ('Camiseta', 'Camiseta de algodão', 2000),
    ('Calça Jeans', 'Calça jeans masculina', 3500),
    ('Tênis', 'Tênis esportivo', 5000),
    ('Jaqueta', 'Jaqueta de couro', 8000),
    ('Boné', 'Boné de baseball', 1500),
    ('Saia', 'Saia midi', 2500),
    ('Sapato', 'Sapato social', 6000),
    ('Óculos de Sol', 'Óculos de sol polarizado', 3000),
    ('Relógio', 'Relógio analógico', 7000),
    ('Bolsa', 'Bolsa feminina', 4500),
    ('Cinto', 'Cinto de couro', 2000),
    ('Mochila', 'Mochila escolar', 4000),
    ('Chapéu', 'Chapéu de palha', 1800),
    ('Blusa', 'Blusa de manga longa', 3000),
    ('Shorts', 'Shorts jeans', 2200);



