-- Responda utilizando subconsultas com EXISTS:
-- 1) Buscar o nome e o CPF dos médicos que também são pacientes do  hospital

SELECT nome, cpf FROM Medicos M
    WHERE EXISTS (SELECT * FROM Pacientes P WHERE M.cpf = P.cpf);

-- 2) Buscar o nome e o CPF dos médicos ortopedistas, e a data das suas consultas, para os ortopedistas que têm consulta marcada com a paciente Ana

SELECT M.nome, M.cpf, C.data FROM Medicos M
    JOIN Consultas C ON M.codm = C.codm
    WHERE especialidade = 'Ortopedia' AND EXISTS (SELECT * FROM Pacientes P WHERE C.codp = P.codp AND P.nome = 'Ana');

-- 3) Buscar o nome e o CPF dos médicos que têm consultas marcadas com todos os pacientes

SELECT nome, cpf FROM Medicos M
    WHERE NOT EXISTS (SELECT * FROM Pacientes P
        WHERE NOT EXISTS (SELECT * FROM Consultas C
            WHERE C.codm = M.codm AND C.codp = P.codp));

-- 4) Buscar o nome e o CPF dos médicos ortopedistas que têm consultas marcadas com todos os pacientes de Florianópolis

SELECT nome, cpf FROM Medicos M
    WHERE especialidade = 'Ortopedia' AND NOT EXISTS (SELECT * FROM Pacientes P
        WHERE cidade = 'Florianópolis' AND NOT EXISTS (SELECT * FROM Consultas C
            WHERE C.codm = M.codm AND C.codp = P.codp));

-- Responda utilizando subconsultas na cláusula FROM:
-- 1) Buscar a data e a hora das consultas marcadas para a médica Maria

SELECT C.data, C.hora FROM
    (SELECT Medicos.codm FROM Medicos WHERE nome = 'Maria') M
        JOIN Consultas C ON M.codm = C.codm;
    
-- 2) Buscar o nome e a cidade dos pacientes que têm consultas marcadas com ortopedistas

SELECT P.nome, P.cidade FROM
    (SELECT codp FROM Consultas WHERE codm IN (SELECT codm FROM Medicos WHERE especialidade = 'Ortopedia'))
     C JOIN Pacientes P ON C.codp = P.codp;

-- 3) Buscar o nome e o CPF dos médicos que atendem no mesmo ambulatório do médico Pedro

SELECT M.nome, M.cpf FROM
    (SELECT nroa FROM Medicos WHERE nome = 'Pedro')
        P JOIN Medicos M ON P.nroa = M.nroa;
