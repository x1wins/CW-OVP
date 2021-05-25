1. setup k8s cluster with kops
> https://www.changwoo.org/x1wins@changwoo.net/2021-02-20/setup-k8s-cluster-with-kops-52fc8a54c4
2. Set Database node
```
kubectl label nodes <your-node-name> nodetype=database
```
3. Update s3, cloudfront env
[env-dev-s3-configmap.yaml](/k8s-manifests/env-dev-s3-configmap.yaml)
4. Update database env (if you want)
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
8. Update image
    > https://stackoverflow.com/a/40368520/1399891
    1. set image and rollout
    ```
    export IMAGE_URL=x1wins/cw-ovp
    # Update sidekiq
    kubectl set image deployment/sidekiq-deployment sidekiq=${IMAGE_URL}  --record
    kubectl rollout status deployment/sidekiq-deployment
    # Update web
    kubectl set image deployment/web-deployment web=${IMAGE_URL}  --record
    kubectl rollout status deployment/web-deployment
    
    # or
    kubectl rollout restart deployment/sidekiq-deployment
    kubectl rollout restart deployment/web-deployment
    ```
    2. Double check digest in k8s node and local docker image
    ```
    #
    % kubectl get pod web-deployment-c9499f695-nx6sd -o json | grep image
        "imageID": "docker-pullable://cw-ovp@sha256:cb0f03db72341c46521d2b18e5463c3c6039229761d7f01bfde457e6c8ed2e2d",
    
    % docker images --digests
    REPOSITORY                                            TAG                 DIGEST                                                                    IMAGE ID       CREATED         SIZE
    x1wins/cw-ovp                                         latest              sha256:cb0f03db72341c46521d2b18e5463c3c6039229761d7f01bfde457e6c8ed2e2d   509addaaa0ec   47 hours ago    5.34GB
    ```

8. rake db:create, db:migrate
```
# development
kubectl exec web -- bash -c 'cd /myapp && RAILS_ENV=development bin/rake db:create'
kubectl exec web -- bash -c 'cd /myapp && RAILS_ENV=development bundle exec rake db:migrate'
# production
kubectl exec web -- bash -c 'cd /myapp && RAILS_ENV=production bin/rake db:create'
kubectl exec web -- bash -c 'cd /myapp && RAILS_ENV=production bundle exec rake db:migrate'
```
9. Dashboard
> https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
kubectl proxy
```
Open web browser with ```http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/.```