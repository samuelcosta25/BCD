-- Aula 3 / Atividade somativa 1


-- Criação de novas tabelas que serão necessárias para a realização de consultas
CREATE TABLE Funcionarios (
    Funcionario_ID INT NOT NULL PRIMARY KEY,
    Nome VARCHAR(40) NOT NULL,
    Telefone VARCHAR(15),
    Endereco VARCHAR(50),
    Cidade VARCHAR(30),
    Numero_Ag INT NOT NULL,
    FOREIGN KEY (Numero_Ag) REFERENCES Agencia (Numero_Ag)
);

CREATE TABLE Pagamentos (
    Pagamento_ID SERIAL PRIMARY KEY,
    CNH VARCHAR(16) NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    Data_Pagamento DATE NOT NULL,
    FOREIGN KEY (CNH) REFERENCES Clientes (CNH)
);

CREATE TABLE Manutencao (
    Manutencao_ID SERIAL PRIMARY KEY,
    Placa VARCHAR(10) NOT NULL,
    Data_Manutencao DATE NOT NULL,
    Descricao VARCHAR(255),
    FOREIGN KEY (Placa) REFERENCES Carro (Placa)
);
 
-- Comandos para realização de consultas:

--1. **SELECT**

-- Selecione todos os carros disponíveis na locadora.
SELECT * FROM Carro WHERE CNH IS NULL;

-- Liste todos os clientes que alugaram um carro nos últimos 3 meses.
SELECT DISTINCT Clientes.* FROM Clientes 
JOIN Carro ON Clientes.CNH = Carro.CNH 
WHERE Carro.Data_Aluguel >= CURRENT_DATE - INTERVAL '3 MONTH';

-- Mostre os funcionários que estão cadastrados na agência "X". Foi utilizada a agencia "7" para o teste.
SELECT * FROM Funcionarios
WHERE Numero_Ag = '7';

-- Exiba os pagamentos realizados por um cliente específico. Foi utilizado o cliente de CNH = "1234567890123456" para o teste
SELECT * FROM Pagamentos
WHERE CNH= '1234567890123456';

-- Liste os carros que precisam de manutenção.
SELECT Carro.* FROM Carro
JOIN Manutencao ON Carro.Placa = Manutencao.Placa;

-- Escreva uma consulta para encontrar os clientes que alugaram carros mais de uma vez usando uma subconsulta correlacionada.
SELECT Clientes.* FROM Clientes
WHERE EXISTS (
    SELECT 1
    FROM Carro
    WHERE Carro.CNH = Clientes.CNH
    GROUP BY Carro.CNH
    HAVING COUNT(*) > 1
);

-- Identifique os carros alugados por clientes que vivem na mesma cidade que um determinado funcionário. Foi utilizado o funcionario "Pedro Almeida" que mora em São Paulo para o teste.
SELECT Carro.* FROM Carro
JOIN Clientes ON Carro.CNH = Clientes.CNH
JOIN Funcionarios ON Clientes.Cidade = Funcionarios.Cidade
WHERE Funcionarios.Nome = 'Pedro Almeida';

--2. **UPDATE**

-- Alterações necessárias nas tabelas já existentes para a realização de consultas
ALTER TABLE Clientes ADD Data_Retorno DATE;
ALTER TABLE Carro ADD COLUMN Preco_Aluguel DECIMAL(10, 2);
UPDATE Carro SET Preco_Aluguel = 200.00;
ALTER TABLE Carro ADD Status_Manutencao VARCHAR(60);
ALTER TABLE Manutencao ADD Status VARCHAR(60);
UPDATE Manutencao SET Status = 'Em andamento'; 

-- Atualize o preço do aluguel de todos os carros da marca "Toyota".
UPDATE Carro SET Preco_Aluguel = 250.00
WHERE Modelo LIKE '%Toyota%';

-- Modifique a data de retorno de um carro alugado por um cliente.
UPDATE Clientes Set Data_Retorno = '2024-05-20'
WHERE Clientes.CNH = 'CNH0002';

-- Atualize o status de manutenção de um carro após ter sido consertado.
UPDATE Carro Set Status_Manutencao = 'Concluído'
WHERE Carro.Placa = 'HHH0008';
UPDATE Manutencao SET Status = 'Concluído'
WHERE Placa = 'FFF0006' AND Status = 'Em andamento';

--3. **ALTER TABLE**

-- Adicione uma nova coluna à tabela de Carro para armazenar o status de disponibilidade.
ALTER TABLE Carro ADD Disponibilidade VARCHAR(16);

-- Modifique o tipo de dados de uma coluna na tabela de Pagamento.
ALTER TABLE Pagamentos
ALTER COLUMN Valor TYPE NUMERIC(12, 2);

-- Remova uma coluna não utilizada da tabela de Cliente.
ALTER TABLE Clientes
DROP COLUMN Cartao;

--4. **JOIN**

-- Criação da tabela Aluguel, necessária para as consultas solicitadas
CREATE TABLE Aluguel (
    ID SERIAL PRIMARY KEY,
    CNH VARCHAR(16) NOT NULL,
    Placa VARCHAR(10) NOT NULL,
    Data_Aluguel DATE NOT NULL,
    FOREIGN KEY (CNH) REFERENCES Clientes (CNH),
    FOREIGN KEY (Placa) REFERENCES Carro (Placa)
);

-- Criação da tabela Feedback, necessária para as consultas solicitadas
CREATE TABLE Feedback (
    ID SERIAL PRIMARY KEY,
    ID_Aluguel INT NOT NULL,
    Comentario VARCHAR(150),
    FOREIGN KEY (ID_Aluguel) REFERENCES Aluguel (ID)
);

-- Liste todos os alugueis de carros, incluindo o nome do cliente, modelo do carro e data de aluguel.
SELECT Clientes.Nome, Carro.Modelo, Aluguel.Data_Aluguel
FROM Aluguel
JOIN Clientes ON Aluguel.CNH = Clientes.CNH
JOIN Carro ON Aluguel.Placa = Carro.Placa;

-- Mostre os pagamentos feitos por clientes, incluindo o nome do cliente e o valor pago.
SELECT Pagamentos.Pagamento_ID, Clientes.Nome, Pagamentos.Valor
FROM Pagamentos
JOIN Clientes ON Pagamentos.CNH = Clientes.CNH;

-- Exiba os feedbacks deixados pelos clientes, juntamente com o nome do cliente e omodelo do carro alugado.
SELECT Clientes.Nome, Carro.Modelo, Feedback.Comentario
FROM Feedback
JOIN Aluguel ON Feedback.ID_Aluguel = Aluguel.ID
JOIN Clientes ON Aluguel.CNH = Clientes.CNH
JOIN Carro ON Aluguel.Placa = Carro.Placa;

-- **INNER JOIN**

-- Liste os carros disponíveis na agência "X". Foi utilizado a agencia 5 como exemplo no teste.
SELECT Carro.Placa, Carro.Modelo, Carro.Ano
FROM Carro
LEFT JOIN Aluguel ON Carro.Placa = Aluguel.Placa
WHERE Carro.Numero_Ag = 5 AND Aluguel.ID IS NULL;

-- Mostre todos os alugueis de carros feitos por clientes que estão na cidade "Y". Foi utilizado Rio de Janeiro no exemplo no teste.
SELECT Aluguel.ID, Clientes.Nome AS Nome_Cliente, Carro.Modelo AS Modelo_Carro, Aluguel.Data_Aluguel
FROM Aluguel
INNER JOIN Clientes ON Aluguel.CNH = Clientes.CNH
INNER JOIN Carro ON Aluguel.Placa = Carro.Placa
WHERE Clientes.Cidade = 'Rio de Janeiro';

-- Exiba os funcionários que trabalham em agências que têm pelo menos um carro da marca "Toyota".
SELECT DISTINCT Funcionarios.*
FROM Funcionarios
INNER JOIN Agencia ON Funcionarios.Numero_Ag = Agencia.Numero_Ag
INNER JOIN Carro ON Agencia.Numero_Ag = Carro.Numero_Ag
WHERE Carro.Modelo LIKE '%Toyota%';

-- **LEFT JOIN**

--Alterações necessárias
ALTER TABLE Feedback
ADD COLUMN Placa VARCHAR(15);
UPDATE Feedback
SET Placa = Aluguel.Placa
FROM Aluguel
WHERE Feedback.ID_Aluguel = Aluguel.ID;

-- Liste todos os carros e, se disponível, mostre o feedback associado a cada carro.
SELECT Carro.Placa, Carro.Modelo, Carro.Ano, Feedback.Comentario
FROM Carro
LEFT JOIN Manutencao ON Carro.Placa = Manutencao.Placa
LEFT JOIN Feedback ON Manutencao.Placa = Feedback.Placa;

-- Mostre todos os clientes, incluindo aqueles que ainda não alugaram nenhum carro.
SELECT Clientes.*, Aluguel.ID
FROM Clientes
LEFT JOIN Aluguel ON Clientes.CNH = Aluguel.CNH;

-- Exiba todas as agências e, se houver, o número total de carros disponíveis em cada agência.
SELECT Agencia.*, COUNT(Carro.Placa) AS Total_Carros_Disponiveis
FROM Agencia
LEFT JOIN Carro ON Agencia.Numero_Ag = Carro.Numero_Ag
GROUP BY Agencia.Numero_Ag, Agencia.Contato, Agencia.Endereco;

