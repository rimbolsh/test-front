# build stage
FROM node:lts-alpine as build-stage
COPY package*.json /app/
WORKDIR /app

RUN npm install --production

# build 시 필요한 lib nuxt 사용 시 테스트 해봐야함 
RUN npm install @vue/cli-service
RUN npm install @vue/cli-plugin-babel


COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

