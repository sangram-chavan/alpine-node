
FROM sangram/alpine-mini:latest
LABEL   maintainer="Sangram Chavan <schavan@outlook.com>" \
        architecture="amd64/x86_64" 

ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL   org.label-schema.schema-version="1.0" \
        org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="Nodejs" \
        org.label-schema.description="NodeJs Docker image running on Alpine Linux" \
        org.label-schema.url="https://hub.docker.com/r/sangram/alpine-node" \
        org.label-schema.vcs-url="https://github.com/sangram-chavan/docker-images/alpine-node.git" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vendor="Open Source" \
        org.label-schema.version=$VERSION \
        org.label-schema.image.authors="Sangram Chavan <schavan@outlook.com>" \
        org.label-schema.image.vendor="Open Source" 

ENV VERSION=${VERSION} \
    NPM_VERSION=6 \
#   NODE_ENV="production" \
    NPM_CONFIG_PREFIX="/root/.npm-global" \
    PATH="$PATH:/root/.npm-global/bin"

COPY root/. /

RUN apk upgrade --no-cache -U && \
    apk add --no-cache curl gnupg libstdc++

RUN chmod a+x /usr/local/bin/docker-entrypoint.sh && \
    curl -sfSLO https://unofficial-builds.nodejs.org/download/release/v${VERSION}/node-v${VERSION}-linux-x64-musl.tar.xz && \
    curl -sfSLO https://unofficial-builds.nodejs.org/download/release/v${VERSION}/SHASUMS256.txt && \
    grep " node-v${VERSION}-linux-x64-musl.tar.xz\$" SHASUMS256.txt | sha256sum -c | grep ': OK$' && \
    tar -xf node-v${VERSION}-linux-x64-musl.tar.xz -C /usr --strip 1 && \
    rm node-v${VERSION}-linux-x64-musl.tar.xz

RUN npm install -g npm@${NPM_VERSION} && \
    npm install -g yarn && \
    find /usr/lib/node_modules/npm -type d \( -name test -o -name .bin \) | xargs rm -rf

RUN apk del curl gnupg && \
    rm -rf /SHASUMS256.txt /tmp/* /var/cache/apk/* \
    /usr/share/man/* /usr/share/doc /root/.npm /root/.node-gyp /root/.config \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/docs \
    /usr/lib/node_modules/npm/html /usr/lib/node_modules/npm/scripts && \
    { rm -rf /root/.gnupg || true; }


VOLUME ["/opt/src", "/root/.npm-global"]

ENTRYPOINT ["docker-entrypoint.sh"]

WORKDIR /opt/src