# Index
* [Devise](#Devise)
* [Postgresql](#Postgresql)

### Devise
```bash
gem 'devise'
```
```bash
rails generate devise:install
rails generate devise User
rails db:migrate
```

### Postgresql
```bash
gem 'docker-postgres-rails', '~> 0.0.1'
```
```yaml
# database.yml
  database: docker_postgres_rails_development
  username: docker_postgres_rails
  password: mysecretpassword
  host: localhost
  port: 5432
```
```bash
rake docker:pg:init
rake docker:pg:run
```

