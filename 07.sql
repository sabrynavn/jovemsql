-- query 7
-- Pergunta:
-- O time de catálogo quer saber quantas faixas cada álbum tem. Mostre o `album_id` e o total de faixas, apenas álbuns com **mais de 10 faixas**. Ordene do álbum com mais faixas para o com menos.

-- Query original:
select
	album_id,
	count(track_id) as total_faixas
from
	track
having
	count(track_id) > 10
order by
	total_faixas asc;

-- Problemas encontrados:
-- Faltou agrupar por album_id.
-- A ordenação também ficou ao contrário do que o enunciado pede.

-- Solução:
-- Agrupamos por album_id, mantivemos o filtro de mais de 10 faixas
-- e ordenamos da maior contagem para a menor.

-- Query correta:
select
	album_id,
	count(track_id) as total_faixas
from
	track
group by
	album_id
having
	count(track_id) > 10
order by
	total_faixas desc;
