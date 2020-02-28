
# 安装使用流程


### 查看路由组

```
kubectl get ingressroute # 获取当前路由组
```

### 生成秘钥
```
kubectl create secret generic traefik-gandiv5-secret --from-literal=GANDIV5_API_KEY=xxxxxx -n kube-system

```

### 查看pods日志

```
kubectl logs traefik-848b9f6966-ztb2t --namespace=kube-system

kubectl get pods --v 6
```