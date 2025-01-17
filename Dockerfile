FROM python:3.10-alpine
LABEL authors="kim.reddick@icloud.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev musl-dev  \
        zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps


RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D dockuser
RUN chown dockuser:dockuser -R /app
RUN chown -R dockuser:dockuser /vol/
RUN chmod -R 755 /vol/web
USER dockuser
