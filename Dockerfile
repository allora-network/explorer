FROM node:21-bookworm-slim as builder

WORKDIR /app
COPY . /app
RUN yarn --ignore-engines && \
    yarn build

###########
FROM nginx:1.25-bookworm

COPY --from=builder /app/dist/ /usr/share/nginx/html/

EXPOSE 80
