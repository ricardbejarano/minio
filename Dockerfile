FROM golang:1 AS build

ARG VERSION="RELEASE.2020-01-03T19-12-21Z"
ARG CHECKSUM="5676c40de64503c99b48e7738caa5b82c1239b93c76d3319ee11c5b6d37b07ff"

ADD https://github.com/minio/minio/archive/$VERSION.tar.gz /tmp/minio.tar.gz

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/minio.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/minio.tar.gz && \
    mv /tmp/minio-$VERSION /tmp/minio && \
    cd /tmp/minio && \
	    make build && \
    echo "nogroup:*:100:nobody" > /tmp/group && \
    echo "nobody:*:100:100:::" > /tmp/passwd && \
    mkdir -p /tmp/data /tmp/config


FROM scratch

COPY --from=build --chown=100:100 /tmp/minio/minio /
COPY --from=build --chown=100:100 /tmp/data /data
COPY --from=build --chown=100:100 /tmp/config /config
COPY --from=build --chown=100:100 /tmp/group \
                                  /tmp/passwd \
                                  /etc/

USER 100:100
VOLUME ["/data", "/config"]
EXPOSE 9000/tcp
ENTRYPOINT ["/minio"]
CMD ["--config-dir", "/config", "server", "/data"]
