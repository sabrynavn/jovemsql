-- query 1
-- Pergunta:
-- O time de catálogo quer saber quantas faixas existem em cada gênero. Mostre o `genre_id` e a contagem de faixas, mas apenas gêneros com **mais de 50 faixas**. Ordene do gênero com mais faixas para o com menos.

-- Query original:
select
	count(track_id) as total_faixas
 from
	track
group by
	genre_id,
	media_type_id
order by
	total_faixas asc;

-- Problemas encontrados:
-- Faltou mostrar genre_id, o agrupamento por media_type_id não foi pedido
-- e faltou filtrar os gêneros com mais de 50 faixas.

-- Solução:
-- Agrupamos só por genre_id, aplicamos HAVING com COUNT(*) > 50
-- e ordenamos da maior contagem para a menor.

-- Query correta:
select
	genre_id,
	count(*) as total_faixas
from
	track
group by
	genre_id
having
	count(*) > 50
order by
	total_faixas desc;
