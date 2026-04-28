-- QUERY 1
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

-- QUERY 2
-- Pergunta:
-- O time de produto quer saber a duração média das faixas por gênero, em minutos, arredondada para 2 casas decimais. Mostre apenas gêneros com duração média **acima de 4 minutos**. Ordene do gênero com maior duração para o menor.

-- Query original incorreta:
select
	genre_id as genero,
	round(avg(milliseconds) / 60000, 2) as duracao_media_minutos
from
	track
group by
	genero
having
	duracao_media_minutos > 4
order by
	duracao_media_minutos desc;

-- Problemas encontrados:
-- O HAVING usa o valor da média, o que não é o melhor oque não funciona no postgresql,
-- e o filtro precisa ser feito sobre a média real, não sobre o nome da coluna.

-- Solução:
-- Agrupamos por genre_id, calculamos a média em minutos para exibir
-- e filtramos com AVG(milliseconds) > 240000, que equivale a 4 minutos.

-- Query correta:
select
	genre_id,
	round(avg(milliseconds)::numeric / 60000, 2) as duracao_media_minutos
from
	track
group by
	genre_id
having
	avg(milliseconds) > 240000
order by
	duracao_media_minutos desc;

-- QUERY 3
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

-- QUERY 4
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

-- QUERY 5
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

-- QUERY 6
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

-- QUERY 7
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

-- QUERY 8
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

-- QUERY 9
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

-- QUERY 10
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
