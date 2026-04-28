-- query 4
-- Pergunta:
-- O time de curadoria quer identificar os álbuns mais longos do catálogo. Mostre o `album_id` e a duração total em minutos, arredondada para 2 casas decimais, apenas para álbuns com **mais de 60 minutos** de duração total. Ordene do álbum mais longo para o mais curto.

-- Query original:
select
	album_id,
	round(sum(milliseconds) / 60000, 2) as duracao_total_minutos
from
	track
having
	sum(milliseconds) > 3600000
order by
	album_id asc;

-- Problemas encontrados:
-- Faltou GROUP BY album_id para somar por álbum.
-- A ordenação também está errada, porque o pedido é do maior para o menor.

-- Solução:
-- Agrupamos por album_id, filtramos os álbuns acima de 60 minutos
-- e ordenamos pela soma total em ordem decrescente.

-- Query correta:
select
	album_id,
	round(sum(milliseconds)::numeric / 60000, 2) as duracao_total_minutos
from
	track
group by
	album_id
having
	sum(milliseconds) > 3600000
order by
	sum(milliseconds) desc;
