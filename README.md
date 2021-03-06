# https://github.com/kun391/nino

## Maintained by: [KUN](https://github.com/kun391/nino)

This is the Git repo of the DOCKER NGINX-NODEJS 14.16.0


# Tutorial

Follow these steps to deploy a simple  _Hello, world!_ app into production:

## Dockerfile

This is the step I hope to be able to eliminate eventually. 

```
vim Dockerfile
```

Copy and save the following:

```
# Dockerfile
FROM kun391/nino:3.0

MAINTAINER Some Guy 

....


WORKDIR /your-application-dir

....

```

## Start FE with docker-compose.yml

Step 1
```
vim docker-compose.yml
```
Copy and save the following:

```
version: '3'
services:
  # container for API
  app:
    image: kun391:nino:3.0
    ports:
      - 8000:80
    depends_on:
      - db
    volumes:
      - .:/usr/src/app
      - ./demo/build:/usr/share/nginx/html:ro
      - ./conf/nginx.conf:/etc/nginx/sites-available/default
   #working_dir: /usr/src/app/demo
    command:
    - /bin/bash
    - -c
    - |
      service nginx restart
      tail -f /dev/null 2>&1
    restart: on-failure
  ...

```

Assuming all steps were followed correctly, this will pull all the required images and start serving the app:
```
docker-compose up -d
```

Step 2
Copy and save the following - config/nginx.conf:

```
# config/nginx.conf

server {
    listen 80;
    # gzip config
    gzip on;
    gzip_min_length 1k;
    gzip_comp_level 9;
    gzip_types text/plain text/css text/javascript application/json application/javascript application/x-javascript application/xml;
    gzip_vary on;
    gzip_disable "MSIE [1-6]\.";

    root /usr/share/nginx/html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}

```

NOW, We can access this with localhost:8000 for FE

# Contributing


# License
MIT