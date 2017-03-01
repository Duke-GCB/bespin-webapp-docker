#!/usr/bin/env bash

# ensure database is migrated before each start of the production application
python manage.py migrate

# Check if any data needs to be loaded
# if [ -f /etc/external/fixtures.json ]; then
#   /usr/local/bin/python manage.py loaddata /etc/external/fixtures.json
# fi

# Update the variable names

apachectl -DFOREGROUND
