#!/bin/bash
export ROOT_PATH=/home/ivan/hosts/docker-symfony
cd $ROOT_PATH/symfony && git pull
echo docker-compose stop
cd $ROOT_PATH && docker-compose stop

echo  remove data folder 
cd $ROOT_PATH && sudo rm -rf data


echo prune volumes 
docker system prune -a -f --volumes  

echo docker-compose up 
cd $ROOT_PATH && docker-compose build && docker-compose up -d --remove-orphans

echo run composer install 
docker exec php-fpm sh  -c 'cd /var/www/symfony && composer install'

echo run  php bin/console d:m:migrate
docker exec php-fpm sh  -c 'cd /var/www/symfony && php bin/console --no-interaction  d:m:migrate'

echo run  php bin/console doctrine:mongodb:schema:update
docker exec php-fpm sh  -c 'cd /var/www/symfony && php bin/console doctrine:mongodb:schema:update'

echo run  php bin/console d:f:load --append
docker exec php-fpm sh  -c 'cd /var/www/symfony  && php bin/console d:f:load --append'

echo run  php bin/console app:awin:download
docker exec php-fpm sh  -c 'cd /var/www/symfony && php bin/console app:awin:download'

echo run  php bin/console app:adrecord:download
docker exec php-fpm sh  -c 'cd /var/www/symfony && php bin/console app:adrecord:download'

echo run  php bin/console app:adtraction:download
docker exec php-fpm sh -c 'cd /var/www/symfony  && php bin/console app:adtraction:download'

echo run yarn install
docker exec php-fpm sh -c 'cd /var/www/symfony  && yarn install'

echo yarn encore dev
docker exec php-fpm sh -c 'cd /var/www/symfony  && yarn encore dev'

echo Done!!

