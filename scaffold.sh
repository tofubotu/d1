docker run --rm -v $PWD:/app -w /app python:3.11 bash -c "\
  pip install -r requirements.txt && \
  django-admin startproject mysite ."

