FROM debian:11-slim
RUN apt-get update \
 && apt-get install --assume-yes --no-install-recommends \
    apache2 \
    make \
    node-typescript \
    webpack \
 && apt-get clean \
 && rm --recursive /var/lib/apt/lists/*
WORKDIR /usr/local/src/acid-banger
COPY . .
RUN make DESTDIR=/var/www/html install
CMD ["/usr/sbin/apache2ctl","-DFOREGROUND"]
EXPOSE 80/tcp
