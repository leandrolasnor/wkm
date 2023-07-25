# WKM
Reforma Trabalhista

Conforme a Reforma Trabalhista, a partir de 11.11.2017 as férias poderão ser usufruídas em até 3 (três) períodos.
Sendo que um deles não poderá ser inferior a 14 dias corridos, e os demais não poderão ser inferiores a 5 dias corridos cada um.
Desta forma, é necessário poder cadastrar os colaboradores(Nome Cargo Data de Contratação)
Bem como os períodos de férias (pode-se cadastrar um ou mais períodos para cada colaborador): (Data de Início Data de Término)

Considere as seguintes regras para o cadastro de férias:
1. Cada colaborador ganha 30 dias de férias a cada período de 12 meses.
2. O primeiro período de férias só pode ser agendado para iniciar-se pelo menos 12 meses após a data de contratação.
3. Não deve permitir cadastro de períodos de férias que se sobreponham, para um mesmo colaborador.
4. A duração de cada período de férias não pode ser menor do que 10 dias.


### Colocando as coisas para funcionar
#

#### Faça download da pasta `.devcontainer` e pelo terminal rode
```docker compose up -d```

### Após acessar o container de desenvolvimento, rode os testes
```rspec spec```

### Prepare e Suba a API(3000) rodando
```rails db:reset && rails s -b 0.0.0.0```

### Suba o Front(3001) rodando
```yarn --cwd ./reacting start```