bespin-webapp-docker
====================

Dockerfile and docker-compose script for running bespin-api and bespin-ui

# Usage

The Dockerfile contained in web is used to build an image containing the Django (backend) and Ember (frontend) applications, hosted by a single Apache httpd server.

It also includes a docker-compose file that can deploy the image and its backing Postgres database

1. Create files `bespin-database.env` and `bespin-web.env`, based on the `.sample` files.
2. Create self signed certificates: 
```
mkdir certs
cd certs
openssl req -x509 -newkey rsa:4096 -keyout privkey.pem -out cacert.pem -days 365 -nodes
cd ..
```
3. Start the application with `docker-compose up -d`
4. Create a django superuser with `docker-compose run bespin-web create-superuser.sh`
5. Create a lando user (and token) with `docker-compose run bespin-web create-lando-user.sh`
6. Load sample data with `docker-compose run bespin-web load-sample-data.sh`
7. Visit [http://localhost](http://localhost)
8. Stop the service with `docker-compose down`
