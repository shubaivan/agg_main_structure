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

echo run  php bin/console --no-interaction doctrine:migrations:migrate --em=manager_mysql --configuration=./config/migration_conf/doctrine_migrations_mysql.yaml
docker exec php-fpm sh  -c 'cd /var/www/symfony && php bin/console --no-interaction doctrine:migrations:migrate --em=manager_mysql --configuration=./config/migration_conf/doctrine_migrations_mysql.yaml'

echo run  php bin/console doctrine:mongodb:schema:update
docker exec php-fpm sh  -c 'cd /var/www/symfony && php bin/console doctrine:mongodb:schema:update'

echo run  php bin/console a:i
docker exec php-fpm sh  -c 'cd /var/www/symfony && php bin/console a:i'

echo run  php bin/console d:f:load -n --em=default --group=my_pg_fixtures
docker exec php-fpm sh  -c 'cd /var/www/symfony  && php bin/console d:f:load -n --em=default --group=my_pg_fixtures'

echo run  php bin/console d:f:load -n --em=default --group=my_pg_fixtures_strategies
docker exec php-fpm sh  -c 'cd /var/www/symfony  && php bin/console d:f:load -n --em=default --group=my_pg_fixtures_strategies'

echo run  php bin/console d:f:load -n --em=manager_mysql --group=my_mysql
docker exec php-fpm sh  -c 'cd /var/www/symfony  && php bin/console d:f:load -n --em=manager_mysql --group=my_mysql'


echo run  php bin/console app:awin:download
docker exec php-fpm sh  -c 'cd /var/www/symfony && php bin/console app:awin:download'

echo run  php bin/console app:adrecord:download
docker exec php-fpm sh  -c 'cd /var/www/symfony && php bin/console app:adrecord:download'

echo run  php bin/console app:adtraction:download
docker exec php-fpm sh -c 'cd /var/www/symfony  && php bin/console app:adtraction:download'

echo run  php bin/console app:trade_doubler:download
docker exec php-fpm sh -c 'cd /var/www/symfony  && php bin/console app:trade_doubler:download'

echo run yarn install
docker exec php-fpm sh -c 'cd /var/www/symfony  && yarn install'

echo yarn encore dev
docker exec php-fpm sh -c 'cd /var/www/symfony  && yarn encore dev'

echo Done!!

