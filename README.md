bespin-webapp-docker
====================

Dockerfile and docker-compose script for running bespin-api and bespin-ui

# Usage

The Dockerfile contained in web is used to build an image containing the Django (backend) and Ember (frontend) applications, hosted by a single Apache httpd server.

It also includes a docker-compose file that can deploy the image and its backing Postgres database

1. Create files `bespin-database.env` and `bespin-web.env`, based on the `.sample` files.
2. Start the application with `docker-compose up -d`
3. Create a django superuser with `docker-compose run bespin-web create-superuser.sh`
4. Create a lando user (and token) with `docker-compose run bespin-web create-lando-user.sh`
5. Load sample data with `docker-compose run bespin-web load-sample-data.sh`
6. Visit [http://localhost](http://localhost)
7. Stop the service with `docker-compose down`
