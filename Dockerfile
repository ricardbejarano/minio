FROM golang:1-alpine AS build

ARG VERSION="RELEASE.2022-08-26T19-53-15Z"
ARG CHECKSUM="b3184c22fe5216520a03c2e6f4113ab9772558cbd9fc7197d87f7487b4783383"

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
