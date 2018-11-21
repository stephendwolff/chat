#!/bin/bash
set -e
set -x

# nginx

until nc -z -v -w30 db 3306
do
  echo "Waiting for database connection..."
  # wait for 5 seconds before check again
  sleep 5
done

echo "DB Connected"

python manage.py makemigrations --noinput --settings=$DJANGO_SETTINGS_MODULE
python manage.py migrate --noinput --settings=$DJANGO_SETTINGS_MODULE
python manage.py collectstatic --noinput
python manage.py runserver 0.0.0.0:8000 --settings=$DJANGO_SETTINGS_MODULE
