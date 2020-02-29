# kubernetes-dashboard 安装流程

## 参考链接

1. https://www.cnblogs.com/t-road/p/11214862.html
2. https://segmentfault.com/a/1190000019534913?utm_source=tag-newest
3. https://www.cnblogs.com/zisefeizhu/p/12318401.html
4. https://www.cnblogs.com/bluersw/p/11747161.html
5. https://kubernetes.io/zh/docs/tasks/access-application-cluster/web-ui-dashboard/
6. https://www.qikqiak.com/post/use-kubeadm-install-kubernetes-1.15.3/
7. 

### 下载配置文件

```
wget https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

```

### 修改镜像

~~ 参考文件 basic/kubernetes-dashboard.yaml

```
image: gcr.azk8s.cn/google_containers/kubernetes-dashboard-amd64:v1.8.3
```

### 安装
kubectl create -f  ~/recommended.yaml

### 检查结果
kubectl get pods -A  -o wide

kubectl get service -n kubernetes-dashboard  -o wide

### 创建dashboard管理员

~~ 参考文件：basic/admin.yaml

```

```

