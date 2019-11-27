ARG VERSION=lts-alpine

FROM node:${VERSION}

LABEL   maintainer="Sangram Chavan <schavan@outlook.com>" \
        architecture="amd64/x86_64" 

USER node

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    NODE_ENV="production" \
    NPM_CONFIG_PREFIX="/opt/src/.npm-global" \
    PATH="$PATH:/opt/src/.npm-global/bin"

WORKDIR /opt/src

VOLUME ["/opt/src"]

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod 777 /usr/local/bin/docker-entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["docker-entrypoint.sh"]
