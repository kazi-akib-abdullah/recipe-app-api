FROM python:3.8-alpine
MAINTAINER Kazi AKib Abdullah

ENV PYTHONUNBUFFERED 1
#ENV PYTHONPATH="/:$PYTHONPATH"
#ENV PYTHONPATH "${PYTHONPATH}:/app"

#RUN python3 -m pip install --upgrade pip
#RUN python3 -m pip install --upgrade pip setuptools wheel;
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
#RUN apk update && apk add python3-dev gcc libc-dev
RUN pip install --no-cache-dir -r requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user
