FROM quay.io/dukegcb/bespin-api
MAINTAINER dan.leehr@duke.edu

RUN apt-get update && apt-get install -y \
  apache2 \
  libapache2-mod-wsgi

# Globally set DJANGO_SETTINGS_MODULE to settings_prod so we don't have to override it individually
ENV DJANGO_SETTINGS_MODULE bespin.settings_prod
ENV BESPIN_STATIC_ROOT /srv/static

RUN mkdir -p ${BESPIN_STATIC_ROOT}

# Collect the static files

# BESPIN_SECRET_KEY must be set for any manage.py tasks
# So we set it to a dummy value to run collectstatic, even though it is not used
RUN BESPIN_SECRET_KEY=DUMMY python manage.py collectstatic --noinput

COPY bespin-web.conf /etc/apache2/sites-available/
RUN a2ensite bespin-web
RUN a2dissite 000-default
RUN a2enmod rewrite

# Install the bespin UI app somewhere
ENV BESPIN_UI_ROOT /srv/ui
RUN mkdir ${BESPIN_UI_ROOT}
RUN curl -SL https://github.com/Duke-GCB/bespin-ui/releases/download/0.1.0/bespin-ui.tar.gz | tar -xzC $BESPIN_UI_ROOT


COPY start-apache.sh /scripts/
COPY wait-for-postgres.sh /scripts/

# set the command to start apache

EXPOSE 80

# Add /scripts to the PATH
ENV PATH ${PATH}:/scripts/

ENTRYPOINT ["/scripts/wait-for-postgres.sh"]
CMD ["/scripts/start-apache.sh"]
