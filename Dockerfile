FROM alpine:latest
RUN mkdir /app
COPY config.txt /app/config.txt
RUN apk update
RUN apk add nginx && touch /build-2.0 && mkdir -p /run/nginx && touch /index.html
RUN echo "HELLO TEAM AQUA!" >> /index.html
COPY default.conf /etc/nginx/conf.d/
CMD ["nginx", "-g", "daemon off;"]
