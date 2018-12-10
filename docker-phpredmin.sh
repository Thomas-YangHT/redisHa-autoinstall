source ./CONFIG
NodeIP=`grep $HOSTNAME hosts|awk '{print $1}'`
docker rm phpredmin -f

docker run -p 8080:80 -d \
--name phpredmin \
-e "PHPREDMIN_DATABASE_REDIS_0_HOST=${NodeIP}" \
-e "PHPREDMIN_DATABASE_REDIS_0_PORT=${MasterPort}" \
-e "PHPREDMIN_DATABASE_REDIS_0_PASSWORD=${requirepass}" \
-e "PHPREDMIN_AUTH_USERNAME=admin" \
-v $PWD/config.dist.php.${NodeIP}:/var/www/html/phpredmin/config.dist.php \
-v $PWD/terminal.php:/var/www/html/phpredmin/controllers/terminal.php \
sasanrose/phpredmin
