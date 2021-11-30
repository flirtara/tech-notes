FROM python:latest
LABEL authors="kim.reddick@icloud.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN useradd -ms /bin/bash dockuser
RUN chown dockuser:dockuser -R /app
USER dockuser
