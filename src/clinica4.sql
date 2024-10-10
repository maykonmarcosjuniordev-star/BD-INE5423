-- Responda o que se pede utilizando junção (não natural):
-- 1) Buscar o nome e CPF dos médicos que também são pacientes do hospital
SELECT M.nome, M.cpf FROM Medicos M
    JOIN Pacientes P ON M.cpf = P.cpf;
-- 2) Buscar nomes de funcionários e de médicos (exibir pares de nomes) que residem na mesma cidade
SELECT F.nome, M.nome FROM Funcionarios F
    JOIN Medicos M ON F.cidade = M.cidade;
-- 3) Buscar o nome e idade dos médicos que têm consulta marcada com a paciente cujo nome é Ana
SELECT M.nome, M.idade FROM Medicos M
    JOIN Consultas C ON M.codm = C.codm
    JOIN Pacientes P ON C.codp = P.codp
    WHERE P.nome = 'Ana';
-- 4) Buscar o número dos ambulatórios que estão no mesmo andar do ambulatório 5
SELECT A.nroa FROM Ambulatorios A
    JOIN Ambulatorios B ON A.andar = B.andar
    WHERE B.nroa = 5;

-- Responda o que se pede utilizando junção natural:
-- 5) Buscar o código e o nome dos pacientes com consulta marcada para horários após às 14 horas
SELECT DISTINCT codp, nome FROM Pacientes
    NATURAL JOIN Consultas
    WHERE hora > '14:00';

-- 6) Buscar o número e o andar dos ambulatórios cujos médicos possuem consultas marcadas para o dia 12/10/2020
SELECT A.nroa, andar FROM Ambulatorios A
    NATURAL JOIN Medicos
    NATURAL JOIN Consultas
    WHERE data = '2020/10/12';

-- Responda o que se pede utilizando junção externa (e também junção, se necessário):
-- 7) Buscar os dados de todos os ambulatórios e, para aqueles ambulatórios onde médicos dão atendimento, exibir também os códigos e nomes destes médicos
SELECT A.*, M.nome, M.codm FROM Ambulatorios A
    LEFT JOIN Medicos M ON A.nroa = M.nroa;

-- 8) Buscar o CPF e o nome de todos os médicos e, para aqueles médicos que possuem consultas marcadas, exibir também o nome dos paciente e a data da consulta
SELECT M.cpf, M.nome, P.nome, C.data FROM Medicos M
    LEFT JOIN Consultas C ON M.codm = C.codm
    LEFT JOIN Pacientes P ON C.codp = P.codp;
