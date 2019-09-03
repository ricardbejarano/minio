FROM alpine:3 AS build

ARG VERSION="RELEASE.2019-08-29T00-25-01Z"
ARG CHECKSUM="9597ae3bb375bd937b63b10b3b2ba66c4419f4a77d8f81d60f752893e91091fb"

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
