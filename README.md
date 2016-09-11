# Certificar.me

Gerencie seus certificados online

## E como eu instalo isso no meu Ubuntu?

### Aconselhamos você a usar o gerenciador de versões Ruby (http://rvm.io)

    curl -sSL https://get.rvm.io | bash -s stable

### Instalando o Ruby

    rvm install 2.3.1

### Usamos o MongoDB, então instala ele lá!

    sudo apt-get install mongodb

### Usamos o Redis-Server, então instala ele lá!

    sudo apt-get install redis-server

### Instala também a biblioteca webkit, que é uma dependência do capybara-webkit

    sudo apt-get install qt5-default libqt5webkit5-dev

### Instalar o foreman para iniciar a aplicação

    gem install foreman

### MailCatcher (http://mailcatcher.me)

#### Instale o MailCatcher para testar o envio de e-mails localmente.

    gem install mailcatcher

#### Execute ele para ficar recebendo seus e-mails locais

    mailcatcher

### Baixa as dependências do projeto

    bundle install

Agora espera...

### Depois roda esse comando para adicionar uns dados no banco

    rake db:seed

### Se você estiver executando outra aplicação que utilize o sidekiq, é melhor rodar o comando

    redis-cli flushall

### Agora é só rodar e brincar!

    foreman start web

### Em seu navegador, abra o endereço abaixo para testar a aplicação

    localhost:5000

### Em seu navegador, abra o endereço abaixo para analisar as tarefas em segundo plano

    localhost:5000/admin/sidekiq

### Em seu navegador, abra o endereço abaixo para analisar os e-mails recebidos localmente

    localhost:1080

### Executar os testes com a geração do relatório de cobertura, que será gravado na pasta coverage.

    rails spec

## Licença

O Certificar.me é liberado sob a [MIT License](http://www.opensource.org/licenses/MIT).
