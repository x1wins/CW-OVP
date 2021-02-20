1. setup k8s cluster with kops
> https://www.changwoo.org/x1wins@changwoo.net/2021-02-20/setup-k8s-cluster-with-kops-52fc8a54c4
2. Set Database node
```
kubectl label nodes <your-node-name> nodetype=database
```
3. Create deploy, pod, pvc 
```
kubectl create -f ./k8s-manifests
```
4. Delete
```
kubectl delete -f ./k8s-manifests
kubectl delete pvc --all
```
5. Get
```
kubectl get node
kubectl get pod
kubectl get deploy
kubectl get pvc
kubectl get configmap
kubectl get services 
```
> https://kubernetes.io/docs/reference/kubectl/cheatsheet/#viewing-finding-resources