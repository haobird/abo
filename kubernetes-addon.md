# kubernetes插件安装

### 安装dashboard

```
# 安装
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

# 查看service和端口是否开启
kubectl get svc -n kubernetes-dashboard

# 删除容器
kubectl delete -f kubernetes-dashboard.yaml

# 查看创建的服务和pod
kubectl get svc -n kubernetes-dashboard | grep dashboard
kubectl get pod -n kubernetes-dashboard   #dashborad存在于kube-system名称空间中



```

##### 证书问题

```
# 生成新证书
# cd /etc/kubernetes/pki/
(umask 077; openssl genrsa -out dashboard.key 2048)  #创建一个证书
openssl req -new -key dashboard.key -out dashboard.csr -subj "/O=qiangungun/CN=kubernetes-dashboard"    #建立证书的签署请求
openssl x509 -req -in dashboard.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out dashboard.crt -days 3650 #使用集群的ca来签署证书

# 删除官方配置的证书部分
---

apiVersion: v1

kind: Secret

metadata:

  labels:

    k8s-app: kubernetes-dashboard

  name: kubernetes-dashboard-certs

  namespace: kubernetes-dashboard

type: Opaque

---

# 重新部署dashboard
kubectl apply -f  kubernetes-dashboard.yaml

# 添加新证书
kubectl create secret generic kubernetes-dashboard-certs -n kubernetes-dashboard --from-file=dashboard.crt=./dashboard.crt --from-file=dashboard.key=./dashboard.key
kubectl create secret generic kubernetes-dashboard-certs --from-file=dashboard.crt=./dashboard.crt --from-file=dashboard.key=./dashboard.key  -n kube-system  #我们需要把我们创建的证书创建为secret给k8s使用
```

### 认证问题

-- 参考链接：https://www.jianshu.com/p/be2a12a8bc0b
-- https://www.cnblogs.com/panwenbin-logs/p/10052554.html
-- https://www.kuboard.cn/install/install-k8s-dashboard.html#%E8%AE%BF%E9%97%AE

```
kubectl describe secret -n kubernetes-dashboard $(kubectl get secret -n kubernetes-dashboard | grep dashboard-admin | awk '{print $1}')

```

### 直接使用token登录

```
# 访问 https:IP:PORT
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

```

### 创建以token方式登录dashborad的用户

```
kubectl create serviceaccount dashboard-admin -n kubernetes-dashboard #创建用于登录dashborad的serviceaccount账号

kubectl create clusterrolebinding dashboard-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:dashboard-admin   #创建一个clusterrolebingding，将名称为cluster-admin的clusterrole绑定到我们刚刚从的serviceaccount上，名称空间和sa使用:作为间隔

kubectl get secret -n kube-system #创建完成后系统会自动创建一个secret，名称以serviceaccount名称开头

kubectl describe secret dashboard-admin-token-pbsj9 -n kube-system  #使用describe查看该secret的详细信息，主要是token一段
```

####

