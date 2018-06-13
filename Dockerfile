FROM node:slim

LABEL maintainer="https://github.com/pluralcafe/barkeep" \
      description="Ambassador bot forked from mbilokonsky/ambassador"

ENV UID=992
ENV GID=992

WORKDIR /barkeep

RUN addgroup --gid ${GID} barkeep \
 && adduser --home /barkeep --shell /bin/sh --disabled-login --ingroup barkeep --uid ${UID} barkeep

COPY package.json index.js yarn.lock /barkeep/

RUN yarn install \
 && chown -R barkeep:barkeep /barkeep

USER barkeep

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["yarn", "start"]
