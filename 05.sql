-- query 5
-- Pergunta:
-- O time de dados quer saber quantas faixas estão sem compositor cadastrado em cada gênero. Mostre o `genre_id` e a contagem, apenas para gêneros onde esse número **passa de 10**. Ordene do gênero com mais faixas sem compositor para o com menos.

-- Query original:
select
	genre_id as genero,
	count(*) as faixas_sem_compositor
from
	track
group by
	genero
having
	count(*) > 10
order by
	faixas_sem_compositor desc;

-- Problemas encontrados:
-- A query conta todas as faixas do gênero,
-- mas o enunciado pede só as faixas sem compositor.

-- Solução:
-- Primeiro filtramos composer IS NULL,
-- depois agrupamos por genre_id e aplicamos HAVING > 10.

-- Query correta:
select
  genre_id,
  count(*) as faixas_sem_compositor
from
  track
where
  composer is null
group by
  genre_id
having
  count(*) > 10
order by
  faixas_sem_compositor desc;
