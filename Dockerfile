# syntax=docker/dockerfile:experimental
FROM php:7.3-cli-alpine

RUN apk add --no-cache --virtual .build-deps \
    g++ make autoconf \
    && pecl update-channels \
    && pecl install ast -o -f \
    && pecl install pcov -o -f \
    && docker-php-ext-enable ast pcov \
    && pecl clear-cache \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && rm -rf /tmp/pear \
    && apk del --purge .build-deps

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["entrypoint"]
CMD ["php"]
