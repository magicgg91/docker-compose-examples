version: '2'

services:
  db:
    image: mariadb:10.1
    environment:
      MYSQL_ROOT_PASSWORD: your_mysql_root_password
      MYSQL_USER: filerun
      MYSQL_PASSWORD: filerun_password
      MYSQL_DATABASE: filerun_database
    volumes:
      - /filerun/db:/var/lib/mysql

  web:
    image: filerun/filerun
    environment:
      FR_DB_HOST: db
      FR_DB_PORT: 3306
      FR_DB_NAME: filerun_database
      FR_DB_USER: filerun
      FR_DB_PASS: filerun_password
      APACHE_RUN_USER: www-data
      APACHE_RUN_USER_ID: 33
      APACHE_RUN_GROUP: www-data
      APACHE_RUN_GROUP_ID: 33
    depends_on:
      - db
    links:
      - db:db
    ports:
      - "12880:80"
    volumes:
      - /filerun/html:/var/www/html
      - /home/mouflo:/user-files
