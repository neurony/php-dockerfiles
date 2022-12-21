ARG VS
ARG ORG
FROM $ORG/php-fpm:$VS
ARG VS

ENV COMPOSER_ALLOW_SUPERUSER=1

COPY *.sh ./
RUN bash -ex php-qa.sh $VS

EXPOSE  9000

LABEL maintainer="Mihai Stancu <mihai.stancu@neurony.ro>"
