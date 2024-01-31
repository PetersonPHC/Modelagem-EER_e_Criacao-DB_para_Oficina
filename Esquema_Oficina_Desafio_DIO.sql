-- Criando Banco de Dados e Seu Schema
CREATE DATABASE Desafio_DIO_Oficina;
USE Desafio_DIO_Oficina;

CREATE TABLE Cliente (
    IdCliente CHAR(4) PRIMARY KEY,
    nome VARCHAR(15) NOT NULL,
    CPF CHAR(11) UNIQUE DEFAULT NULL,
    CNPJ CHAR(14) UNIQUE DEFAULT NULL
);

CREATE TABLE Veiculo (
    IdVeiculo INT PRIMARY KEY AUTO_INCREMENT,
    marca VARCHAR(20) NOT NULL,
    modelo VARCHAR(20) NOT NULL,
    cor VARCHAR(20) NOT NULL,
    ano INT(4) NOT NULL,
    proprietario_idCliente CHAR(4),
    
    CONSTRAINT fk_Carro_idCliente FOREIGN KEY (proprietario_idCliente)
        REFERENCES Cliente (IdCliente)
);

CREATE TABLE Mecanico (
    IdMecanico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    CPF CHAR(11) NOT NULL,
    dataDeContratacao DATE NOT NULL
);

CREATE TABLE VeiculoEmConcerto (
    IdentificacaoProtocolo CHAR(10) PRIMARY KEY,
    IdVeiculo INT,
    Proprietario CHAR(4),
    IdMecanico INT,
    defeito VARCHAR(100),
    valorConcerto DECIMAL,
    
    CONSTRAINT fk_concerto_Veiculo FOREIGN KEY (IdVeiculo)
        REFERENCES Veiculo (IdVeiculo),
    CONSTRAINT fk_concerto_Proprietario FOREIGN KEY (Proprietario)
        REFERENCES Cliente (IdCliente),
    CONSTRAINT fk_concerto_Mecanico FOREIGN KEY (IdMecanico)
        REFERENCES Mecanico (IdMecanico)
);

CREATE TABLE Oficina (
    CNPJ CHAR(14) PRIMARY KEY,
    nomeFantasia VARCHAR(45) NOT NULL,
    capacidade INT NOT NULL,
    logradouro VARCHAR(45) NOT NULL,
    mecanicoContratado int,
    ProtocoloConcerto_Veiculo CHar(10),
    
    CONSTRAINT fk_oficina_idMecanico FOREIGN KEY (mecanicoContratado)
        REFERENCES Mecanico (IdMecanico),
    CONSTRAINT fk_oficina_NumProtocolo FOREIGN KEY (ProtocoloConcerto_Veiculo)
        REFERENCES VeiculoEmConcerto (IdentificacaoProtocolo)
);

-- Inserindo Dados para Testes e Permanência do BD

INSERT INTO Cliente (IdCliente, nome, CPF, CNPJ) VALUES
		('C3F9', 'Robert B. J.', '12345678901', NULL),
		('A7Z2', 'Elena N. M.', '98765432109', NULL),
		('P1Q8', 'Oliver P. H.', '11122233344', NULL),
		('R4J7', 'Aria J. R.', NULL, '01234567890123'),
		('X9L2', 'Liam X. P.', '55555555555', NULL);
        
SELECT * FROM Cliente;
        
INSERT INTO Veiculo (marca, modelo, cor, ano, proprietario_idCliente) VALUES
		('Ford', 'Fusion', 'Prata', 2019, 'C3F9'),
		('Chevrolet', 'Onix', 'Vermelho', 2020, 'A7Z2'),
		('Toyota', 'Corolla', 'Preto', 2022, 'P1Q8'),
		('Ford', 'EcoSport', 'Azul', 2018, 'R4J7'),
		('Honda', 'Civic', 'Branco', 2021, 'X9L2'),
		('Chevrolet', 'Onix', 'Preto', 2020, 'C3F9'),
		('Toyota', 'Hilux', 'Prata', 2017, 'A7Z2'),
		('Ford', 'Fiesta', 'Vermelho', 2019, 'P1Q8'),
		('Honda', 'Fit', 'Azul', 2022, 'R4J7'),
		('Chevrolet', 'Cruze', 'Branco', 2018, 'X9L2'),
		('Toyota', 'Rav4', 'Preto', 2020, 'C3F9'),
		('Ford', 'Ka', 'Vermelho', 2021, 'A7Z2'),
		('Honda', 'HR-V', 'Prata', 2017, 'P1Q8');

SELECT * FROM Veiculo;

INSERT INTO Mecanico (nome, CPF, dataDeContratacao) VALUES
		('Carlos A. Silva', '12345678901', '2021-02-15'),
		('Fernanda B. Oliveira', '98765432109', '2020-08-10'),
		('Ricardo C. Santos', '45678901234', '2019-05-22'),
		('Mariana D. Souza', '87654321098', '2022-01-05'),
		('João E. Lima', '34567890123', '2018-11-18');
        
SELECT * FROM Mecanico;
        
INSERT INTO VeiculoEmConcerto (IdentificacaoProtocolo, IdVeiculo, Proprietario, IdMecanico, defeito, valorConcerto) VALUES
		('PC1001', 1, 'C3F9', 2, 'Problema no motor', 500.00),
		('PC1002', 3, 'A7Z2', 4, 'Problema elétrico', 700.00),
		('PC1003', 2, 'P1Q8', 5, 'Freios desgastados', 300.00),
		('PC1004', 4, 'R4J7', 1, 'Problema na transmissão', 1000.00),
		('PC1005', 5, 'X9L2', 3, 'Problema na suspensão', 600.00),
		('PC1006', 6, 'C3F9', 2, 'Problema no motor', 800.00),
		('PC1007', 8, 'A7Z2', 4, 'Problema elétrico', 400.00),
		('PC1008', 7, 'P1Q8', 5, 'Freios desgastados', 900.00),
		('PC1009', 9, 'R4J7', 1, 'Problema na transmissão', 1200.00),
		('PC1010', 10, 'X9L2', 3, 'Problema na suspensão', 550.00),
		('PC1011', 11, 'C3F9', 2, 'Problema no motor', 750.00),
		('PC1012', 13, 'A7Z2', 4, 'Problema elétrico', 350.00),
		('PC1013', 12, 'P1Q8', 5, 'Freios desgastados', 1100.00);

SELECT * FROM Veiculo;

INSERT INTO Oficina (CNPJ, nomeFantasia, capacidade, logradouro, mecanicoContratado, ProtocoloConcerto_Veiculo)  VALUES 
		('12345678901234', 'Oficina do João', 10, 'Rua Principal, 123', 5, 'PC1001');
        
SELECT * FROM Oficina;

-- Query's Pedidas pelo Desafio para Testes no Banco e Treino Lógico

-- 1 -> Recuperações simples com SELECT Statement;
Select * From Cliente, Veiculo Where IdCliente = proprietario_idCliente;

-- 2 -> Filtros com WHERE Statement;
Select * From Cliente, Veiculo Where (IdCliente = proprietario_idCliente) and nome like"R%";
-- 3 -> Crie expressões para gerar atributos derivados;
SELECT 
    C.nome, C.CPF, V.modelo, VEC.defeito, VEC.valorConcerto
FROM
    Cliente C,
    Veiculo V,
    VeiculoEmConcerto VEC
WHERE
    V.proprietario_idCliente = C.IdCliente
        AND VEC.Proprietario = C.IdCliente;
        
-- 4 -> Defina ordenações dos dados com ORDER BY;
SELECT * FROM Cliente ORDER BY nome DESC;

-- 5 -> Condições de filtros aos grupos – HAVING Statement;
SELECT 
    C.IdCliente,
    C.nome,
    C.CPF,
    COUNT(V.IdVeiculo) AS QuantidadeVeiculos
FROM
    Cliente C
        JOIN
    Veiculo V ON C.IdCliente = V.proprietario_idCliente
GROUP BY C.IdCliente
HAVING QuantidadeVeiculos >= 2;

-- 6 -> Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;

SELECT 
    VEC.Proprietario AS 'Codigo Do Proprietário',
    C.nome AS 'Nome Do Cliente',
    SubQuery.QtdVeiculoCliente AS 'Quantidade De Veiculos do Cliente',
    SUM(VEC.valorConcerto) AS 'Valor Total Do Concerto'
FROM
    (VeiculoEmConcerto VEC
    JOIN (SELECT proprietario_idCliente,
				 COUNT(proprietario_idCliente) AS QtdVeiculoCliente
		  FROM
				 Veiculo JOIN Cliente ON IdCliente = proprietario_idCliente
		  GROUP BY IdCliente) AS SubQuery ON VEC.Proprietario = SubQuery.proprietario_idCliente
	)
	JOIN Cliente C ON C.IdCliente = VEC.proprietario
GROUP BY VEC.Proprietario;