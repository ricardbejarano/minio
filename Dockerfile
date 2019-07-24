FROM debian AS build

ARG MINIO_RELEASE="RELEASE.2019-07-24T02-02-23Z"
ARG MINIO_CHECKSUM="30cc447c0cc0b696e17ed7a6affe19c9d9c6bbca59a7e1fb257cf9ac90684b54"

ADD https://dl.min.io/server/minio/release/linux-amd64/minio.$MINIO_RELEASE /tmp/minio

RUN [ "$MINIO_CHECKSUM" = "$(sha256sum /tmp/minio | awk '{print $1}')" ] && \
    chmod +x /tmp/minio


FROM scratch

COPY --from=build --chown=100:100 /tmp/minio /

COPY --chown=100:100 rootfs /

USER 100:100
VOLUME ["/data"]
EXPOSE 9000/tcp
ENTRYPOINT ["/minio"]
CMD ["server", "/data"]
