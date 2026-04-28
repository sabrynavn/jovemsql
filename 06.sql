-- query 6
-- Pergunta:
-- O time de produto quer saber o tamanho médio em bytes das faixas por tipo de mídia. Mostre o `media_type_id` e a média arredondada para 0 casas decimais. Ordene do tipo com maior média para o menor.

-- Query original:
select
	round(avg(bytes), 0) as media_bytes
from
	track
group by
	media_type_id
order by
	media_bytes asc;

-- Problemas encontrados:
-- Faltou mostrar media_type_id no resultado.
-- A ordenação também ficou invertida.

-- Solução:
-- Incluímos media_type_id no SELECT
-- e trocamos a ordenação para DESC.

-- Query correta:
select
	media_type_id,
	round(avg(bytes), 0) as media_bytes
from
	track
group by
	media_type_id
order by
	media_bytes desc;
