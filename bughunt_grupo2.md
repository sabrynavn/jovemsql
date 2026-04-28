# Bug Hunt — Aula 06
## Grupo 2

**Banco de dados:** Chinook · PostgreSQL  
**Tabelas:** `track` · `album`

---

## Regras da dinâmica

Cada query abaixo está **quebrada**. Pode faltar parte da lógica, pode ter algo errado no que está escrito, pode ter os dois ao mesmo tempo. O enunciado descreve exatamente o que o cliente precisa — a query não entrega isso.

### O que a equipe precisa entregar

Para cada query, a equipe deve registrar:

1. **A query incorreta** — exatamente como está aqui
2. **O que foi encontrado** — descrever os problemas em português, explicando por que a query não resolve o enunciado
3. **Como chegaram na solução** — o raciocínio que levou à correção
4. **A query correta** — a versão funcionando no banco que entrega o que o enunciado pede

A entrega é feita por escrito. Cada query vale **1 ponto**. A equipe que entregar mais respostas corretas e bem explicadas vence.

---

## Queries

---

### Query 1

> O time de catálogo quer saber quantas faixas existem em cada gênero. Mostre o `genre_id` e a contagem de faixas, mas apenas gêneros com **mais de 50 faixas**. Ordene do gênero com mais faixas para o com menos.

```sql
select
  count(track_id) as total_faixas
from
  track
group by
  genre_id,
  media_type_id
order by
  total_faixas asc;
```

---

### Query 2

> O time de produto quer saber a duração média das faixas por gênero, em minutos, arredondada para 2 casas decimais. Mostre apenas gêneros com duração média **acima de 4 minutos**. Ordene do gênero com maior duração para o menor.

```sql
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
```

---

### Query 3

> O time de engenharia quer mapear o catálogo por combinação de gênero e tipo de mídia. Mostre quantas faixas existem em cada combinação, apenas para combinações com **100 faixas ou mais**. Ordene da combinação com mais faixas para a com menos.

```sql
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
```

---

### Query 4

> O time de curadoria quer identificar os álbuns mais longos do catálogo. Mostre o `album_id` e a duração total em minutos, arredondada para 2 casas decimais, apenas para álbuns com **mais de 60 minutos** de duração total. Ordene do álbum mais longo para o mais curto.

```sql
select
  album_id,
  round(sum(milliseconds) / 60000, 2) as duracao_total_minutos
from
  track
having
  sum(milliseconds) > 3600000
order by
  album_id asc;
```

---

### Query 5

> O time de dados quer saber quantas faixas estão sem compositor cadastrado em cada gênero. Mostre o `genre_id` e a contagem, apenas para gêneros onde esse número **passa de 10**. Ordene do gênero com mais faixas sem compositor para o com menos.

```sql
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
```

---

### Query 6

> O time de produto quer saber o tamanho médio em bytes das faixas por tipo de mídia. Mostre o `media_type_id` e a média arredondada para 0 casas decimais. Ordene do tipo com maior média para o menor.

```sql
select
  round(avg(bytes), 0) as media_bytes
from
  track
group by
  media_type_id
order by
  media_bytes asc;
```

---

### Query 7

> O time de catálogo quer saber quantas faixas cada álbum tem. Mostre o `album_id` e o total de faixas, apenas álbuns com **mais de 10 faixas**. Ordene do álbum com mais faixas para o com menos.

```sql
select
  album_id,
  count(track_id) as total_faixas
from
  track
having
  count(track_id) > 10
order by
  total_faixas asc;
```

---

### Query 8

> O time financeiro quer saber quantas faixas existem em cada faixa de preço. Mostre o `unit_price` e a contagem. Ordene do preço mais alto para o mais baixo.

```sql
select
  count(*) as total_faixas
from
  track
group by
  unit_price
order by
  unit_price desc;
```

---

### Query 9

> O time de dados quer saber quantos álbuns existem para cada artista. Mostre o `artist_id` e a contagem de álbuns, apenas artistas com **mais de 3 álbuns**. Ordene do artista com mais álbuns para o com menos.

```sql
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
```

---

### Query 10

> O time de curadoria quer saber a duração máxima e mínima das faixas por gênero. Mostre o `genre_id`, a duração máxima e a duração mínima em milissegundos. Ordene do gênero com maior duração máxima para o menor.

```sql
select
  max(milliseconds) as duracao_maxima,
  min(milliseconds) as duracao_minima
from
  track
group by
  genre_id
order by
  duracao_maxima desc;
```
