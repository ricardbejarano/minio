<p align=center><img src=https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/apple/198/peacock_1f99a.png width=120px></p>
<h1 align=center>minio (container image)</h1>
<p align=center>The simplest container image of the <a href=https://min.io/>MinIO object storage server</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/minio`](https://hub.docker.com/r/ricardbejarano/minio):

- [`RELEASE.2019-07-10T00-34-56Z`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/minio/blob/master/Dockerfile)

### Quay

Available on [Quay](https://quay.io) as [`quay.io/ricardbejarano/minio`](https://quay.io/repository/ricardbejarano/minio):

- [`RELEASE.2019-07-10T00-34-56Z`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/minio/blob/master/Dockerfile)


## Features

* Super tiny (`~42.7MB`)
* Binary pulled from official website
* Built `FROM scratch`, see [Filesystem](#filesystem) for an exhaustive list of the image's contents
* Reduced attack surface (no shell, no UNIX tools, no package manager...)


## Configuration

### Volumes

- Bind your **data** at `/data`.


## Building

- To build the `glibc`-based image: `$ docker build -t minio:glibc -f Dockerfile.glibc .`
- To build the `musl`-based image: `$ docker build -t minio:musl -f Dockerfile.musl .`


## Filesystem

The image's contents are:

```
/
├── data/
│   └── .keep
├── etc/
│   ├── group
│   └── passwd
└── minio
```


## License

See [LICENSE](https://github.com/ricardbejarano/minio/blob/master/LICENSE).
