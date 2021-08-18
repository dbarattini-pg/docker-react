FROM node:lts-alpine AS builder
ENV NODE_ENV=production
EXPOSE 80
WORKDIR /app
COPY package.json .
RUN yarn
COPY . .
RUN yarn build

FROM nginx:stable-alpine
COPY --from=builder /app/build /usr/share/nginx/html
# nginx image already has the correct CMD to start nginx