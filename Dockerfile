ARG VERSION=lts-alpine

FROM node:${VERSION}

LABEL   maintainer="Sangram Chavan <schavan@outlook.com>" \
        architecture="amd64/x86_64" 

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    NODE_ENV="production" \
    NPM_CONFIG_PREFIX="/root/.npm-global" \
    PATH="$PATH:/root/.npm-global/bin"

WORKDIR /opt/src

VOLUME ["/opt/src", "/root/.npm-global"]

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod 777 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
