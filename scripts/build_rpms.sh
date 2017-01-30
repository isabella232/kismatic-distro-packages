#!/bin/bash
set -e

source ./scripts/VARIABLES.sh

# build Kubernetes
# master
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir\
  -n 'kismatic-kubernetes-master' \
  -v $KISMATIC_PACKAGE_VERSION \
  -t rpm --rpm-os linux \
  -a x86_64 \
  -d "kismatic-kubernetes-node = $REQUIRED_RPM_KISMATIC_PACKAGE_VERSION" \
  -d "kismatic-kubernetes-networking = $REQUIRED_RPM_KISMATIC_PACKAGE_VERSION" \
  -d "kismatic-docker-engine = $DOCKER_VERSION" \
  -d 'bridge-utils' \
  -d 'iptables >= 1.4.21' \
  -d 'socat' \
  -d 'util-linux' \
  -d 'ethtool' \
  -d 'nfs-utils' \
  -p /build/rpms/ \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes master binaries" \
  --url "https://apprenda.com/kismatic" \
  kubernetes/apiserver/bin/kube-apiserver=/usr/bin/kube-apiserver \
  kubernetes/scheduler/bin/kube-scheduler=/usr/bin/kube-scheduler \
  kubernetes/controller-manager/bin/kube-controller-manager=/usr/bin/kube-controller-manager \
  kubernetes/kubectl/bin/kubectl=/usr/bin/kubectl

# worker
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n 'kismatic-kubernetes-node' \
  -v $KISMATIC_PACKAGE_VERSION \
  -t rpm --rpm-os linux \
  -a x86_64 \
  -d "kismatic-kubernetes-networking = $REQUIRED_RPM_KISMATIC_PACKAGE_VERSION" \
  -d "kismatic-docker-engine = $DOCKER_VERSION" \
  -d 'bridge-utils' \
  -d 'iptables >= 1.4.21' \
  -d 'socat' \
  -d 'util-linux' \
  -d 'ethtool' \
  -d 'nfs-utils' \
  -p /build/rpms/ \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes node binaries" \
  --url "https://apprenda.com/kismatic" \
  kubernetes/kubelet/bin/kubelet=/usr/bin/kubelet \
  kubernetes/proxy/bin/kube-proxy=/usr/bin/kube-proxy

# offline
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n 'kismatic-offline' \
  -v $KISMATIC_PACKAGE_VERSION \
  -t rpm --rpm-os linux \
  -a x86_64 \
  -d "kismatic-docker-engine = $DOCKER_VERSION" \
  -p /build/rpms/ \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes node binaries" \
  --url "https://apprenda.com/kismatic" \
  images/registry.tar=/opt/images/registry.tar \
  images/kubedns.tar=/opt/images/kubedns.tar \
  images/kube-dnsmasq.tar=/opt/images/kube-dnsmasq.tar \
  images/kubernetes-dashboard.tar=/opt/images/kubernetes-dashboard.tar \
  images/exechealthz.tar=/opt/images/exechealthz.tar \
  images/pause.tar=/opt/images/pause.tar \
  images/nginx.tar=/opt/images/nginx.tar \
  images/busybox.tar=/opt/images/busybox.tar \
  images/defaultbackend.tar=/opt/images/defaultbackend.tar \
  images/nginx-ingress-controller.tar=/opt/images/nginx-ingress-controller.tar \
  images/tcp-healthz-amd64.tar=/opt/images/tcp-healthz-amd64.tar \
  images/calico.tar=/opt/images/calico.tar \
  images/kube-policy-controller.tar=/opt/images/kube-policy-controller.tar

# networking
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-kubernetes-networking" \
  -v $KISMATIC_PACKAGE_VERSION \
  -t rpm --rpm-os linux \
  -a x86_64 \
  -p /build/rpms/ \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes networking binaries" \
  --url "https://apprenda.com/kismatic" \
  networking/ctl/bin/calicoctl=/usr/bin/calicoctl \
  networking/cni/bin/=/opt/cni/

# build etcd
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-etcd" \
  -v $KISMATIC_PACKAGE_VERSION \
  -a x86_64 \
  -t rpm --rpm-os linux \
  -p /build/rpms/ \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Etcd kubernetes and networking binaries" \
  --url "https://apprenda.com/kismatic" \
  etcd/k8s/bin/etcd_k8s=/usr/bin/etcd_k8s \
  etcd/k8s/bin/etcdctl=/usr/bin/etcdctl \
  etcd/networking/bin/etcd_networking=/usr/bin/etcd_networking

# build docker
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s rpm \
  -n "kismatic-docker-engine" \
  -v $DOCKER_VERSION \
  -a x86_64 \
  -t rpm --rpm-os linux \
  -p /build/rpms/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Docker and its dependencies" \
  --url "https://apprenda.com/kismatic" \
  /source/docker/rpm/docker-engine-selinux-$DOCKER_SELINUX_RPM_VERSION.rpm \
  /source/docker/rpm/docker-engine-$DOCKER_RPM_VERSION.rpm
