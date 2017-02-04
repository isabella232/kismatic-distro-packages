#!/bin/bash

# versions
KISMATIC_PACKAGE_VERSION=1.5.2-4
K8S_VERSION=1.5.2
ETCD_VERSION=3.1.0
DOCKER_VERSION=1.11.2
DOCKER_RPM_VERSION=1.11.2-1.el7.centos.x86_64
DOCKER_SELINUX_RPM_VERSION=1.11.2-1.el7.centos.noarch
DOCKER_DEB_VERSION=1.11.2-0~xenial_amd64

# urls
K8S_URL=https://storage.googleapis.com/kubernetes-release/release/v$K8S_VERSION/bin/linux/amd64
ETCD_URL=https://github.com/coreos/etcd/releases/download/v$ETCD_VERSION/etcd-v$ETCD_VERSION-linux-amd64.tar.gz

# docker images
DOCKER_RPM_URL=https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-$DOCKER_RPM_VERSION.rpm
DOCKER_SELINUX_RPM_URL=https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-selinux-$DOCKER_SELINUX_RPM_VERSION.rpm
DOCKER_DEB_URL=https://apt.dockerproject.org/repo/pool/main/d/docker-engine/docker-engine_$DOCKER_DEB_VERSION.deb

# k8s control plance
KUBE_PROXY_IMG=gcr.io/google-containers/kube-proxy-amd64:v$K8S_VERSION
KUBE_CONTROLLER_MANAGER_IMG=gcr.io/google-containers/kube-controller-manager-amd64:v$K8S_VERSION
KUBE_SCHEDULER_IMG=gcr.io/google-containers/kube-scheduler-amd64:v$K8S_VERSION
KUBE_APISERVER_IMG=gcr.io/google-containers/kube-apiserver-amd64:v$K8S_VERSION
# networking
CALICO_IMG=calico/node:v1.0.2
CALICO_CTL_IMG=calico/ctl:v1.0.2
CALICO_CNI_IMG=calico/cni:v1.5.6
CALICO_KUBE_POLICY_CONTROLLER_IMG=calico/kube-policy-controller:v0.5.2
# install support
REGISTRY_IMG=registry:2.5.1
KUBEDNS_IMG=gcr.io/google_containers/kubedns-amd64:1.9
DNSMAQ_IMG=gcr.io/google_containers/kube-dnsmasq-amd64:1.4
EXECHEALTHZ_IMG=gcr.io/google_containers/exechealthz-amd64:1.2
KUBERNETES_DASHBOARD_IMG=gcr.io/google_containers/kubernetes-dashboard-amd64:v1.5.1
DEFAULT_BACKEND=gcr.io/google_containers/defaultbackend:1.0
NGINX_INGRESS_CONTROLLER=gcr.io/google_containers/nginx-ingress-controller:0.8.3
APPRENDA_TCP_HEALTHZ=apprenda/tcp-healthz-amd64:v1.0.0
# used internally by k8s
PAUSE_IMG=gcr.io/google_containers/pause-amd64:3.0
# used by kuberang
NGINX_IMG=nginx:stable-alpine
BUSYBOX_IMG=busybox:latest
