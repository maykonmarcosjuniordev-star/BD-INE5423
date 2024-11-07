-- Observacoes sobre este esquema relacional:
-- - A chave primaria de cada tabela é o seu conjunto de atributos _sublinhados_;
-- - Atributos em *negrito* sao chaves estrangeiras;
-- - Tabela Obras: o atributo autor é uma referência ao codigo do autor que produziu a obra na Tabela Autores.
--      - O atributo salao é uma referência a um numero de salao na tabela Saloes, indicando em que salao do museu a obra esta exposta;
-- - Tabela Pinturas: o atributo codigo, além de ser a chave primaria da tabela, é também uma referência ao codigo de uma obra na tabela Obras, onde sao mantidos outros dados da mesma.
--      - O atributo estilo indica a qual estilo pertence a obra, como por exemplo, impressionista ou surrealista;
-- - Tabela Esculturas: o atributo codigo, além de ser a chave primaria da tabela, é também uma referência ao codigo de uma obra na tabela Obras, onde sao mantidos outros dados da mesma.
--      - O atributo material indica o principal material que foi utilizado na producao da escultura, como por exemplo, bronze ou argila;
-- - Tabela Funcionarios: o atributo turno assume como valores: ‘M’ (manha), ‘T’ (tarde) ou ‘N’ (noite). O atributo funcao assume como valores: ‘seguranca’ ou ‘faxineiro’;
-- - Tabela Lotacoes: indica os saloes nos quais os funcionarios trabalham, por um certo periodo;
-- - Tabela Saloes: indica os saloes existentes nos andares do museu, onde as obras estao expostas.


-- Responda o que se pede na linguagem SQL:

CREATE TABLE Obras (
    codigo INT PRIMARY KEY,
    titulo VARCHAR(100),
    ano INT,
    autor INT,
    salao INT
);

CREATE TABLE Pinturas (
    codigo INT PRIMARY KEY,
    estilo VARCHAR(50),
    area FLOAT,
    FOREIGN KEY (codigo) REFERENCES Obras(codigo)
);

CREATE TABLE Esculturas (
    codigo INT PRIMARY KEY,
    altura FLOAT,
    peso FLOAT,
    material VARCHAR(50),
    FOREIGN KEY (codigo) REFERENCES Obras(codigo)
);

CREATE TABLE Autores (
    codigo INT PRIMARY KEY,
    nome VARCHAR(100),
    nacionalidade VARCHAR(50)
);

CREATE TABLE Funcionarios (
    CPF CHAR(11) PRIMARY KEY,
    nome VARCHAR(100),
    salario FLOAT,
    turno CHAR(1),
    funcao VARCHAR(50)
);

CREATE TABLE Lotacoes (
    CPF CHAR(11),
    numero INT,
    horaEntrada TIME,
    horaSaida TIME,
    PRIMARY KEY (CPF, numero, horaEntrada),
    FOREIGN KEY (CPF) REFERENCES Funcionarios(CPF),
    FOREIGN KEY (numero) REFERENCES Saloes(numero)
);

CREATE TABLE Saloes (
    numero INT PRIMARY KEY,
    andar INT,
    area FLOAT
);
