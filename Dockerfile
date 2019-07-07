FROM debian AS build

ARG MINIO_RELEASE="RELEASE.2019-07-05T21-20-21Z"
ARG MINIO_CHECKSUM="42eed36ac28691d20b35cf1600225213e78df64f18107e30bd647b7c9b566b4a"

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
