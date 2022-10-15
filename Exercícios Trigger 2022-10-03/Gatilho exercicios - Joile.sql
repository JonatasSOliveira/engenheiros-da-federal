02- Uma trigger que tem a função adicionar a entrada de produtos no estoque deve ser associado para qual:
•	Tabela? item.compra e produto
•	Tempo? after
•	Evento? insert
•	Precisa de variáveis? Quais? item_compra.quantidade e produto.estoque
•	Implemente a trigger

DELIMITER // 
CREATE TRIGGER adicionar_entrada 
AFTER 
INSERT
ON item_compra
FOR EACH ROW 
BEGIN
	UPDATE produto SET produto.estoque = produto.estoque + New.quantidade WHERE New.produto_id = produto.id;
END;
//
DELIMITER ;

03- Uma trigger que tem a função criar um registro de auditoria quando um pagamento e recebimento for alterada deve ser associado para qual(is):
•	Tabela(s)? Pagamento e Recebimento
•	Tempo? After
•	Evento? Update
•	Implemente a trigger (pode criar a tabela de auditoria)

CREATE TABLE auditoria(
tabela VARCHAR(40),
acao VARCHAR(10),
data_hora DATETIME,
chave VARCHAR(255),
antes VARCHAR(4000),
depois VARCHAR(4000)
);

DELIMITER // 
CREATE TRIGGER auditoria_pagamento
AFTER 
UPDATE
ON pagamento
FOR EACH ROW 
BEGIN
	INSERT INTO auditoria(tabela, acao, data_hora, antes, depois)
    VALUES ('PAGAMENTO','UPDATE', now(), CONCAT(OLD.id,'-',OLD.valor,'-',OLD.fornecedor_id,'-',OLD.compra_id,'-',OLD.data_hora), CONCAT(NEW.id,'-',NEW.valor,'-',NEW.fornecedor_id,'-',NEW.compra_id,'-',NEW.data_hora));
END;
//
DELIMITER ;

DELIMITER // 
CREATE TRIGGER auditoria_recebimento
AFTER 
UPDATE
ON recebimento
FOR EACH ROW 
BEGIN
	INSERT INTO auditoria(tabela, acao, data_hora, antes, depois)
    VALUES ('RECEBIMENTO','UPDATE', now(), CONCAT(OLD.id,'-',OLD.valor,'-',OLD.cliente_id,'-',OLD.venda_id,'-',OLD.data_hora), CONCAT(NEW.id,'-',NEW.valor,'-',NEW.cliente_id,'-',NEW.venda_id,'-',NEW.data_hora));
END;
//
DELIMITER ;
