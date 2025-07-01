#!/bin/bash

echo "Waiting for Vue build..."
while [ ! -f /app/mysite/templates/vue_index.html ]; do
  sleep 1
done

echo "Vue build found, starting Django..."
exec python manage.py runserver 0.0.0.0:8000

