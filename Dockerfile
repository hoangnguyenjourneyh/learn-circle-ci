FROM node:10.14

ADD ./ ./

ENV NODE_ENV "production"

RUN yarn install && yarn run build

EXPOSE 3000 443

CMD ["yarn", "run", "start"]
