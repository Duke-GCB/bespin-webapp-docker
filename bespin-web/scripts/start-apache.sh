#!/usr/bin/env bash

# ensure database is migrated before each start of the production application
python manage.py migrate

create-lando-user.sh
load-sample-data.sh

apachectl -DFOREGROUND
