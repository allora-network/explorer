FROM node:21-bookworm-slim as builder

WORKDIR /app
COPY . /app
RUN yarn --ignore-engines && \
    yarn build

###########
FROM nginx:1.25-bookworm

COPY --from=builder /app/dist/ /usr/share/nginx/html/
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]