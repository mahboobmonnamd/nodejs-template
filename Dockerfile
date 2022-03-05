ARG someValue

FROM node:14.2.0-alphine3.11 AS builder
ENV key=$someValue
WORKDIR /app
RUN chown -R node:node /app
COPY --chown=node:node ./package.json ./package-lock.json ./tsconfig.json ./
RUN npm ci
RUN npm run build

FROM node:14.2.0-alphine3.11 AS prod-dep
WORKDIR /app
RUN chown -R node:node /app
COPY --chown=node:node ./package.json ./package-lock.json ./
RUN npm ci --only=prod

FROM  node:14.2.0-alphine3.11
ENV NODE_ENV production
ENV key=$someValue
WORKDIR /app
RUN chown -R node:node /app
USER node
COPY --chown=node:node ./package.json ./package-lock.json ./
COPY --chown=node:node --from=prod-dependencies /app/node_modules ./node_modules

EXPOSE 8002
CMD ["npm", "start"]