FROM alpine AS build

ARG MINIO_RELEASE="RELEASE.2019-07-24T02-02-23Z"
ARG MINIO_CHECKSUM="30cc447c0cc0b696e17ed7a6affe19c9d9c6bbca59a7e1fb257cf9ac90684b54"

ADD https://dl.min.io/server/minio/release/linux-amd64/minio.$MINIO_RELEASE /tmp/minio

RUN [ "$MINIO_CHECKSUM" = "$(sha256sum /tmp/minio | awk '{print $1}')" ] && \
    chmod 770 /tmp/minio && \
    echo "nogroup:*:100:nobody" > /tmp/group && \
    echo "nobody:*:100:100:::" > /tmp/passwd && \
    mkdir -p /tmp/data /tmp/config


FROM scratch

COPY --from=build --chown=100:100 /tmp/minio /
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
