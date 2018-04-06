# Aplicação de filtros de imagem em arquivos do tipo ppm

## Instalação

Para rodar o projeto, instale a plataforma do Haskell em seu computador.
Em distribuições Linux baseadas em Debian, basta rodar o comando abaixo:

`sudo apt-get install haskell-platform`

## Execução

Agora, clone o repositório do projeto.

Abra a pasta do projeto e abra o interpretador do Haskell com o comando `ghci` no terminal.

No interpretador, carrege o arquivo principal com o comando abaixo:

`:l Interface.hs`

Após isso, para rodar o programa, utilize a função menu, da seguinte forma:

`menu [[]] True`

Insira o caminho da imagem (na pasta doc já existem algumas imagens), por exemplo:

`./doc/unb.ppm`

Para finalizar, escolha os filtros e o nome da imagem com o(s) filtro(s) aplicado.

## Referências Bibliográficas

https://wiki.haskell.org/Library_for_PPM_images </br>
https://www.haskell.org/platform/ </br>
https://www.haskell.org/hoogle/
