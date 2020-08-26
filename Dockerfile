FROM golang:1 AS build

ARG VERSION="RELEASE.2020-08-26T00-00-49Z"
ARG CHECKSUM="05a8e287e0cc39c3a34593d7fe78b945350783210e3cd6d0c8a678afcb84bc12"

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
