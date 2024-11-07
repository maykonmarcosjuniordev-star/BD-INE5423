-- Buscar o que se pede utilizando ORDER BY ou GROUP BY:
-- 1) os dados de todos os funcionários ordenados pelo salário (decrescente) e pela idade
-- (crescente). Buscar apenas os três primeiros funcionários nesta ordem

Select * from funcionarios order by salario desc, idade asc limit 3;

-- 2) o nome dos médicos e o número e andar do ambulatório onde eles atendem,
-- ordenado pelo número do ambulatório

Select m.nome, m.nroa, a.andar from medicos m join ambulatorios a on m.nroa = a.nroa order by a.nroa;

-- 3) andares dos ambulatórios e a capacidade total por andar
select andar, sum(capacidade) from ambulatorios group by andar;

-- 4) andares dos ambulatórios cuja média de capacidade no andar seja >= 40
select andar from ambulatorios group by andar having avg(capacidade) >= 40;

-- 5) nome dos médicos que possuem mais de uma consulta marcada
select m.nome from medicos m join consultas c on m.codm = c.codm group by m.nome having count(*) > 1;

-- Realizar as seguintes atualizações:
-- 6) excluir os ambulatórios que não possuem médicos atendendo neles
delete from ambulatorios where nroa not in (select nroa from medicos);

-- 7) o médico Pedro passa a residir na mesma cidade do paciente Paulo e sua idade
-- passa a ser o dobro da idade da paciente Ana. Realizar essa alteração.
update medicos set cidade = (select cidade from pacientes where nome = 'Paulo'), 
idade = (select 2*idade from pacientes where nome = 'Ana') where nome = 'Pedro';

-- 8) o funcionário Caio (codf = 3) tornou-se médico. Sua especialidade é a mesma da
-- médica Maria (codm = 2) e ele vai atender no mesmo ambulatório dela. Inserir Caio
-- na tabela Médicos, aproveitando os dados em comum.

INSERT INTO Medicos (codm, nome, idade, cidade, CPF, especialidade, nroa)
SELECT 
    (SELECT MAX(codm) + 1 FROM Medicos),
    f.nome,
    f.idade,
    f.cidade,
    f.CPF,
    m.especialidade,
    m.nroa
FROM Funcionarios f
JOIN Medicos m ON m.codm = 2
WHERE f.codf = 3;

