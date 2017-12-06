FROM ubuntu:xenial

RUN apt-get update && \
    apt-get install -y build-essential \
        python3 python3-pip python3-dev \
        libreadline-dev libssl-dev libbz2-dev libjpeg8-dev libpcre3 libpcre3-dev \
        libmagickwand-dev rdate libyaml-dev libxslt1-dev

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi

RUN mkdir /djproj
WORKDIR /djproj
ADD . /djproj/

ENV DJANGO_SETTINGS_MODULE "askbot.settings"

RUN pip3 install -r requirements.txt

EXPOSE 8080
USER uwsgi

CMD ["uwsgi", "--http", "0.0.0.0:8080", "--wsgi-file", "/djproj/askbot/wsgi.py"]
