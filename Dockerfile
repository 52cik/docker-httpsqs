FROM alpine:3.6 AS builder

COPY /source /source

RUN echo "http://mirrors.aliyun.com/alpine/v3.6/main" > /etc/apk/repositories \
  && echo "http://mirrors.aliyun.com/alpine/v3.6/community" >> /etc/apk/repositories \
  && apk add --no-cache zlib-dev bzip2-dev \
  && apk add --no-cache --virtual .build-deps alpine-sdk bsd-compat-headers \
  && tar -xzf /source/httpsqs-1.7.tar.gz -C /source \
  && tar -xzf /source/libevent-2.0.12-stable.tar.gz -C /source \
  && tar -xzf /source/tokyocabinet-1.4.47.tar.gz -C /source \
  && cd /source/libevent-2.0.12-stable \
  && ./configure --prefix=/usr/local/libevent-2.0.12-stable \
  && make \
  && make install \
  && cd /source/tokyocabinet-1.4.47 \
  && ./configure --prefix=/usr/local/tokyocabinet-1.4.47 \
  && make \
  && make install \
  && cd /source/httpsqs-1.7 \
  && make \
  && make install \
  && cd / \
  && rm -rf /source \
  && apk del .build-deps

FROM alpine:3.6

COPY --from=builder /usr/bin/httpsqs /usr/bin/httpsqs
COPY --from=builder /usr/lib /usr/lib
COPY --from=builder /usr/local /usr/local
COPY run_httpsqs.sh /run_httpsqs.sh

RUN chmod +x /run_httpsqs.sh \
  && ulimit -SHn 65535

VOLUME /data

CMD [ "/run_httpsqs.sh" ]
