FROM golang:1 AS build

ARG VERSION="RELEASE.2020-12-12T08-39-07Z"
ARG CHECKSUM="196dcacad326139f9b0504f5711a60a3c89daa0cf21accd28ec6cdd7abc9e272"

ADD https://github.com/minio/minio/archive/$VERSION.tar.gz /tmp/minio.tar.gz

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/minio.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/minio.tar.gz && \
    apt update && \
    apt install -y ca-certificates && \
    cd /tmp/minio-$VERSION && \
      make build

RUN mkdir -p /rootfs/etc/ssl/certs /rootfs/config /rootfs/data && \
    cp /tmp/minio-$VERSION/minio /rootfs/ && \
    echo "nogroup:*:100:nobody" > /rootfs/etc/group && \
    echo "nobody:*:100:100:::" > /rootfs/etc/passwd && \
    cp /etc/ssl/certs/ca-certificates.crt /rootfs/etc/ssl/certs/


FROM scratch

COPY --from=build --chown=100:100 /rootfs /

USER 100:100
VOLUME ["/data", "/config"]
EXPOSE 9000/tcp
ENTRYPOINT ["/minio"]
CMD ["--config-dir", "/config", "server", "/data"]
