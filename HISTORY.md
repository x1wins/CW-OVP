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
  
### Rspec
> https://github.com/rspec/rspec-rails/issues/2177
```
group :test do
  gem 'rspec-rails', '4.0.0.beta3'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
end
```
> https://github.com/rspec/rspec-rails
```
rails generate rspec:install
rails generate rspec:scaffold encode
bundle exec rspec
```

```
# spec/rails_helper.rb:
require 'spec_helper'
require 'rspec/rails'
# note: require 'devise' after require 'rspec/rails'
require 'devise'

RSpec.configure do |config|
  # For Devise > 4.1.1
  config.include Devise::Test::ControllerHelpers, :type => :controller
  # Use the following instead if you are on Devise <= 4.1.1
  # config.include Devise::TestHelpers, :type => :controller
end
```

```
mkdir -p spec/support
vim spec/support/controller_macros.rb
```

