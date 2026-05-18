-- query 9
-- Pergunta:
--  O time de dados quer saber quantos álbuns existem para cada artista. Mostre o `artist_id` e a contagem de álbuns, apenas artistas com **mais de 3 álbuns**. Ordene do artista com mais álbuns para o com menos.

-- Query original:
select
	artist_id,
	count(album_id) as total_albuns
from
	album
group by
	artist_id
having
	count(album_id) < 3
order by
	total_albuns desc;

-- Problemas encontrados:
-- O HAVING está invertido.
-- A consulta traz artistas com menos de 3 álbuns, não mais de 3.

-- Solução:
-- Mantivemos o agrupamento por artist_id
-- e corrigimos o filtro para COUNT(album_id) > 3.

-- Query correta:
select
	artist_id,
	count(album_id) as total_albuns
from
	album
group by
	artist_id
having
	count(album_id) > 3
order by
	total_albuns desc;
