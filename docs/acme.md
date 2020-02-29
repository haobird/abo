# 自动生成证书文档

### 参考链接：

1. https://github.com/acmesh-official/acme.sh/wiki/%E8%AF%B4%E6%98%8E
2. https://github.com/acmesh-official/acme.sh/wiki/dnsapi
3. https://segmentfault.com/a/1190000020031592
4. https://f-e-d.club/topic/use-acme-sh-deployment-let-s-encrypt-by-ali-cloud-dns-generic-domain-https-authentication.article
5. https://www.qikqiak.com/traefik-book/https/acme/#providers
6. https://www.qikqiak.com/post/traefik-2.1-101/

### 调试流程

```
kubectl get pods -n kube-system   # 查看当前命名空间的pos
kubectl logs -f traefik-6b99d57df-dv9j9 -n kube-system      # 查看具体的pods日志

```