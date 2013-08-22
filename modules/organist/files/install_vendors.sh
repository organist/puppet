#! /bin/bash
cd /home/deploy/organist
export COMPOSER_HOME=/home/deploy/organist
curl -sS https://getcomposer.org/installer | php
php composer.phar install
app/console doctrine:database:create
app/console doctrine:schema:create
