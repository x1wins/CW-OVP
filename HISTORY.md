# Index
* [Project init](#Project-init)
* [Added .idea/*](#Added-.idea/*)
* [Devise](#Devise)
* [Postgresql](#Postgresql)
* [Model](#Model)

### Project init
```
rails new CW-Encoding -T -d postgresql # --api
```

### Added .idea/*
```
echo ".idea/*" >> .gitignore
```

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

### Model
```bash
rails g scaffold encode log:text started_at:timestamp ended_at:timestamp runtime:float completed:boolean user:references published:boolean
add_column :users, :disabled, :boolean, default: false
```

```bash
rails g migration AddUrlToEncode url:string
rails g migration AddTitleToEncode title:string
```

```bash
rails generate migration ChangeRuntimeToEncode

class ChangeRuntimeToEncode < ActiveRecord::Migration[6.0]
  def change
    change_column :encodes, :runtime, :string
  end
end
```

### Sidekiq

### bulma
https://github.com/joshuajansen/bulma-rails
* Gemfile
    ```yaml
      gem "bulma-rails", "~> 0.9.0"
    ```
* application.scss
    > Change application.css to application.scss
    ```scss
      @import "bulma";
    ```
* install  
    ```bash
      bundle install
    ```
  
  