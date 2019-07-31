<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/apple/198/peacock_1f99a.png" width="120px"></p>
<h1 align="center">minio (container image)</h1>
<p align="center">Minimal container image of the <a href="https://min.io/">MinIO object storage server</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/minio`](https://hub.docker.com/r/ricardbejarano/minio):

- [`RELEASE.2019-07-24T02-02-23Z`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/minio/blob/master/Dockerfile)

### Quay

Available on [Quay](https://quay.io) as [`quay.io/ricardbejarano/minio`](https://quay.io/repository/ricardbejarano/minio):

- [`RELEASE.2019-07-24T02-02-23Z`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/minio/blob/master/Dockerfile)


## Features

* Super tiny (about `42.9MB`)
* Binary pulled from official sources during build time
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
│   └── passwd
└── minio
```


## License

See [LICENSE](https://github.com/ricardbejarano/minio/blob/master/LICENSE).
