[![Maintainability](https://api.codeclimate.com/v1/badges/50541fba39cd88576d9f/maintainability)](https://codeclimate.com/github/tasafo/certifico/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/50541fba39cd88576d9f/test_coverage)](https://codeclimate.com/github/tasafo/certifico/test_coverage) [![Build Status](https://travis-ci.org/tasafo/certifico.svg?branch=master)](https://travis-ci.org/tasafo/certifico) [![security](https://hakiri.io/github/tasafo/certifico/master.svg)](https://hakiri.io/github/tasafo/certifico/master)

# Certifico

Gerencie seus certificados online

## E como eu instalo isso no meu Ubuntu?

### Aconselhamos você a usar o gerenciador de versões [Ruby](http://rvm.io)

    curl -sSL https://get.rvm.io | bash -s stable

### Instalando o Ruby

    rvm install 2.7.3

### Inicia os bancos de dados [MongoDB](https://www.mongodb.com/) e [Redis](https://redis.io/) instalados via [Docker compose](https://docs.docker.com/compose/)

    docker-compose up

### Instala o chromium para executar os testes de aceitação

    sudo apt-get install chromium-browser

### [MailCatcher](http://mailcatcher.me)

#### Instale o MailCatcher para testar o envio de e-mails localmente.

    gem install mailcatcher

#### Execute ele para ficar recebendo seus e-mails locais

    mailcatcher

### Baixa as dependências do projeto

    bundle install

### Copie o exemplo e depois edite o arquivo de configurações

    cp .env-development .env

### Depois roda esse comando para adicionar uns dados no banco

    rails db:seed

### Se você estiver executando outra aplicação que utilize o sidekiq, é melhor rodar o comando

    redis-cli flushall

### Instalar o foreman para iniciar a aplicação

    gem install foreman

### Agora é só rodar e brincar!

    foreman start

### Em seu navegador, abra o endereço abaixo para testar a aplicação

    localhost:5000

### Em seu navegador, abra o endereço abaixo para analisar as tarefas em segundo plano

    localhost:5000/admin/sidekiq

### Em seu navegador, abra o endereço abaixo para analisar os e-mails recebidos localmente

    localhost:1080

### Executar os testes com a geração do relatório de cobertura, que será gravado na pasta coverage.

    rails spec

## Licença

O Certifico é liberado sob a [MIT License](http://www.opensource.org/licenses/MIT).
