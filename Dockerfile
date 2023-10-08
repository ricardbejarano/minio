FROM golang:1-alpine AS build

ARG VERSION="RELEASE.2023-10-07T15-07-38Z"
ARG CHECKSUM="1edcf95bf6f392c1f33d964261a4eb037c68967be8de7010c7f4fd3e83315a5a"

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
