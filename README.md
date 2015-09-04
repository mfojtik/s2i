# s2i
Build minimal Docker image with S2I and Git

## Build

```console
$ ./build.sh s2i
```

```console
$ docker images | grep s2i
s2i             latest              9946af46dac5        7 minutes ago       17.1 MB
```

## Usage

```console
docker run -v /var/run/docker.sock:/var/run/docker.sock --privileged \
  s2i build --loglevel=5 https://github.com/mfojtik/sample-app openshift/ruby-22-centos7 sample-app
```
