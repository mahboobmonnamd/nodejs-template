FROM node:12

RUN mkdir /app
WORKDIR /app

COPY ./package.json ./package-lock.json ./tsconfig.json ./
RUN npm ci

EXPOSE 8002
CMD ["npm", "start"]
