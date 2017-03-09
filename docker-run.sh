#!/bin/bash

echo "Starting application and webserver...";

echo "php -v";
php -v
echo "nginx -v";
nginx -v
echo "mysql -V";
mysql -V

echo "will start php";
service php7.1-fpm start
echo "php status below";
service php7.1-fpm status

echo "will start mysql";
service mysql start
echo "mysql status below";
service mysql status

echo "will start nginx";
service nginx start
echo "nginx status below";
service nginx status