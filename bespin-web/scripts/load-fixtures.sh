#!/bin/sh

python manage.py loaddata ./fixtures/*.yaml /private/fixtures/*.yaml
