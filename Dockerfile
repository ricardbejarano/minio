FROM alpine:3 AS build

ARG VERSION="RELEASE.2019-09-26T19-42-35Z"
ARG CHECKSUM="d4e93672b169152f759167c6ed2d6c911057bbe06284478ba467192b9c25d36d"

ADD https://dl.min.io/server/minio/release/linux-amd64/minio.$VERSION /tmp/minio

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/minio | awk '{print $1}')" ] && \
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
