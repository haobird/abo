# kubeadm 创建一个单主集群 流程(Ubuntu)

### 卸载docker

```
mv /var/lib/dpkg/info/{packagename}.* /tmp/
dpkg --remove --force-remove-reinstreq {packagename}
apt-get remove {packagename}
apt-get autoremove && sudo apt-get autoclean
```
# 或者
```
apt-get purge docker-ce
```

# 或者
```
dpkg -l | grep -i docker
# 根据显示出来的包名卸载
apt-get purge -y  docker-ce docker-ce-cli
apt-get autoremove -y --purge   docker-ce docker-ce-cli
apt-get autoclean
```

### 安装docker环境

```
# Ubuntu18.04下安装Docker CE
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

# 安装docker－compose
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

### 安装 kubeadm

-- 参考链接： https://kubernetes.io/zh/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

```
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
```

### 查看网络组

```
docker info |grep Cgroup
```
### kubeadm 创建一个单主

-- 参考链接：https://kubernetes.io/zh/docs/setup/independent/create-cluster-kubeadm/

```
kubeadm init --pod-network-cidr 10.244.0.0/16 --kubernetes-version stable
export KUBECONFIG=/etc/kubernetes/admin.conf

```

```
To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.26.7.117:6443 --token 1ufl2h.y3w2674qjv87zg29 \
    --discovery-token-ca-cert-hash sha256:75c979871af627ad22f1d5f8c284f06db0308d85a7b0b3bbb6674b8529bac46a
```

### 安装dashboard

```
# 安装
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
# 查看创建的服务和pod
kubectl get svc -n kube-system | grep dashboard
```


