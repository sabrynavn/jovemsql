-- query 10
-- Pergunta:
--  O time de curadoria quer saber a duração máxima e mínima das faixas por gênero. Mostre o `genre_id`, a duração máxima e a duração mínima em milissegundos. Ordene do gênero com maior duração máxima para o menor.

-- Query original:
select
	max(milliseconds) as duracao_maxima,
	min(milliseconds) as duracao_minima
from
	track
group by
	genre_id
order by
	duracao_maxima desc;

-- Problemas encontrados:
-- A query agrupa por genre_id,
-- mas não mostra genre_id no resultado.

-- Solução:
-- Incluímos genre_id no SELECT
-- para identificar cada grupo retornado pelo GROUP BY.

-- Query correta:
select
	genre_id,
	max(milliseconds) as duracao_maxima,
	min(milliseconds) as duracao_minima
from
	track
group by
	genre_id
order by
	duracao_maxima desc;
