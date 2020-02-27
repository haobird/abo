# kubernetes插件安装

### 安装dashboard

```
# 安装
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

# 查看端口号
kubectl get svc -n kubernetes-dashboard

# 删除容器
kubectl delete -f kubernetes-dashboard.yaml

# 查看创建的服务和pod
kubectl get svc -n kube-system | grep dashboard


```

##### 证书问题

```
# 生成新证书
cd /etc/kubernetes/pki/
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
```