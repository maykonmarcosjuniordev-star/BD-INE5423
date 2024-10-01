-- Ambulatorios: nroa (int), andar (numeric(2)) (não nulo), capacidade (smallint)
CREATE TABLE Ambulatorios (
    nroa int,
    andar numeric(2) NOT NULL,
    capacidade smallint,
    PRIMARY KEY (nroa)
);

-- Medicos: codm (int), nome (varchar(40)) (não nulo), idade (smallint) (não nulo), cidade (varchar(40)), CPF (numeric(11)) (não nulo e único), especialidade (varchar(30)), nroa (int)
CREATE TABLE Medicos (
    codm int,
    nome varchar(40) NOT NULL,
    idade smallint NOT NULL,
    cidade varchar(40),
    CPF numeric(11) NOT NULL UNIQUE,
    especialidade varchar(30),
    nroa int,
    PRIMARY KEY (codm),
    FOREIGN KEY (nroa) REFERENCES Ambulatorios
);

-- Pacientes: codp (int), nome (varchar(40)) (não nulo), idade (smallint) (não nulo), cidade (varchar(40)), CPF (numeric(11)) (não nulo e único), doenca (varchar(40)) (não nulo)
CREATE TABLE Pacientes (
    codp int,
    nome varchar(40),
    idade smallint NOT NULL,
    cidade varchar(40),
    CPF numeric(11) NOT NULL UNIQUE,
    doenca varchar(40) NOT NULL,        
    PRIMARY KEY (codp)
);

-- Funcionarios: codf (int), nome (varchar(40)) (não nulo), idade (smallint) (não nulo), cidade (varchar(40)), CPF (numeric(11)) (não nulo e único), salário (numeric(10)), cargo (varchar(40))

CREATE TABLE Funcionarios (
    codf int,
    nome varchar(40) NOT NULL,
    idade smallint NOT NULL,
    cidade varchar(40),
    CPF numeric(11) NOT NULL UNIQUE,
    salario numeric(10),
    cargo varchar(40),
    PRIMARY KEY (codf)
);

-- Consultas: codm (int), codp (int), data (date), hora (time)
CREATE TABLE Consultas (
    codm int,
    codp int,
    data date,
    hora time,
    PRIMARY KEY (codm, codp, data),
    FOREIGN KEY (codm) REFERENCES Medicos,
    FOREIGN KEY (codp) REFERENCES Pacientes
);

-- 2) Alterar a tabela Funcionarios, removendo o atributo cargo

ALTER TABLE Funcionarios
    DROP COLUMN cargo;

-- 3) Criar um índice para o atributo cidade na tabela Pacientes
CREATE INDEX idx_cidade ON Pacientes (cidade);
