#!/bin/bash
set -e

source ./scripts/VARIABLES.sh

# build Kubernetes
# master
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-kubernetes-master" \
  -v $K8S_VERSION  \
  -a amd64 \
  -t deb \
  -d 'kismatic-kubernetes-node' \
  -d 'kismatic-kubernetes-networking' \
  -d "kismatic-docker-engine = $DOCKER_DEB_VERSION_SHORT" \
  -d 'bridge-utils' \
  -d 'iptables >= 1.4.21' \
  -d 'socat' \
  -d 'util-linux' \
  -d 'ethtool' \
  -p /build/debs \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes master binaries" \
  --url "https://apprenda.com/" \
  kubernetes/apiserver/bin/kube-apiserver=/usr/bin/kube-apiserver \
  kubernetes/scheduler/bin/kube-scheduler=/usr/bin/kube-scheduler \
  kubernetes/controller-manager/bin/kube-controller-manager=/usr/bin/kube-controller-manager \
  kubernetes/kubectl/bin/kubectl=/usr/bin/kubectl \
  images/=/opt/
# worker
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-kubernetes-node" \
  -v $K8S_VERSION  \
  -a amd64 \
  -t deb \
  -d 'kismatic-kubernetes-networking' \
  -d "kismatic-docker-engine = $DOCKER_DEB_VERSION_SHORT" \
  -d 'bridge-utils' \
  -d 'iptables >= 1.4.21' \
  -d 'socat' \
  -d 'util-linux' \
  -d 'ethtool' \
  -p /build/debs \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes node binaries" \
  --url "https://apprenda.com/" \
  kubernetes/kubelet/bin/kubelet=/usr/bin/kubelet \
  kubernetes/proxy/bin/kube-proxy=/usr/bin/kube-proxy \
  images/pause.tar=/opt/node-images/pause.tar \
  images/nginx.tar=/opt/node-images/nginx.tar \
  images/busybox.tar=/opt/node-images/busybox.tar

# networking
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-kubernetes-networking" \
  -v $K8S_VERSION  \
  -a amd64 \
  -t deb \
  -p /build/debs \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes networking binaries" \
  --url "https://apprenda.com/" \
  networking/ctl/bin/calicoctl=/usr/bin/calicoctl \
  networking/cni/bin/=/opt/cni/ \
  images/calico.tar=/opt/node-images/calico.tar

# build etcd
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-etcd" \
  -v $K8S_VERSION  \
  -a amd64 \
  -t deb \
  -p /build/debs \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Etcd kubernetes and networking binaries" \
  --url "https://apprenda.com/" \
  etcd/k8s/bin/etcd=/usr/bin/etcd \
  etcd/k8s/bin/etcdctl=/usr/bin/etcdctl \
  etcd/networking/bin/etcd2=/usr/bin/etcd2 \
  etcd/networking/bin/etcdctl2=/usr/bin/etcdctl2

# build docker
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s deb \
  -n "kismatic-docker-engine" \
  -a amd64 \
  -t deb \
  -v $DOCKER_VERSION \
  -p /build/debs/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Docker and its dependencies" \
  --url "https://apprenda.com/" \
  /source/docker/deb/docker-engine_$DOCKER_DEB_VERSION.deb
