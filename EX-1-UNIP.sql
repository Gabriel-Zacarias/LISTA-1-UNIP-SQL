--CREATE DATABASE "EXERCICIO_01"
--TEMPLATE = TEMPLATE0
--ENCODING 'WIN1252'
--CONNECTION LIMIT 10

CREATE TABLE tb_escolaridade (
id_escolaridade integer,
descricao varchar (60),
fg_ativo integer,
CONSTRAINT pk_escolaridade_id_escolaridade PRIMARY KEY (id_escolaridade)
);


CREATE TABLE tb_funcao (
id_funcao integer,
descricao varchar (60),
salario numeric (7, 2),
fg_ativo integer,
CONSTRAINT pk_funcao_id_funcao PRIMARY KEY (id_funcao)
);

CREATE TABLE tb_funcionario (
id_funcionario integer,
id_funcao INTEGER,
id_escolaridade integer,
nome varchar (60),
cpf varchar (11),
rg varchar (10),
fg_ativo integer,

CONSTRAINT pk_funcionario_id_funcionario PRIMARY KEY (id_funcionario),
CONSTRAINT fk_funcionario_id_funcao FOREIGN KEY (id_funcao) REFERENCES tb_funcao (id_funcao),
CONSTRAINT fk_funcionario_id_escolaridade FOREIGN KEY (id_escolaridade) REFERENCES tb_escolaridade (id_escolaridade)
);

INSERT INTO tb_escolaridade VALUES (1, 'Ensino Fundamental', 1),
(2, 'Ensino Médio', 1),
(3, 'Nível Superior', 1);

INSERT INTO tb_funcao VALUES (1, 'Desenvolvedor Java', 4565.85, 1),
(2, 'Desenvolvedor C#', 3400.00, 1),
(3, 'DBA', 8500.00, 1);

INSERT INTO tb_funcionario VALUES (1, 3, 3, 'Agnaldo Peterson', '12344321', '98777-X', 1),
(2, 2, 2, 'Camila Ap. Fernandes', '7651234', '87658-0', 1),
(3, 1, 3, 'Patricia Rossini', '98765432111', '98623-7', 1);

--Questão 04:
SELECT a.nome, a.cpf, b.descricao, c.descricao, c.salario FROM
tb_funcionario a
INNER JOIN tb_escolaridade b ON a.id_escolaridade = b.id_escolaridade
INNER JOIN tb_funcao c ON a.id_funcao = c.id_funcao
WHERE c.salario >= 3000.00 AND c.salario <= 4600.00 AND
a.fg_ativo = 1 AND b.fg_ativo = 1 AND c.fg_ativo = 1;

--Questão 05:
SELECT a.id_funcionario, c.descricao, b.descricao, a.nome, a.cpf, a.rg FROM
tb_funcionario a
INNER JOIN tb_escolaridade b ON a.id_escolaridade = b.id_escolaridade
INNER JOIN tb_funcao c ON a.id_funcao = c.id_funcao
WHERE c.descricao LIKE '___e%' AND
a.fg_ativo = 1 AND b.fg_ativo = 1 AND c.fg_ativo = 1
ORDER BY 4 DESC;

--Questão 06:
SELECT a.id_funcionario, a.nome, c.descricao, c.salario, c.salario * 12 as "Salário Anual" FROM
tb_funcionario a
INNER JOIN tb_escolaridade b ON a.id_escolaridade = b.id_escolaridade
INNER JOIN tb_funcao c ON a.id_funcao = c.id_funcao
WHERE a.fg_ativo = 1 AND b.fg_ativo = 1 AND c.fg_ativo = 1
ORDER BY c.salario DESC;

--Questão 07:
SELECT a.nome, a.cpf, a.rg, c.descricao, b.descricao FROM
tb_funcionario a
INNER JOIN tb_escolaridade b ON a.id_escolaridade = b.id_escolaridade
INNER JOIN tb_funcao c ON a.id_funcao = c.id_funcao
WHERE (c.salario > 4500.00 OR a.id_funcao = 2) AND
a.fg_ativo = 1 AND b.fg_ativo = 1 AND c.fg_ativo = 1
ORDER BY 5;

--Questão 08:
SELECT a.nome, c.descricao, b.descricao FROM
tb_funcionario a
INNER JOIN tb_escolaridade b ON a.id_escolaridade = b.id_escolaridade
INNER JOIN tb_funcao c ON a.id_funcao = c.id_funcao
WHERE a.fg_ativo = 1 AND b.fg_ativo = 1 AND c.fg_ativo = 1
OFFSET 2;
