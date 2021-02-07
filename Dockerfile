FROM golang:1-alpine AS build

ARG VERSION="RELEASE.2021-02-07T01-31-02Z"
ARG CHECKSUM="4241745d49606f186da7bbd3ba9e48b5e3fde084a3af9b9c14e69f83d3edc452"

ADD https://github.com/minio/minio/archive/$VERSION.tar.gz /tmp/minio.tar.gz

RUN [ "$(sha256sum /tmp/minio.tar.gz | awk '{print $1}')" = "$CHECKSUM" ] && \
    apk add bash ca-certificates git make perl && \
    tar -C /tmp -xf /tmp/minio.tar.gz && \
    mkdir -p /go/src/github.com/minio && \
    mv /tmp/minio-$VERSION /go/src/github.com/minio/minio && \
    cd /go/src/github.com/minio/minio && \
      make build

RUN mkdir -p /rootfs/bin && \
      cp /go/src/github.com/minio/minio/minio /rootfs/bin/ && \
    mkdir -p /rootfs/config && \
    mkdir -p /rootfs/data && \
    mkdir -p /rootfs/etc && \
      echo "nogroup:*:10000:nobody" > /rootfs/etc/group && \
      echo "nobody:*:10000:10000:::" > /rootfs/etc/passwd && \
    mkdir -p /rootfs/etc/ssl/certs && \
      cp /etc/ssl/certs/ca-certificates.crt /rootfs/etc/ssl/certs/


FROM scratch

COPY --from=build --chown=10000:10000 /rootfs /

USER 10000:10000
VOLUME ["/config", "/data"]
EXPOSE 9000/tcp
ENTRYPOINT ["/bin/minio"]
CMD ["--config-dir", "/config", "server", "/data"]
