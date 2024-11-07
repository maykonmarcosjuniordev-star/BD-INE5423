-- Considere o seguinte BD relacional para o dominio de um museu:
-- Obras        | _codigo_    | titulo    | ano           | *autor* | *salao*
-- Pinturas     | _*codigo*_  | estilo    | area
-- Esculturas   | _*codigo*_  | altura    | peso          | material
-- Autores      | _codigo_    | nome      | nacionalidade
-- Funcionarios | _CPF_       | nome      | salario       | turno funcao
-- Lotacoes     | _*CPF*_     | _*numero*_| _horaEntrada_   | horaSaida
-- Saloes       | _numero_    | andar     | area

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
    PRIMARY KEY (CPF, numero),
    FOREIGN KEY (CPF) REFERENCES Funcionarios(CPF)
);

CREATE TABLE Saloes (
    numero INT PRIMARY KEY,
    andar INT,
    area FLOAT
);

-- 1) buscar o codigo e o titulo das obras produzidas entre 1995 e 2015 que estao no salao de numero 36. Apresentar o resultado ordenado pelo titulo;

SELECT O.codigo, O.titulo FROM Obras O
    WHERE (O.ano BETWEEN 1995 AND 2015) AND O.salao = 36
    ORDER BY O.titulo;

-- 2) buscar o nome e o CPF dos funcionarios do noturno que estao lotados no salao de numero 25;
-- 3) buscar o codigo e o titulo das obras do autor Pablo Picasso que se encontram em saloes do terceiro andar do museu;
-- 4) buscar o codigo e o titulo das obras cujo estilo é impressionista ou cujo material de fabricacao é argila;
-- 5) buscar o nome e a nacionalidade dos autores que possuem tanto pinturas quanto esculturas expostas no museu;
-- 6) gerar uma tabela que associa pares de nomes de segurancas diferentes que cuidam dos mesmos saloes nos mesmos periodos (mesmos horarios de entrada e saida), como exemplificado abaixo:
-- nomeF1 | nomeF2
-- Joao   | Pedro
-- Joao   | Carlos
-- Pedro  | José

-- 7) buscar o numero dos saloes onde estao expostas apenas esculturas;
-- 8) buscar o nome e o CPF dos faxineiros que limpam todos os saloes do quarto andar;
-- 9) buscar o numero do salao de maior area no museu;
-- 10) buscar o nome, CPF e salario dos segurancas do diurno (manha ou tarde) que trabalham em mais de dois saloes;
-- 11) buscar o codigo e o titulo das obras que sao mais antigas que qualquer obra do autor Claude Monet;
-- 12) aumentar em 15% o salario dos funcionarios que trabalham em algum salao cuja area é superior à 500;
-- 13) remover os autores que possuem apenas uma (1) obra no museu;
-- 14) criar a tabela Lotacoes. Você é livre para definir os tipos de dados que julgar mais adequados para os atributos;
-- 15) inserir uma tupla valida na tabela Lotacoes que você criou na questao anterior.
