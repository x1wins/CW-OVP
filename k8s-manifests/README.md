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

Env
```
% kubectl exec web -- printenv
PATH=/usr/local/bundle/bin:/usr/local/bundle/gems/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=web
CABLE_REDIS_SERVER_URL=redis://redis:6379/1
DATABASE_URL=postgres://db
POSTGRES_DB=cw_ovp_development
POSTGRES_USER=docker_postgres_rails
REDIS_CLIENT_URL=redis://redis:6379/0
AWS_SECRET_ACCESS_KEY=XXXXXXXX
DATABASE_PASSWORD=mysecretpassword
REGION=us-west-1
WEB_LOGO_URL=https://raw.githubusercontent.com/x1wins/CW-OVP/master/app/assets/images/CW_OVP_LOGO_200x200.png
BUCKET=vod-origin
DATABASE_PORT=5432
POSTGRES_PASSWORD=mysecretpassword
REDIS_SERVER_URL=redis://redis:6379/0
RAILS_SERVE_STATIC_FILES=true
WEB_TITLE=CW-OVP
AWS_ACCESS_KEY_ID=XXXXXXXX
AWS_CLOUDFRONT_DOMAIN=https://XXXXXXXX.cloudfront.net
CDN_BUCKET=xxxxxx
DATABASE_NAME=cw_ovp_development
DATABASE_USERNAME=docker_postgres_rails
REDIS_SERVICE_HOST=100.65.19.172
KUBERNETES_PORT_443_TCP_PORT=443
NGINX_DEPLOYMENT_PORT_80_TCP_PROTO=tcp
DB_SERVICE_PORT=5432
DB_PORT_5432_TCP=tcp://100.67.100.210:5432
REDIS_PORT_6379_TCP=tcp://100.65.19.172:6379
WEB_PORT_3000_TCP_PROTO=tcp
WEB_PORT_3000_TCP_PORT=3000
KUBERNETES_SERVICE_HOST=100.64.0.1
DB_PORT=tcp://100.67.100.210:5432
REDIS_SERVICE_PORT=6379
WEB_PORT=tcp://100.70.204.34:3000
KUBERNETES_PORT_443_TCP=tcp://100.64.0.1:443
KUBERNETES_PORT_443_TCP_PROTO=tcp
NGINX_DEPLOYMENT_SERVICE_HOST=100.69.166.242
NGINX_DEPLOYMENT_SERVICE_PORT=80
DB_PORT_5432_TCP_PORT=5432
REDIS_PORT_6379_TCP_PROTO=tcp
REDIS_PORT_6379_TCP_ADDR=100.65.19.172
WEB_PORT_3000_TCP_ADDR=100.70.204.34
KUBERNETES_SERVICE_PORT_HTTPS=443
DB_PORT_5432_TCP_ADDR=100.67.100.210
KUBERNETES_SERVICE_PORT=443
KUBERNETES_PORT_443_TCP_ADDR=100.64.0.1
DB_SERVICE_PORT_5432=5432
DB_PORT_5432_TCP_PROTO=tcp
DB_SERVICE_HOST=100.67.100.210
WEB_SERVICE_HOST=100.70.204.34
WEB_SERVICE_PORT_3000=3000
WEB_PORT_3000_TCP=tcp://100.70.204.34:3000
NGINX_DEPLOYMENT_PORT_80_TCP=tcp://100.69.166.242:80
NGINX_DEPLOYMENT_PORT_80_TCP_ADDR=100.69.166.242
REDIS_PORT=tcp://100.65.19.172:6379
REDIS_PORT_6379_TCP_PORT=6379
WEB_SERVICE_PORT=3000
NGINX_DEPLOYMENT_PORT=tcp://100.69.166.242:80
REDIS_SERVICE_PORT_6379=6379
KUBERNETES_PORT=tcp://100.64.0.1:443
NGINX_DEPLOYMENT_PORT_80_TCP_PORT=80
RUBY_MAJOR=2.6
RUBY_VERSION=2.6.3
RUBY_DOWNLOAD_SHA256=XXXXXXXX
GEM_HOME=/usr/local/bundle
BUNDLE_PATH=/usr/local/bundle
BUNDLE_SILENCE_ROOT_WARNING=1
BUNDLE_APP_CONFIG=/usr/local/bundle
HOME=/root
```

hidden env file on git
```
git update-index --assume-unchanged ./k8s-manifests/env-dev-s3-configmap.yaml
```

pvc delete
```
kubectl delete pvc --all 
```
