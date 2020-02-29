# k8s 操作要点

### 常用命令

```



```


### 常用命令
```
kubectl apply -f devops/pvc.yaml    # 启动配置
kubectl create -f devops/pvc.yaml   # 创建应用
kubectl delete -f devops/pvc.yaml   # 删除应用

kubectl delete deployment host-pvc # 删除指定的deployment

kubectl get ingressroute # 获取当前路由组

kubectl get pv   # 查看PV 的状态
kubectl get pvc -n kube-ops     # 查看PVS 的状态 ，如果有定义命名空间，一定要指定出来才能看到

kubectl get svc  # 查看当前启动的service
kubectl get pods  -n kube-ops # 查看当前启动的pods

kubectl get pods    # 查看所有Pod列表
kubectl get rc,service  # 查看rc和service列表

kubectl get secret -n kube-system

kubectl get nodes --show-labels     # 查看所有节点及labels

kubectl describe nodes <node-name>      # 显示Node的详细信息
kubectl describe pods/<pod-name>        # 显示Pod的详细信息
kubectl describe pods <rc-name>         # 显示由RC管理的Pod的信息

kubectl describe pvc nginx-pvc

kubectl label nodes <node-name> <label-key>-    # 删除节点的labels

kubectl label nodes <node-name> <label-key>=<label-value>   # 给节点添加labels

kubectl label nodes <node-name> <label-key>=<label-value> --overwrite # 修改节点的labels, 需要加上--overwrite参数
```

### 创建命名空间

#### 1
```
kubectl create namespace kube-ops
```

#### 2

```
apiVersion: v1
kind: Namespace
metadata:
  name: kube-ops
```

### 创建挂载PV & PVC

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: opspv
spec:
  capacity:
    storage: 10Gi
  accessModes:
  - ReadWriteMany
  persistentVolumeReclaimPolicy: Delete
  hostPath:
    # directory location on host
    path: /data
     # this field is optional
    type: Directory
  # nfs:
  #   server: 10.151.30.57
  #   path: /data/k8s

---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: opspvc
  namespace: kube-ops
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 10Gi
```

### 查看挂载结果

```
kubectl get pv

kubectl get pvc
```

### 查看错误日志

```
kubectl logs kubernetes-dashboard-865b64d96f-g5f9t --namespace=kube-system
```
