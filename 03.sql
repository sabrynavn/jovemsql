-- query 3
-- Pergunta:
-- O time de engenharia quer mapear o catálogo por combinação de gênero e tipo de mídia. Mostre quantas faixas existem em cada combinação, apenas para combinações com **100 faixas ou mais**. Ordene da combinação com mais faixas para a com menos.

-- Query original:
select
	genre_id as genero,
	count(*) as total_faixas
from
	track
group by
	genero
having
	count(*) <= 100
order by
	total_faixas desc;

-- Problemas encontrados:
-- Faltou media_type_id no resultado e no agrupamento.
-- e também, o filtro ficou invertido: o certo é 100 ou mais.

-- Solução:
-- Agrupamos por genre_id e media_type_id,
-- depois o HAVING com COUNT(*) >= 100.

-- Query correta:
select
	genre_id,
	media_type_id,
	count(*) as total_faixas
from
	track
group by
	genre_id,
	media_type_id
having
	count(*) >= 100
order by
	total_faixas desc;
