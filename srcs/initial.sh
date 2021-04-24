# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    initial.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bdemirka <bdemirka@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/24 19:23:49 by bdemirka          #+#    #+#              #
#    Updated: 2021/04/24 21:30:25 by bdemirka         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

APP_PATH="/var/www/localhost"

mkdir $APP_PATH

service mysql start
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# SSL
mkdir /etc/nginx/ssl
chmod -R 600 /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 3650 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=US/ST=Californa/L=Fremont/O=42/OU=bdemirka/CN=localhost"

#NGINX
cp /tmp/nginx/nginx.conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default

echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#PHPMYADMIN
mkdir $APP_PATH/phpmyadmin

tar -xvf  /tmp/phpmyadmin/phpMyAdmin-5.0.2-english.tar.gz -C $APP_PATH  > /dev/null
mv $APP_PATH/phpMyAdmin-5.0.2-english/* $APP_PATH/phpmyadmin
rm -r $APP_PATH/phpMyAdmin-5.0.2-english

cp /tmp/phpmyadmin/config.inc.php $APP_PATH/phpmyadmin

#WORDPRESS
tar -zxf /tmp/wordpress/wordpress-5.7.1.tar.gz -C $APP_PATH
chown -R www-data:www-data  $APP_PATH
cp /tmp/wordpress/wp-config.php $APP_PATH/wordpress

service php7.3-fpm start
service nginx start

cd /
bash
