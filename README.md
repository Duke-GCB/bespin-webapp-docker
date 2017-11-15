bespin-webapp-docker
====================

## Archived

**This repo is no longer active.** Apache+wsgi build has moved into  [bespin-api](https://github.com/Duke-GCB/bespin-api/tree/master/apache-docker).

# Usage

The Dockerfile contained in web is used to build an image containing the Django (backend), hosted by Apache httpd.
The Ember frontend application is not included in the image, but should be downloaded from its release and mounted at `/srv/ui/`

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
