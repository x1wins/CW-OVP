kubectl initdb: directory "/var/lib/postgresql/data" exists but is not empty

# db-pod.yaml
```
      volumeMounts:
        - mountPath: /var/lib/postgresql/data
          name: db-data
          subPath: postgres #Add subPath
```

Solution
```
kubectl delete pod db
kubectl get pod
kubectl create -f db-pod.yaml #Don't use kubectl apply -f db-pod.yaml 
```
https://stackoverflow.com/a/51174380/1399891


rake db:migrate 
```
% kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
db                                  1/1     Running   0          6m47s
nginx-deployment-66b6c48dd5-fj95z   1/1     Running   0          6d20h
nginx-deployment-66b6c48dd5-h9xmh   1/1     Running   0          6d20h
nginx-deployment-66b6c48dd5-l8tpb   1/1     Running   0          5d22h
redis                               1/1     Running   0          37m
sidekiq                             1/1     Running   0          37m
web                                 1/1     Running   0          37m
```
```
$ kubectl exec web                              \
          -- bash -c                                               \
          'cd /myapp && RAILS_ENV=development bin/rails db:migrate RAILS_ENV=development'
kubectl exec web bundle exec rails webpacker:install

```
https://bigbinary.com/blog/managing-rails-tasks-such-as-db-migrate-and-db-seed-on-kuberenetes-while-performing-rolling-deployments

Get
```
% kubectl get pod 
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-66b6c48dd5-fj95z   1/1     Running   0          6d23h
nginx-deployment-66b6c48dd5-h9xmh   1/1     Running   0          6d23h
nginx-deployment-66b6c48dd5-l8tpb   1/1     Running   0          6d1h

% kubectl get deploy
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           6d23h
```

Create
```
% kubectl create -f ./k8s-manifests 
networkpolicy.networking.k8s.io/backend created
persistentvolumeclaim/db-data created
pod/db created
service/db created
persistentvolumeclaim/local-storage created
persistentvolumeclaim/redis-data created
pod/redis created
service/redis created
deployment.apps/sidekiq-deployment created
pod/sidekiq created
pod/web created
service/web created
```

Delete
```
% kubectl delete -f ./k8s-manifests/      
networkpolicy.networking.k8s.io "backend" deleted
persistentvolumeclaim "db-data" deleted
pod "db" deleted
service "db" deleted
persistentvolumeclaim "local-storage" deleted
persistentvolumeclaim "redis-data" deleted
pod "redis" deleted
service "redis" deleted
deployment.apps "sidekiq-deployment" deleted
pod "sidekiq" deleted
pod "web" deleted
service "web" deleted
```

Label
```
% kubectl label nodes <your-node-name> nodetype=database
```
https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/
