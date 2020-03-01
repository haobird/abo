# 安装过程



### 创建证书

```
kubectl create secret generic ca-secret --from-file=tls.crt=mzone.me.cer --from-file=tls.key=mzone.me.key --from-file=ca.crt=ca.crt -n kube-ops
```

## 问题

#### x509: certificate signed by unknown authority

问题：处理： 证书的格式有问题。。实际上cer 和 crt 可以直接改后缀使用，不用转换。