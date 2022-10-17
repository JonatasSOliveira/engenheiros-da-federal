/* ******************** TRIGGER ******************** 
Exercícios de fixação - utilize o script do estudo de caso

01- Escreva quatro triggers de sintaxe - a trigger não precisa ter funcionalidade, basta não dar erro de sintaxe. Use variável global para testar.
- Faça uma declarando variáveis e com select into; 
- Faça a segunda com uma estrutura de decisão; 
- Faça a terceira que gere erro, impedindo a ação;
- Faça a quarta que utilize a variável new e old - tente diferenciar. 
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
02- Uma trigger que tem a função adicionar a entrada de produtos no estoque deve ser associado para qual:
•	Tabela?
•	Tempo?
•	Evento?
•	Precisa de variáveis? Quais?
•	Implemente a trigger. 
*/

DELIMITER //
CREATE TRIGGER adiciona_estoque
AFTER INSERT ON item_compra
FOR EACH ROW

	BEGIN
		UPDATE produto 
		SET produto.estoque = produto.estoque + NEW.quantidade 
		WHERE NEW.produto_id = produto.id;
	END;

//
DELIMITER;

SELECT * FROM produto;



/*
03- Uma trigger que tem a função criar um registro de auditoria quando um pagamento e recebimento for alterada deve ser associado para qual(is):
•	Tabela(s)?
•	Tempo?
•	Evento?
•	Implemente a trigger (pode criar a tabela de auditoria)
*/

CREATE TABLE auditoria(
	tab VARCHAR (255),
	tab_alteracao VARCHAR (255),
	data_alteracao DATETIME,
	tab_antes VARCHAR (5000),
	tab_depois VARCHAR (5000)
);

DELIMITER //
CREATE TRIGGER auditoria_pagamento
AFTER UPDATE ON pagamento
FOR EACH ROW

	BEGIN
		INSERT INTO auditoria(tab, tab_alteracao, data_alteracao, tab_antes, tab_depois)
		VALUES ('PAGAMENTO', 'UPDATE', now(), 
        		CONCAT(OLD.id, '-', OLD.data_compra, '-', OLD.valor, '-', OLD.quantidade), 
        		CONCAT(NEW.id, '-', NEW.data_compra, '-', NEW.valor, '-', NEW.quantidade));
	END;

//
DELIMITER ;

DELIMITER //
CREATE TRIGGER auditoria_venda
AFTER UPDATE ON venda
FOR EACH ROW

	BEGIN
		INSERT INTO auditoria(tab, tab_alteracao, data_alteracao, tab_antes, tab_depois)
		VALUES ('VENDA', 'UPDATE', now(), 
        		CONCAT(OLD.id, '-', OLD.data_venda, '-', OLD.valor, '-', OLD.quantidade), 
        		CONCAT(NEW.id, '-', NEW.data_venda, '-', NEW.valor, '-', NEW.quantidade));
	END;

//
DELIMITER ;

/*
04- Uma trigger que tem a função impedir a venda de um produto inferior a 50% do preço de 
venda deve ser associado para qual:
•	Tabela?
•	Tempo?
•	Evento?
•	Implemente a trigger
*/

DELIMITER //
CREATE TRIGGER validar_venda
BEFORE INSERT ON item_venda
FOR EACH ROW

	BEGIN

		IF item_venda.preco < (produto.preco * 0.5);
		END IF;

	END;

//
DELIMITER ;

/*
05- Este é para testar a sintaxe - tente implementar sem o script
Uma trigger que tem a função de gerar o RA automático na tabela ALUNO deve ser associada para qual
•	Tabela?
•	Tempo?
•	Evento?
•	Precisa de variáveis? Quais?
•	Implemente a trigger - RA igual a concatenção do ano corrente, código do curso e o id do cadastro do aluno. 
*/

/*
06- De acordo com o seu projeto de banco de dados, pense em pelo menos 3 trigger úteis. Discuta com os seus colegas em relação a relevância e implemente-as.
*/




