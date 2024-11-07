-- 1) Buscar os dados dos médicos com menos de 40 anos ou com especialidade diferente de traumatologia
SELECT * FROM Medicos
    WHERE idade < 40 OR especialidade != 'traumatologia';
-- 2) Buscar o nome e a idade dos pacientes que não residem em Florianópolis
SELECT nome, idade from PACIENTES
    WHERE cidade != 'Florianopolis';
-- 3) Buscar o nome e a idade (em meses) dos pacientes
SELECT nome, idade * 12 AS idade_meses FROM Pacientes;
-- 4) Qual o horário da última consulta marcada para o dia 13/10/2020?
SELECT MAX(hora) FROM Consultas
    WHERE data = '2020/10/13';
-- 5) Qual a média de idade dos médicos e o total de ambulatórios atendidos por eles?
SELECT AVG(idade), COUNT(distinct nroa) FROM Medicos;
-- 6) Buscar o código, o nome e o salário líquido dos funcionários. O salário líquido é o salário cadastrado menos 20%
SELECT codf, nome, salario * 0.8 AS salario_liquido FROM Funcionarios;
-- 7) Buscar o nome dos funcionários que terminam com a letra 'a'
SELECT nome FROM Funcionarios
    WHERE nome LIKE '%a';
-- 8) Buscar o nome e a especialidade dos médicos cuja segunda e a última letra de seus nomes seja a letra 'o'
SELECT nome, especialidade FROM Medicos
    WHERE nome LIKE '_o%o';
-- 9) Buscar os códigos e nomes dos pacientes com mais de 25 anos que estão com tendinite, fratura, gripe ou sarampo
SELECT codp, nome FROM Pacientes
    WHERE idade > 25 AND doenca IN ('tendinite', 'fratura', 'gripe', 'sarampo');
-- 10) Buscar os CPFs, nomes e idades de todas as pessoas (médicos, pacientes ou funcionários) que residem em Florianópolis
SELECT CPF, nome, idade FROM Medicos
    WHERE cidade = 'Florianopolis'
    UNION
SELECT CPF, nome, idade FROM Pacientes
    WHERE cidade = 'Florianopolis'
    UNION
SELECT CPF, nome, idade FROM Funcionarios
    WHERE cidade = 'Florianopolis';
