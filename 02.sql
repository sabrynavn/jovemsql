-- query 2
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
