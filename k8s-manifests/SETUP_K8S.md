1. setup k8s cluster with kops
> https://www.changwoo.org/x1wins@changwoo.net/2021-02-20/setup-k8s-cluster-with-kops-52fc8a54c4
2. Set Database node
```
kubectl label nodes <your-node-name> nodetype=database
```
3. Set s3, cloudfront env
[env-dev-s3-configmap.yaml](/k8s-manifests/env-dev-s3-configmap.yaml)
```
apiVersion: v1
data:
  AWS_ACCESS_KEY_ID: [Change key id]
  AWS_CLOUDFRONT_DOMAIN: [Change cdn domain]
  AWS_SECRET_ACCESS_KEY: [Change access key]
  BUCKET: [Change bucket]
  CDN_BUCKET: [Change cdn bucket]
  REGION: [Change region]
kind: ConfigMap
metadata:
  creationTimestamp: null
  labels:
    io.kompose.service: sidekiq-env-dev-s3
  name: env-dev-s3
```
4. Set database env (if you want)
[env-dev-docker-compose-configmap.yaml](/k8s-manifests/env-dev-docker-compose-configmap.yaml)
5. Create deploy, pod, pvc 
```
kubectl create -f ./k8s-manifests
```
6. Delete
```
kubectl delete -f ./k8s-manifests
kubectl delete pvc --all
```
7. Get
```
kubectl get node
kubectl get pod
kubectl get deploy
kubectl get pvc
kubectl get configmap
kubectl get services 
```
> https://kubernetes.io/docs/reference/kubectl/cheatsheet/#viewing-finding-resources

```
kubectl exec web -- bash -c 'cd /myapp && bundle exec rake db:migrate'
kubectl exec web -- bash -c 'cd ~/myapp && RAILS_ENV=production bin/rake db:create'
```