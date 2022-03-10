# Create Network

```
docker network create lemp-network
```

# Run php-fpm with nginx

```
docker-compose -f docker-compose.nginx-php.yml up --build -d
```

# Run mysql + phpmyadmin + redis

```
docker-compose -f docker-compose.database.yml up --build -d
```

- Main Website (80) : http://localhost
- PhpMyAdmin (8000) : http://localhost:8000
- Redis (6379) : http://localhost:6379

<br>

> MySql & PhpMyAdmin Credential
<br>
user : root
<br>
 password : root
<br><br>
You can change password root in docker-compose.database.yml
<br>
**MYSQL_ROOT_PASSWORD** 

<br>
<br>

# Add new domain / vhost

1. Duplicate or copy .conf file in **/php/sites/template_http.conf.example** and rename to **/php/sites/dev.localhost.conf**

2. Open the file .conf and change all **domain.com** to **dev.localhost**

3. Go to **/php/sites/public** and create new directory **dev.localhost** and put your index.php or all your php files inside

4. Restart nginx-php docker :
```
   docker-compose -f docker-compose.nginx-php.yml up --build --force-recreate -d
```

5. Open your new vhost : http://dev.localhost

<br>

# Deploy to server with SSL certbot generator

1. Make sure you already running docker-compose for nginx-php
```
  docker ps
```

2. Add your domain in docker-compose.certbot.yml 
```
  environment:
    - DOMAINS : insert all your domain here separate with space
```
3. Before run certbot make sure you use nginx template with port 80 only. Use template in **/php/sites/template_http.conf.example**

4. Generate Diffie-Hellman parameter for DHE ciphersuites, to install 
```
  openssl dhparam -out ssl-dhparams.pem 4096
```

5. Move ssl-dhparams.pem to **/certbot/conf/ssl-dhparams.pem**

6. Run certbot docker
```
  docker-compose -f docker-compose.certbot.yml up --build --force-recreate -d
```

7. Edit your nginx domain conf and change to template **/php/sites/template_https.conf.example** to auto redirect SSL

8. Then restart nginx-phpfpm :
```
  docker-compose -f docker-compose.nginx-php.yml up --build --force-recreate -d
```

9. Open your domain with http:// and it will be redirect to => https://domain.com