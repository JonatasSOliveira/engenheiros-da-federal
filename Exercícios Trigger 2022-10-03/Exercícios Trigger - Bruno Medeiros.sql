DROP DATABASE IF EXISTS aula; 
CREATE DATABASE aula; 
USE aula; 

CREATE TABLE cliente (
id INT NOT NULL AUTO_INCREMENT
,nome_completo VARCHAR(255) NOT NULL 
,CPF_CNPJ VARCHAR(18) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT pk_cliente PRIMARY KEY (id)
);

CREATE TABLE produto (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(255) NOT NULL
,preco_custo DECIMAL(8,2) NOT NULL 
,preco_venda DECIMAL(8,2) NOT NULL 
,estoque INT NOT NULL
,CONSTRAINT pk_produto PRIMARY KEY (id)
);

CREATE TABLE venda(
id INT NOT NULL AUTO_INCREMENT
,data_venda DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,cliente_id INT NOT NULL 
,CONSTRAINT pk_venda PRIMARY KEY (id)
,CONSTRAINT fk_venda_cliente FOREIGN KEY (cliente_id) REFERENCES cliente (id)
);

CREATE TABLE item_venda(
produto_id INT NOT NULL
,venda_id INT NOT NULL
,quantidade INT NOT NULL 
,preco_unidade DECIMAL(8,2) NOT NULL 
,total_item DECIMAL(8,2) AS (quantidade * preco_unidade) STORED
);

INSERT INTO cliente (nome_completo,CPF_CNPJ) values ('MARIO PEREIRA','111.111.111-11');
INSERT INTO cliente (nome_completo,CPF_CNPJ) values ('JOANA MARCONDES','222.222.222-22');
INSERT INTO cliente (nome_completo,CPF_CNPJ) values ('SILVIO SANTOS','333.333.333-33');
INSERT INTO cliente (nome_completo,CPF_CNPJ,ativo) values ('MARIANA ANTUNES','444.444.444-44','N');

INSERT INTO produto (nome,preco_custo,preco_venda,estoque) values ('COCA-COLA',4.0,5.5,30);
INSERT INTO produto (nome,preco_custo,preco_venda,estoque) values ('CHOKITO',2.3,4.5,60);
INSERT INTO produto (nome,preco_custo,preco_venda,estoque) values ('BACONZITOS',4.7,9.0,80);


/* ******************** TRIGGER ******************** 
Exercícios de fixação - utilize o script do estudo de caso

01- Escreva quatro triggers de sintaxe - a trigger não precisa ter funcionalidade, basta não dar erro de sintaxe. Use variável global para testar.

- Faça uma declarando variáveis e com select into; 

INSERT INTO venda VALUES ();
*/


SELECT * FROM venda;

DELIMITER //
CREATE TRIGGER total_venda
AFTER INSERT ON item_venda
FOR EACH ROW

	BEGIN
		DECLARE total INT(6);
		SELECT preco_unidade * quantidade INTO total FROM venda;
	END; 

//
DELIMITER ;

SELECT * FROM venda;

/*
- Faça a segunda com uma estrutura de decisão; 

- Faça a terceira que gere erro, impedindo a ação;

- Faça a quarta que utilize a variável new e old - tente diferenciar. 

02- Uma trigger que tem a função adicionar a entrada de produtos no estoque deve ser associado para qual:

•	Tabela?
•	Tempo?
•	Evento?
•	Precisa de variáveis? Quais?
•	Implemente a trigger. 

03- Uma trigger que tem a função criar um registro de auditoria quando um pagamento e recebimento for alterada deve ser associado para qual(is):

•	Tabela(s)?
•	Tempo?
•	Evento?
•	Implemente a trigger (pode criar a tabela de auditoria)

04- Uma trigger que tem a função impedir a venda de um produto inferior a 50% do preço de venda deve ser associado para qual:

•	Tabela?
•	Tempo?
•	Evento?
•	Implemente a trigger

05- Este é para testar a sintaxe - tente implementar sem o script
Uma trigger que tem a função de gerar o RA automático na tabela ALUNO deve ser associada para qual

•	Tabela?
•	Tempo?
•	Evento?
•	Precisa de variáveis? Quais?
•	Implemente a trigger - RA igual a concatenção do ano corrente, código do curso e o id do cadastro do aluno. 

06- De acordo com o seu projeto de banco de dados, pense em pelo menos 3 trigger úteis. Discuta com os seus colegas em relação a relevância e implemente-as.





