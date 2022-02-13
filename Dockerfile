FROM python:3.8-alpine
MAINTAINER Kazi AKib Abdullah

ENV PYTHONUNBUFFERED 1

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade pip setuptools wheel;
COPY ./requirements.txt /requirements.txt

RUN apk update && apk add python3-dev gcc libc-dev
RUN python3 -m pip install --no-cache-dir -r requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
