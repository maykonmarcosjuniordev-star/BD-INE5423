-- 1) criar uma visão que enxerga o código, nome, CPF e idade os dados dos funcionários de Florianopolis;

CREATE VIEW FuncFloripa (cod, nome, CPF, idade) AS
    SELECT codf, nome, CPF, idade
    FROM Funcionarios
    WHERE cidade = 'Florianopolis';

-- 2) consulte os dados da visão;
SELECT * FROM FuncFloripa;
-- 3) incremente a idade de todos os funcionários da visão;
UPDATE FuncFloripa
    SET idade = idade + 1;
-- 4) consulte novamente os dados da visão. A atualização funcionou?
SELECT * FROM FuncFloripa;
-- 5) inserir o funcionário de nome Rodrigo, CPF 22200022233, 41 anos e código 10 através da visão;
INSERT INTO FuncFloripa (cod, nome, CPF, idade)
    VALUES (10, 'Rodrigo', 22200022233, 41);
-- 6) consulte os dados da visão. A inserção funcionou?
SELECT * FROM FuncFloripa;
-- 7) definir uma trigger que, ao invés de inserir na visão, insere diretamente na tabela Funcionários preenchendo o atributo cidade com ‘Florianopolis’;

CREATE RULE InsereFuncFloripa
    AS ON INSERT TO FuncFloripa
    DO INSTEAD
    	INSERT INTO Funcionarios (codf, nome, idade, cidade, cpf)
        VALUES (NEW.cod, NEW.nome, NEW.idade, 'Florianopolis', NEW.cpf);

-- 8) inserir o funcionário de nome Raul, CPF 44400044433, 53 anos e código 11;
INSERT INTO FuncFloripa (cod, nome, CPF, idade)
    VALUES (11, 'Raul', 44400044433, 53);
-- 9) consulte os dados da visão. A inserção funcionou?
SELECT * FROM FuncFloripa;
-- 10) criar uma visão que enxerga o código, nome, idade, CPF e número do ambulatório dos médicos que atendem em ambulatórios com número igual ou superior à 2. Defina essa visão com a cláusula WITH CHECK OPTION;
CREATE VIEW MedAmb2 (cod, nome, idade, CPF, nroa) AS
    SELECT codm, nome, idade, CPF, nroa
    FROM Medicos
    WHERE nroa >= 2
    WITH CHECK OPTION;
-- 11) consulte os dados da visão;
SELECT * FROM MedAmb2;
-- 12) inserir o médico de nome Soraia, CPF 55500055533, 47 anos, ambulatório 2 e código 7;
INSERT INTO MedAmb2 (cod, nome, idade, CPF, nroa)
    VALUES (7, 'Soraia', 47, 55500055533, 2);
-- 13) consulte os dados da visão. A inserção funcionou?
SELECT * FROM MedAmb2;
-- 14) inserir o médico de nome Saulo, CPF 66600066633, 52 anos, ambulatório 1 e código 8. A inserção funcionou?
INSERT INTO MedAmb2 (cod, nome, idade, CPF, nroa)
    VALUES (8, 'Saulo', 52, 66600066633, 1);
