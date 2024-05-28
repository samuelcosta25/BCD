-- INSERTS

INSERT INTO Clientes (CNH, Telefone, Nome, Cartao, Cidade)
VALUES 
('CNH0001', '11987654321', 'João Silva', '1234567812345678', 'São Paulo'),
('CNH0002', '21987654321', 'Maria Santos', '2345678923456789', 'Rio de Janeiro'),
('CNH0003', '31987654321', 'Carlos Oliveira', '3456789034567890', 'Belo Horizonte'),
('CNH0004', '41987654321', 'Ana Souza', '4567890145678901', 'Porto Alegre'),
('CNH0005', '51987654321', 'Paulo Lima', '5678901256789012', 'Curitiba'),
('CNH0006', '61987654321', 'Luciana Pereira', '6789012367890123', 'Salvador'),
('CNH0007', '71987654321', 'Marcos Mendes', '7890123478901234', 'Brasília'),
('CNH0008', '81987654321', 'Fernanda Pinto', '8901234589012345', 'Goiânia'),
('CNH0009', '91987654321', 'Lucas Rodrigues', '9012345690123456', 'Manaus'),
('CNH0010', '10198765432', 'Juliana Alves', '0123456701234567', 'Recife');

INSERT INTO Agencia (Numero_Ag, Contato, Endereco)
VALUES 
(1, '21987654321', 'Av. Brasil, 1000'),
(2, '31987654321', 'Rua da Paz, 200'),
(3, '41987654321', 'Av. Paulista, 3000'),
(4, '51987654321', 'Rua das Flores, 400'),
(5, '61987654321', 'Av. das Américas, 5000'),
(6, '71987654321', 'Rua dos Alfeneiros, 600'),
(7, '81987654321', 'Rua do Sol, 700'),
(8, '91987654321', 'Av. Central, 800'),
(9, '10198765432', 'Rua Nova, 900'),
(10, '11198765432', 'Av. das Palmeiras, 1000');

INSERT INTO Carro (Placa, Ano, Modelo, CNH, Numero_Ag, Data_Aluguel)
VALUES 
('AAA0001', 2010, 'Fiat Uno', 'CNH0001', 1, '2024-05-01'),
('BBB0002', 2011, 'Volkswagen Gol', 'CNH0002', 2, '2024-05-02'),
('CCC0003', 2012, 'Chevrolet Onix', 'CNH0003', 3, '2024-05-03'),
('DDD0004', 2013, 'Ford Ka', 'CNH0004', 4, '2024-05-04'),
('EEE0005', 2014, 'Hyundai HB20', 'CNH0005', 5, '2024-05-05'),
('FFF0006', 2015, 'Renault Sandero', NULL, 6, '2024-05-06'),
('GGG0007', 2016, 'Toyota Corolla', NULL, 7, '2024-05-07'),
('HHH0008', 2017, 'Honda Civic', 'CNH0008', 8, '2024-05-08'),
('III0009', 2018, 'Nissan Kicks', 'CNH0009', 9, '2024-05-09'),
('JJJ0010', 2019, 'Jeep Renegade', 'CNH0010', 10, '2024-05-10');

INSERT INTO Funcionarios (Nome, Telefone, Endereco, Cidade, Numero_Ag)
VALUES 
('Pedro Almeida', '11987654321', 'Rua A, 10', 'São Paulo', 1),
('Sandra Costa', '21987654321', 'Rua B, 20', 'Rio de Janeiro', 2),
('Marcos Mendes', '31987654321', 'Rua C, 30', 'Belo Horizonte', 3),
('Fernanda Pinto', '41987654321', 'Rua D, 40', 'Porto Alegre', 4),
('Lucas Rodrigues', '51987654321', 'Rua E, 50', 'Curitiba', 5),
('Juliana Alves', '61987654321', 'Rua F, 60', 'Salvador', 6),
('Roberto Nunes', '71987654321', 'Rua G, 70', 'Brasília', 7),
('Patrícia Silva', '81987654321', 'Rua H, 80', 'Goiânia', 8),
('Ricardo Torres', '91987654321', 'Rua I, 90', 'Manaus', 9),
('André Souza', '10198765432', 'Rua J, 100', 'Recife', 10);

INSERT INTO Pagamentos (CNH, Valor, Data_Pagamento)
VALUES 
('CNH0001', 100.00, '2024-01-01'),
('CNH0002', 150.00, '2024-01-02'),
('CNH0003', 200.00, '2024-01-03'),
('CNH0004', 250.00, '2024-01-04'),
('CNH0005', 300.00, '2024-01-05'),
('CNH0006', 350.00, '2024-01-06'),
('CNH0007', 400.00, '2024-01-07'),
('CNH0008', 450.00, '2024-01-08'),
('CNH0009', 500.00, '2024-01-09'),
('CNH0010', 550.00, '2024-01-10');

INSERT INTO Manutencao (Placa, Data_Manutencao, Descricao)
VALUES 
('AAA0001', '2024-02-01', 'Troca de óleo'),
('BBB0002', '2024-02-02', 'Revisão geral'),
('CCC0003', '2024-02-03', 'Troca de pneus'),
('DDD0004', '2024-02-04', 'Troca de filtro de ar'),
('EEE0005', '2024-02-05', 'Troca de pastilhas de freio'),
('FFF0006', '2024-02-06', 'Alinhamento e balanceamento'),
('GGG0007', '2024-02-07', 'Substituição de bateria'),
('HHH0008', '2024-02-08', 'Troca de velas'),
('III0009', '2024-02-09', 'Revisão elétrica'),
('JJJ0010', '2024-02-10', 'Troca de amortecedores');

INSERT INTO Aluguel (CNH, Placa, Data_Aluguel) 
VALUES 
('CNH0001', 'AAA0001', '2024-05-01'),
('CNH0002', 'BBB0002', '2024-05-02'),
('CNH0003', 'CCC0003', '2024-05-03'),
('CNH0004', 'DDD0004', '2024-05-04'),
('CNH0005', 'EEE0005', '2024-05-05'),
('CNH0006', 'FFF0006', '2024-05-06'),
('CNH0007', 'GGG0007', '2024-05-07'),
('CNH0008', 'HHH0008', '2024-05-08'),
('CNH0009', 'III0009', '2024-05-09'),
('CNH0010', 'JJJ0010', '2024-05-10');

INSERT INTO Feedback (ID_Aluguel, Comentario)
VALUES 
    (1, 'Ótimo serviço, carro em excelentes condições.'),
    (2, 'Atendimento rápido e eficiente.'),
    (3, 'Carro limpo e confortável.'),
    (4, 'O carro estava com alguns problemas mecânicos.'),
    (5, 'Excelente experiência de aluguel, recomendo!'),
    (6, 'Precisa melhorar a limpeza dos carros.'),
    (7, 'Carro com cheiro de cigarro, desagradável.'),
    (8, 'Atendimento ao cliente deixou a desejar.'),
    (9, 'Problemas com a entrega do carro, atrasou bastante.'),
    (10, 'Excelente carro, mas o processo de aluguel foi confuso.');




