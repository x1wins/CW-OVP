```
docker-compose run --no-deps web bundle exec rake db:create
docker-compose run --no-deps web bundle exec rake db:migrate
docker-compose run --no-deps web bin/rails generate controller Users index

```
