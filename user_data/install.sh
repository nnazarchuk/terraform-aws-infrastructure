#!/bin/bash

sudo mkdir -p /var/www/app
sudo bash -c 'cat <<EOF > /var/www/app/index.html
<html>
    <head>
        <title>Hello World!</title>
    </head>
    <body>
        <h1>Hello from $(hostname -I)!</h1>
    </body>
</html>
EOF'

sudo yum -y install epel-release
sudo yum -y install nginx
sudo setenforce permissive
sudo chown nginx:nginx /var/www/app/index.html
sudo chmod -R 755 /var/www/app/index.html

sudo bash -c 'cat <<EOF > /etc/nginx/conf.d/app.conf
server {
    listen 9000;
    root /var/www/app;

    location / {
        index index.html;
    }
}
EOF'

sudo systemctl enable nginx
sudo systemctl start nginx
