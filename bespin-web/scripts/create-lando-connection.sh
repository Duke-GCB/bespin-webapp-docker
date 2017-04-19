#!/bin/sh

python manage.py makelandoconnection ${RABBIT_HOST} ${RABBIT_USERNAME} ${RABBIT_PASSWORD} ${RABBIT_QUEUENAME}


