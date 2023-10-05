# Desafio para Fullstack
**Este documento descreve o passo a passo para rodar a aplicação referente ao desafio da vaga de Fullstack da Working Minds**

### Reforma Trabalhista

Conforme a Reforma Trabalhista, a partir de 11.11.2017 as férias poderão ser usufruídas em até 3 (três) períodos.
Sendo que um deles não poderá ser inferior a 14 dias corridos, e os demais não poderão ser inferiores a 5 dias corridos cada um.
Desta forma, é necessário poder cadastrar os colaboradores(Nome Cargo Data de Contratação)
Bem como os períodos de férias (pode-se cadastrar um ou mais períodos para cada colaborador): (Data de Início Data de Término)

Considere as seguintes regras para o cadastro de férias:
1. Cada colaborador ganha 30 dias de férias a cada período de 12 meses.
2. O primeiro período de férias só pode ser agendado para iniciar-se pelo menos 12 meses após a data de contratação.
3. Não deve permitir cadastro de períodos de férias que se sobreponham, para um mesmo colaborador.
4. A duração de cada período de férias não pode ser menor do que 10 dias.

## Considerações sobre o ambiente

* Uma image docker foi publicada no [Docker Hub](https://hub.docker.com/layers/leandrolasnor/ruby/wkm/images/sha256-27917c1f14cd8080bd2756144face385f5a2e1c57b5144ecc9e34defee1913e0?context=repo)

* Use o comando `docker compose up backend -d` para baixar a imagem e subir o container _wkm.rails_
* Use o comando `docker compose exec backend bundle exec rake db:migrate:reset` para criar o banco de dados
* Use o comando `docker compose exec backend bundle exec rake db:seed` para popular o banco de dados com alguns dados

```
# docker-compose.yml
version: '3.8'
services:
  backend:
    image: leandrolasnor/ruby:wkm
    container_name: wkm.rails
    stdin_open: true
    tty: true
    command: sh
    ports:
      - "3000:3000"
  
  frontend:
    image: leandrolasnor/ruby:wkm
    container_name: wkm.react
    stdin_open: true
    tty: true
    command: sh -c "yarn --cwd ./reacting start"
    ports:
      - "3001:3001"
    depends_on:
      - backend

```

## Passo a Passo de como executar a solução

_presumo que nesse momento seu ambiente esteja devidamente configurado e o banco de dados criado e populado_

* Use o comando `docker compose exec backend rails s` para subir o _rails_
* Em outro terminal rode o comando `docker compose up frontend -d` para criar e executar o container _wkm.react_
* Acesse [127.0.0.1:3001](http://127.0.0.1:3001)
* Uma lista de colaboradores será exibida na página inicial.

### Casos de uso
  - Contratar um novo colaborador
  - Listar os colaboradores
  - Demitir um colaborador
  - Agendar as férias de um colaborador(simple ou particionada)
  - Promover um colaborador