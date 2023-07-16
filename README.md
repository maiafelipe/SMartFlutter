# SMart

Um simples CRUD para criação de listas de supermercado.

## Features: O que foi feito até o momento

Contém todo o crud para a criação de uma única lista de mercado.

Os itens da lista contém descrição, local e status.

O botão (+) da home permite adicional um novo item, informando descrição e local.

O botão (...) de cada item permite modificar descrição e local daquele item específico e apagar o item.

Apertar no item da lista modifica seu status, essa modificação altera a visualização colocando um strikethrough.

## O que foi utilizado

A persistência ocorre por meio de SQFlite.

A classe [DBProvider] configura a conexão com o banco, utilizando o padrão Singleton.

## Organização do projeto

Na pasta [models] estão os modelos utilizados, carregando suas regras de negócio e os seus DAOs.

Na pasta [screens] estão as views do projeto, telas para visualização da lista, criação e edição.

Na pasta [componentes] estão alguns widgets personalizados que possuem potencial de ser reutilizados no projeto.

na pasta [services] estão provedores de serviços relevantes para o projeto.


