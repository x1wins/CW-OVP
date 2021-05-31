1. setup k8s cluster with kops
> https://www.changwoo.org/x1wins@changwoo.net/2021-02-20/setup-k8s-cluster-with-kops-52fc8a54c4
2. Set Database node
```
kubectl label nodes [YOUR_NODE_NAME] nodetype=database
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
8. How to Update Image
    1. build image
        ```
            docker image prune -a -f
            export IMAGE_URL=x1wins/cw-ovp:latest
            # export IMAGE_URL=[YOUR_PRIVATE_REGISTRY_URL]/cw-ovp:latest
            docker build -t cw-ovp .
            docker tag cw-ovp:latest ${IMAGE_URL}
            docker push ${IMAGE_URL}
        ```
    3. Update 
        there is a few method for update image. you can choose following for update image.
        1. set image and rollout
            ```
                export IMAGE_URL=x1wins/cw-ovp
                # export IMAGE_URL=[YOUR_PRIVATE_REGISTRY_URL]/cw-ovp:latest
           
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
        2. Force update
            web-deployment.yaml sidekiq-deployment.yaml has ```imagePullPolicy: "Always"``` this option will be auto update when changed image version to new one.
            but sometime auto update not working. we can force update with following command. 
            > https://stackoverflow.com/a/40368520/1399891
            ```
                kubectl delete -f ./k8s-manifests/web-deploy.yaml
                kubectl create -f ./k8s-manifests/web-deploy.yaml
                
                kubectl delete -f ./k8s-manifests/sidekiq-deploy.yaml
                kubectl create -f ./k8s-manifests/sidekiq-deploy.yaml
            ```
    4. Double check digest in remote k8s and local docker image
        ```
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
kubectl exec web -- bash -c 'cd /myapp && RAILS_ENV=production bundle exec rake assets:precompile'
```
9. Script
    1. Bash
    ```
        kubectl exec --stdin --tty web-deployment-5b4cddf4dc-kc2vb -- /bin/bash
    ```
    2. Log
    ```
        kubectl exec --stdin --tty web-deployment-5b4cddf4dc-7hxm4 -- tail -f log/production.log
    ```
    3. Build
    ```
        cd CW-OVP/
        export IMAGE_URL=[YOUR_PRIVATE_REGISTRY_URL]/cw-ovp:latest
        export GIT_BRANCH=master
   
        git checkout ${GIT_BRANCH} && git pull origin ${GIT_BRANCH} && git reset --hard origin/${GIT_BRANCH} \
        && git branch -a && git rev-parse HEAD && git --no-pager log -n 60 --all --decorate --oneline --graph \
        && yes | docker system prune \
        && docker build -t cw-ovp . \
        && docker tag cw-ovp:latest ${IMAGE_URL} \
        && docker push ${IMAGE_URL}
    ```
    2. Deploy
    ```
        kubectl delete -f ./k8s-manifests/env-dev-docker-compose-configmap.yaml
        kubectl create -f ./k8s-manifests/env-dev-docker-compose-configmap.yaml
        kubectl describe configmap env-dev-docker-compose
        kubectl delete -f ./k8s-manifests/web-deploy.yaml
        kubectl create -f ./k8s-manifests/web-deploy.yaml
    ```
9. Dashboard
> https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
kubectl proxy
```
Open web browser 
> http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/