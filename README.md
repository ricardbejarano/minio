<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/apple/198/peacock_1f99a.png" width="120px"></p>
<h1 align="center">minio (container image)</h1>
<p align="center">Minimal container image of the <a href="https://min.io/">MinIO object storage server</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/minio`](https://hub.docker.com/r/ricardbejarano/minio):

- [`RELEASE.2020-08-07T01-23-07Z`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/minio/blob/master/Dockerfile) (about `61.6MB`)

### Quay

Available on [Quay](https://quay.io) as [`quay.io/ricardbejarano/minio`](https://quay.io/repository/ricardbejarano/minio):

- [`RELEASE.2020-08-07T01-23-07Z`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/minio/blob/master/Dockerfile) (about `61.6MB`)


## Features

* Super tiny (see [Tags](#tags))
* Compiled from source during build time
* Built `FROM scratch`, with zero bloat (see [Filesystem](#filesystem))
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Building

```bash
docker build -t minio .
```


## Configuration

### Volumes

- Mount your **data** at `/data`.
- Mount your **configuration** at `/config`.


## Filesystem

```
/
├── config/
├── data/
├── etc/
│   ├── group
│   ├── passwd
│   └── ssl/
│       └── certs/
│           └── ca-certificates.crt
└── minio
```


## License

See [LICENSE](https://github.com/ricardbejarano/minio/blob/master/LICENSE).
