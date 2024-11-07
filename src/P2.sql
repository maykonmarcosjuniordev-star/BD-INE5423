-- Considere o seguinte BD relacional para o dominio de um museu:
-- Obras        | _codigo_    | titulo    | ano           | *autor* | *salao*
-- Pinturas     | _*codigo*_  | estilo    | area
-- Esculturas   | _*codigo*_  | altura    | peso          | material
-- Autores      | _codigo_    | nome      | nacionalidade
-- Funcionarios | _CPF_       | nome      | salario       | turno   | funcao
-- Lotacoes     | _*CPF*_     | _*numero*_| _horaEntrada_ | horaSaida
-- Saloes       | _numero_    | andar     | area

-- 1) buscar o codigo e o titulo das obras produzidas entre 1995 e 2015 que estao no salao de numero 36. Apresentar o resultado ordenado pelo titulo;

SELECT codigo, titulo FROM Obras
    WHERE (ano BETWEEN 1995 AND 2015) AND salao = 36
    ORDER BY titulo;

-- 2) buscar o nome e o CPF dos funcionarios do noturno que estao lotados no salao de numero 25;

SELECT nome, CPF FROM Funcionarios
    NATURAL JOIN Lotacoes
    WHERE turno = 'N' AND numero = 25;

-- 3) buscar o codigo e o titulo das obras do autor Pablo Picasso que se encontram em saloes do terceiro andar do museu;

SELECT codigo, titulo FROM Obras
    WHERE autor in (
        SELECT codigo FROM Autores
         WHERE nome = 'Pablo Picasso')
    AND salao IN (
        SELECT numero FROM Saloes
         WHERE andar = 3);

-- 4) buscar o codigo e o titulo das obras cujo estilo é impressionista ou cujo material de fabricacao é argila;

SELECT codigo, titulo FROM Obras
    WHERE codigo IN (
        SELECT codigo FROM Pinturas
        WHERE estilo = 'impressionista'
          UNION
        SELECT codigo FROM Esculturas
        WHERE material = 'argila');

-- 5) buscar o nome e a nacionalidade dos autores que possuem tanto pinturas quanto esculturas expostas no museu;

SELECT A.nome, A.nacionalidade FROM Autores A
    WHERE A.codigo IN (
        SELECT autor FROM Obras WHERE codigo IN (SELECT codigo FROM Pinturas))
    AND A.codigo IN (
        SELECT autor FROM Obras WHERE codigo IN (SELECT codigo FROM Esculturas));

-- 6) gerar uma tabela que associa pares de nomes de segurancas diferentes que cuidam dos mesmos saloes nos mesmos periodos (mesmos horarios de entrada e saida), como exemplificado abaixo:
-- nomeF1 | nomeF2
-- Joao   | Pedro
-- Joao   | Carlos
-- Pedro  | José

SELECT F1.nome AS nomeF1, F2.nome AS nomeF2 FROM
    Funcionarios F1
    JOIN Lotacoes L1 ON (
        F1.CPF = L1.CPF AND F1.funcao = 'seguranca')
    JOIN Funcionarios F2 ON F1.CPF < F2.CPF
    JOIN Lotacoes L2 ON (
        F2.CPF = L2.CPF
        AND F2.funcao = 'seguranca'
        AND L1.numero = L2.numero
        AND L1.horaEntrada = L2.horaEntrada
        AND L1.horaSaida = L2.horaSaida);

-- 7) buscar o numero dos saloes onde estao expostas apenas esculturas;
SELECT DISTINCT salao FROM Obras
    WHERE codigo IN (SELECT codigo FROM Esculturas)
EXCEPT
    SELECT salao FROM Obras
        WHERE codigo IN (SELECT codigo FROM Pinturas);

-- 8) buscar o nome e o CPF dos faxineiros que limpam todos os saloes do quarto andar;

SELECT F.nome, F.CPF FROM Funcionarios F
    WHERE F.funcao = 'faxineiro'
        AND NOT EXISTS (
            SELECT S.numero FROM Saloes S
                WHERE S.andar = 4
                 AND S.numero NOT IN (
                    SELECT L.numero FROM Lotacoes L
                     WHERE L.CPF = F.CPF
            )
        );

-- 9) buscar o numero do salao de maior area no museu;

SELECT numero FROM Saloes
    WHERE area = (SELECT DISTINCT MAX(area) FROM Saloes);

-- 10) buscar o nome, CPF e salario dos segurancas do diurno (manha ou tarde) que trabalham em mais de dois saloes;

SELECT F.nome, F.CPF, F.salario FROM Funcionarios F
    JOIN Lotacoes L ON F.CPF = L.CPF
    WHERE F.turno IN ('M', 'T')
        AND F.funcao = 'seguranca'
    GROUP BY F.CPF
    HAVING COUNT(L.numero) > 2;

-- 11) buscar o codigo e o titulo das obras que sao mais antigas que qualquer obra do autor Claude Monet;

SELECT O.codigo, O.titulo FROM Obras O
    WHERE O.ano < (SELECT DISTINCT MIN(ano) FROM Obras
                    WHERE autor = (SELECT DISTINCT codigo FROM Autores
                                    WHERE nome = 'Claude Monet'));

-- 12) aumentar em 15% o salario dos funcionarios que trabalham em algum salao cuja area é superior à 500;

UPDATE Funcionarios
    SET salario = salario * 1.15
    WHERE CPF IN (SELECT CPF FROM Lotacoes
                    WHERE numero IN (SELECT numero FROM Saloes
                                        WHERE area > 500));

-- 13) remover os autores que possuem apenas uma (1) obra no museu;

DELETE FROM Autores
    WHERE codigo IN (
        SELECT autor FROM Obras
            GROUP BY autor
            HAVING COUNT(codigo) = 1);

-- 14) criar a tabela Lotacoes. Você é livre para definir os tipos de dados que julgar mais adequados para os atributos;

CREATE TABLE Lotacoes (
    CPF CHAR(11),
    numero INT,
    horaEntrada TIME,
    horaSaida TIME,
    PRIMARY KEY (CPF, numero, horaEntrada),
    FOREIGN KEY (CPF) REFERENCES Funcionarios(CPF)
    FOREIGN KEY (numero) REFERENCES Saloes(numero)
);

-- 15) inserir uma tupla valida na tabela Lotacoes que você criou na questao anterior.
INSERT INTO funcionarios
 	VALUES ('12345678901', 'Joao', 0, 'M', 'Faxineiro');
    
INSERT INTO saloes
	VALUES (1, 1, 10);

INSERT INTO Lotacoes
    VALUES ('12345678901', 1, '08:00:00', '17:00:00');
