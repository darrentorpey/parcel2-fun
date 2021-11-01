FROM node:16

ARG APP_DIR=/app

RUN mkdir ${APP_DIR}

WORKDIR ${APP_DIR}

COPY ./package.json       ${APP_DIR}/
COPY ./package-lock.json  ${APP_DIR}/

RUN npm ci --production=false

ENV NODE_ENV=development

COPY ./src ${APP_DIR}/src

ENTRYPOINT ["npx"]
CMD ["parcel", "serve", "src/index.js"]
