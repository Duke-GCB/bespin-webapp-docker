#!/bin/sh

python manage.py makeusertoken ${LANDO_DJANGO_USERNAME} ${LANDO_DJANGO_PASSWORD} ${LANDO_DJANGO_TOKEN}
