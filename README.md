<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/apple/198/peacock_1f99a.png" width="120px"></p>
<h1 align="center">minio (container image)</h1>
<p align="center">Built-from-source container image of the <a href="https://minio.io">MinIO</a> object storage server</p>


## Tags

### Docker Hub

Available on Docker Hub as [`docker.io/ricardbejarano/minio`](https://hub.docker.com/r/ricardbejarano/minio):

- [`RELEASE.2021-08-20T18-32-01Z`, `latest` *(Dockerfile)*](Dockerfile)

### RedHat Quay

Available on RedHat Quay as [`quay.io/ricardbejarano/minio`](https://quay.io/repository/ricardbejarano/minio):

- [`RELEASE.2021-08-20T18-32-01Z`, `latest` *(Dockerfile)*](Dockerfile)


## Features

* Compiled from source during build time
* Built `FROM scratch`, with zero bloat
* Statically linked to the [`musl`](https://musl.libc.org/) implementation of the C standard library
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Building

```bash
docker build --tag ricardbejarano/minio --file Dockerfile .
```


## Configuration

### Volumes

- Mount your **data** at `/data`.
- Mount your **configuration** at `/config`.


## License

MIT licensed, see [LICENSE](LICENSE) for more details.
