<div align="center">
	<p><img src="https://em-content.zobj.net/thumbs/160/apple/325/flamingo_1f9a9.png" width="100px"></p>
	<h1>minio</h1>
	<p>Built-from-source container image of <a href="https://github.com/minio/minio">MinIO</a></p>
	<code>docker pull quay.io/ricardbejarano/minio</code>
</div>


## Features

* Compiled from source during build time
* Built `FROM scratch`, with zero bloat
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Tags

### Docker Hub

Available on Docker Hub as [`docker.io/ricardbejarano/minio`](https://hub.docker.com/r/ricardbejarano/minio):

- [`RELEASE.2023-08-09T23-30-22Z`, `latest` *(Dockerfile)*](Dockerfile)

### RedHat Quay

Available on RedHat Quay as [`quay.io/ricardbejarano/minio`](https://quay.io/repository/ricardbejarano/minio):

- [`RELEASE.2023-08-09T23-30-22Z`, `latest` *(Dockerfile)*](Dockerfile)


## Configuration

### Volumes

- Mount your **data** at `/data`.
- Mount your **configuration** at `/config`.
