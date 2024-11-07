-- Resolva o que se pede utilizando subconsultas [NOT] IN:

-- 1) nome dos pacientes com consultas marcadas após às 14 horas
select nome from pacientes where codp in (select codp from consultas where hora > '14:00');

-- 2) nome e idade dos médicos que possuem consulta com a paciente Ana
select m.nome, m.idade from medicos m where codm in 
    (select codm from consultas where codp = 
        (select codp from pacientes where nome = 'Ana'));

-- 3) número e andar dos ambulatórios onde nenhum médico dá atendimento
select nroa, andar from ambulatorios where nroa not in 
    (select nroa from medicos where nroa is not null);

-- Resolva o que se pede utilizando subconsultas SOME e/ou ALL:
-- 4) CPF dos médicos que atendem em ambulatórios do primeiro andar

select CPF from medicos where nroa = ALL 
    (select nroa from ambulatorios where andar = 1);

-- 5) nome e CPF de todos os funcionários, exceto o de maior salário
select nome, CPF from funcionarios where salario < SOME 
    (select salario from funcionarios);

-- 6) nome dos pacientes com consultas marcadas para horários anteriores a
-- todos os horários de consultas marcadas para o dia 14/10/2020
select nome from pacientes where codp in 
    (select codp from consultas where hora <
        ALL (select hora from consultas where data = '2020/10/14')
    );

-- 7) número e andar dos ambulatórios com capacidade superior à capacidade
-- de qualquer ambulatório que esteja no primeiro andar

select nroa, andar from ambulatorios where capacidade > ALL 
    (select capacidade from ambulatorios where andar = 1);

