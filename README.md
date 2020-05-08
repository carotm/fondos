# Fondos

Script para automatizar la obtención de los fondos actuales de cuprum

## Prerequisitos

* Ruby ( mi versión: 2.6.3p62)
* Selenium-webdriver Gem (`gem install selenium-webdriver`)
* Chromedriver (mi versión 81.0.4044.138) https://chromedriver.chromium.org/downloads

## Uso

* Configurar variables de ambiente RUT y PASSWORD

```shell
export RUT=XXXXXX
export PASSWORD=XXXXX
```

* Correr el script: 

```shell 
ruby fondos.rb
```

Se puede configurar crontab para ejecutarlo diariamente por ej añadir `crontab -e`

```
01 17 * * * cd path/to/folder && source .env && ./fondos.rb >stdout.log 2>stderr.log
```