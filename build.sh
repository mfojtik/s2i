#!/bin/sh -e

image_name="$1"

set -x

rm -rf ./buildroot
mkdir -p ./buildroot/bin
pushd ./buildroot

# Build static version of S2I
git clone https://github.com/openshift/source-to-image
pushd source-to-image
mkdir -p _output/local/go/src/github.com/openshift
ln -sf $(pwd) _output/local/go/src/github.com/openshift/source-to-image
export GOPATH=$(pwd)/_output/local/go:$(pwd)/Godeps/_workspace
export GOARCH=amd64
export GOOS=linux
unset GOBIN
CGO_ENABLED=0 go install -ldflags '-w' -tags netgo github.com/openshift/source-to-image/cmd/s2i
popd
mv $(pwd)/source-to-image/_output/local/go/bin/s2i ./bin/s2i
rm -rf source-to-image

# Download and extract static git
curl http://s.minos.io/bifrost/x86_64/git-1.8.2.1-3.tar.gz -o git.tar.gz
mkdir -p git/tmp && tar xf git.tar.gz -C git

popd

sudo docker build -t ${image_name:-"s2i"} .
rm -rf ./buildroot
