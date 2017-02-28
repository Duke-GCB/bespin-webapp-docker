FROM quay.io/dukegcb/bespin-api
MAINTAINER dan.leehr@duke.edu

RUN apt-get update && apt-get install -y \
  apache2 \
  libapache2-mod-wsgi

ENV DJANGO_SETTINGS_MODULE bespin.settings_prod
ENV BESPIN_STATIC_ROOT /srv/static

RUN mkdir -p ${BESPIN_STATIC_ROOT}

# Collect the static files
# This will need ENV vars?

# BESPIN_SECRET_KEY must be set for any manage.py tasks
# So we set it to a dummy value to run collectstatic, even though it is not used

RUN BESPIN_SECRET_KEY=DUMMY python manage.py collectstatic --noinput

COPY bespin-web.conf /etc/apache2/sites-available/
RUN a2ensite bespin-web

# Install the bespin UI app somewhere

COPY start-apache.sh /scripts/
# set the command to start apache

EXPOSE 80

CMD ["/scripts/start-apache.sh"]
