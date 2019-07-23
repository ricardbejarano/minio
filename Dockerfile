FROM debian AS build

ARG MINIO_RELEASE="RELEASE.2019-07-17T22-54-12Z"
ARG MINIO_CHECKSUM="96ae85abf1fcc2c0edb795aaeda42ae066310303a0a6ce92898f5bd61a0e7d67"

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
