-- query 8
-- Pergunta:
-- O time financeiro quer saber quantas faixas existem em cada faixa de preço. Mostre o `unit_price` e a contagem. Ordene do preço mais alto para o mais baixo.

-- Query original incorreta:
select
	count(*) as total_faixas
from
	track
group by
	unit_price
order by
	unit_price desc;

-- Problemas encontrados:
-- A query agrupa por unit_price,
-- mas não mostra o preço no resultado.

-- Solução:
-- Bastou incluir unit_price no SELECT,
-- porque o GROUP BY e a ordem já estavam corretos.

-- Query correta:
select
	unit_price,
	count(*) as total_faixas
from
	track
group by
	unit_price
order by
	unit_price desc;
