--adicionar comentarios

ALTER TABLE Carro ALTER COLUMN CNH DROP NOT NULL;
ALTER TABLE Carro ADD Data_Aluguel DATE;

CREATE TABLE Funcionarios (
    Funcionario_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
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

SELECT DISTINCT Clientes.* FROM Clientes 
JOIN Carro ON Clientes.CNH = Carro.CNH 
WHERE Carro.Data_Aluguel >= CURRENT_DATE - INTERVAL '3 MONTH';

SELECT * FROM Funcionarios
WHERE Numero_Ag = '7';

SELECT * FROM Pagamentos
WHERE CNH= '1234567890123456';

SELECT Carro.* FROM Carro
JOIN Manutencao ON Carro.Placa = Manutencao.Placa;

SELECT Clientes.* FROM Clientes
WHERE EXISTS (
    SELECT 1
    FROM Carro
    WHERE Carro.CNH = Clientes.CNH
    GROUP BY Carro.CNH
    HAVING COUNT(*) > 1
);

--revisar
SELECT CA.*
FROM Carro CA
JOIN Clientes CL ON CA.CNH = CL.CNH
JOIN Funcionarios F ON F.Cidade = SPLIT_PART(CL.Endereco, ',', 1) -- assumindo que 'Endereco' contém a cidade
WHERE F.Funcionario_ID = X;

