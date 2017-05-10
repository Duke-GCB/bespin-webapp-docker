FROM danlynn/ember-cli:2.13.1 as builder
ARG BESPIN_UI_VERSION
ARG BESPIN_JOB_WATCHER_URL
ENV BESPIN_UI_VERSION ${BESPIN_UI_VERSION:-master}
ENV JOB_WATCHER_URL=${BESPIN_JOB_WATCHER_URL:-wss://bespin-ws-dev.gcb.duke.edu}
WORKDIR /src
RUN useradd -m ember
RUN chown -R ember /src
USER ember
RUN git clone https://github.com/Duke-GCB/bespin-ui.git
WORKDIR /src/bespin-ui
RUN git checkout $BESPIN_UI_VERSION
RUN npm install
RUN bower install
RUN ember build --environment production

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
COPY --from=builder /src/bespin-ui/dist $BESPIN_UI_ROOT

COPY scripts /scripts

# set the command to start apache

EXPOSE 80

# Add /scripts to the PATH
ENV PATH ${PATH}:/scripts/

ENTRYPOINT ["/scripts/wait-for-postgres.sh"]
CMD ["/scripts/start-apache.sh"]
