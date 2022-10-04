/*
Exercícios de fixação - utilize o script do estudo de caso
01- Escreva quatro triggers de sintaxe - a trigger não precisa ter funcionalidade, basta não dar erro de sintaxe. Use variável global para testar.
- Faça uma declarando variáveis e com select into; 
- Faça a segunda com uma estrutura de decisão; 
- Faça a terceira que gere erro, impedindo a ação;
- Faça a quart que utilize a variável new e old - tente diferenciar. 

*/

DROP TRIGGER IF EXISTS teste_variavel_e_select;

DELIMITER //
	CREATE TRIGGER teste_variavel_e_select
	AFTER INSERT ON item_venda
	FOR EACH ROW 
	BEGIN
		DECLARE qtde_venda_produto INT;
        SELECT COUNT(*) INTO qtde_venda_produto
			FROM venda
            WHERE produto_id = NEW.produto_id;
		UPDATE produto
        SET qtde_venda = qtde_venda_produto
        WHERE produto_id = NEW.produto_id;
	END;
//
DELIMITER ;

DROP TRIGGER IF EXISTS teste_decisao;

DELIMITER //
	CREATE TRIGGER teste_decisao
    BEFORE INSERT ON item_venda
    FOR EACH ROW
    BEGIN
		DECLARE qtde_estoque INT;
        SELECT estoque INTO qtde_estoque
		FROM produto WHERE id = NEW.produto_id;
		IF NEW.quantidade < qtde_estoque THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'QTDE. ESTOQUE SUPERIOR';
        END IF;
    END;
//
DELIMITER  ;


/*
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
