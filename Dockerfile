FROM debian AS build

ARG MINIO_RELEASE="RELEASE.2019-07-10T00-34-56Z"
ARG MINIO_CHECKSUM="eb8d078a2787423dcb83ca516d5e7af194a2a8063086c435e0467ce53351c824"

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
