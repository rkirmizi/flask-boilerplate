FROM python:3.7.4-alpine3.9
RUN mkdir /service
WORKDIR /service
ENV PYTHONPATH=/service
RUN pip install pipenv
RUN apk add --no-cache --virtual .build-deps gcc musl-dev python-dev build-base
RUN apk add --no-cache openssl-dev libffi-dev
RUN apk add postgresql-dev
RUN rm -rf /var/cache/apk/*

COPY Pipfile Pipfile
COPY  Pipfile.lock Pipfile.lock
RUN pipenv install --deploy --system -d

ADD ./app /service/app/
