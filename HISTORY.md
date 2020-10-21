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

> Ruby: Printing system output in real time? https://stackoverflow.com/questions/23550595/ruby-printing-system-output-in-real-time
```ruby
Open3.popen3("yes | head -10") do |_,out,_,_|
  out.each_line do |line|
    puts "line : #{line}"
  end
end
```

```bash
rails g model asset format:string url:string encode:references 

docker-compose run --no-deps web bundle exec rails g model asset format:string url:string encode:references
docker-compose run --no-deps web bundle exec rake db:migrate

```

Add callback_id to encode model
```bash
rails generate migration add_callback_id_to_encode callback_id:integer
rake db:migrate
```

```
Completed 11.1 MiB/662.3 MiB (2.0 MiB/s) with 660 file(s) remaining
Completed 15.0 MiB/662.3 MiB (1.7 MiB/s) with 659 file(s) remaining
Completed 21.7 MiB/662.3 MiB (1.5 MiB/s) with 658 file(s) remaining
Completed 23.6 MiB/662.3 MiB (1.5 MiB/s) with 657 file(s) remaining
Completed 26.4 MiB/662.3 MiB (1.4 MiB/s) with 656 file(s) remaining
Completed 28.9 MiB/662.3 MiB (1.4 MiB/s) with 655 file(s) remaining
Completed 30.1 MiB/662.3 MiB (1.4 MiB/s) with 654 file(s) remaining
Completed 30.7 MiB/662.3 MiB (1.4 MiB/s) with 653 file(s) remaining
Completed 31.3 MiB/662.3 MiB (1.4 MiB/s) with 652 file(s) remaining
Completed 35.7 MiB/662.3 MiB (1.4 MiB/s) with 651 file(s) remaining
Completed 35.7 MiB/662.3 MiB (1.4 MiB/s) with 650 file(s) remaining
Completed 38.2 MiB/662.3 MiB (1.3 MiB/s) with 649 file(s) remaining
Completed 38.9 MiB/662.3 MiB (1.4 MiB/s) with 648 file(s) remaining
Completed 40.4 MiB/662.3 MiB (1.4 MiB/s) with 647 file(s) remaining
Completed 41.3 MiB/662.3 MiB (1.4 MiB/s) with 646 file(s) remaining
Completed 47.0 MiB/662.3 MiB (1.3 MiB/s) with 645 file(s) remaining
Completed 48.6 MiB/662.3 MiB (1.3 MiB/s) with 644 file(s) remaining
Completed 49.3 MiB/662.3 MiB (1.3 MiB/s) with 643 file(s) remaining
Completed 51.4 MiB/662.3 MiB (1.3 MiB/s) with 642 file(s) remaining
Completed 53.9 MiB/662.3 MiB (1.4 MiB/s) with 641 file(s) remaining
Completed 56.4 MiB/662.3 MiB (1.4 MiB/s) with 640 file(s) remaining
Completed 61.1 MiB/662.3 MiB (1.3 MiB/s) with 639 file(s) remaining
Completed 65.1 MiB/662.3 MiB (1.3 MiB/s) with 638 file(s) remaining
Completed 66.4 MiB/662.3 MiB (1.3 MiB/s) with 637 file(s) remaining
Completed 67.0 MiB/662.3 MiB (1.3 MiB/s) with 636 file(s) remaining
Completed 68.5 MiB/662.3 MiB (1.3 MiB/s) with 635 file(s) remaining
Completed 72.7 MiB/662.3 MiB (1.3 MiB/s) with 634 file(s) remaining
Completed 75.5 MiB/662.3 MiB (1.3 MiB/s) with 633 file(s) remaining
Completed 80.7 MiB/662.3 MiB (1.3 MiB/s) with 632 file(s) remaining
Completed 83.0 MiB/662.3 MiB (1.3 MiB/s) with 631 file(s) remaining
Completed 84.3 MiB/662.3 MiB (1.3 MiB/s) with 630 file(s) remaining
Completed 86.5 MiB/662.3 MiB (1.3 MiB/s) with 629 file(s) remaining
Completed 87.9 MiB/662.3 MiB (1.3 MiB/s) with 628 file(s) remaining
Completed 90.0 MiB/662.3 MiB (1.3 MiB/s) with 627 file(s) remaining
Completed 90.5 MiB/662.3 MiB (1.3 MiB/s) with 626 file(s) remaining
Completed 92.7 MiB/662.3 MiB (1.3 MiB/s) with 625 file(s) remaining
Completed 95.3 MiB/662.3 MiB (1.3 MiB/s) with 624 file(s) remaining
Completed 97.2 MiB/662.3 MiB (1.3 MiB/s) with 623 file(s) remaining
Completed 98.3 MiB/662.3 MiB (1.3 MiB/s) with 622 file(s) remaining
Completed 99.4 MiB/662.3 MiB (1.3 MiB/s) with 621 file(s) remaining
Completed 101.9 MiB/662.3 MiB (1.3 MiB/s) with 620 file(s) remaining
Completed 103.4 MiB/662.3 MiB (1.3 MiB/s) with 619 file(s) remaining
Completed 104.7 MiB/662.3 MiB (1.3 MiB/s) with 618 file(s) remaining
Completed 106.5 MiB/662.3 MiB (1.3 MiB/s) with 617 file(s) remaining
Completed 109.2 MiB/662.3 MiB (1.3 MiB/s) with 616 file(s) remaining
Completed 110.3 MiB/662.3 MiB (1.3 MiB/s) with 615 file(s) remaining
Completed 112.5 MiB/662.3 MiB (1.3 MiB/s) with 614 file(s) remaining
Completed 113.6 MiB/662.3 MiB (1.3 MiB/s) with 613 file(s) remaining
Completed 115.5 MiB/662.3 MiB (1.3 MiB/s) with 612 file(s) remaining
Completed 117.8 MiB/662.3 MiB (1.3 MiB/s) with 611 file(s) remaining
Completed 120.9 MiB/662.3 MiB (1.3 MiB/s) with 610 file(s) remaining
Completed 121.6 MiB/662.3 MiB (1.3 MiB/s) with 609 file(s) remaining
Completed 122.7 MiB/662.3 MiB (1.3 MiB/s) with 608 file(s) remaining
Completed 123.4 MiB/662.3 MiB (1.3 MiB/s) with 607 file(s) remaining
Completed 124.8 MiB/662.3 MiB (1.3 MiB/s) with 606 file(s) remaining
Completed 126.2 MiB/662.3 MiB (1.3 MiB/s) with 605 file(s) remaining
Completed 127.9 MiB/662.3 MiB (1.3 MiB/s) with 604 file(s) remaining
Completed 127.9 MiB/662.3 MiB (1.3 MiB/s) with 603 file(s) remaining
Completed 129.0 MiB/662.3 MiB (1.3 MiB/s) with 602 file(s) remaining
Completed 131.9 MiB/662.3 MiB (1.3 MiB/s) with 601 file(s) remaining
Completed 133.9 MiB/662.3 MiB (1.3 MiB/s) with 600 file(s) remaining
Completed 135.2 MiB/662.3 MiB (1.3 MiB/s) with 599 file(s) remaining
Completed 137.4 MiB/662.3 MiB (1.3 MiB/s) with 598 file(s) remaining
Completed 138.4 MiB/662.3 MiB (1.3 MiB/s) with 597 file(s) remaining
Completed 139.9 MiB/662.3 MiB (1.3 MiB/s) with 596 file(s) remaining
Completed 142.1 MiB/662.3 MiB (1.3 MiB/s) with 595 file(s) remaining
Completed 143.6 MiB/662.3 MiB (1.3 MiB/s) with 594 file(s) remaining
Completed 143.6 MiB/662.3 MiB (1.3 MiB/s) with 593 file(s) remaining
Completed 146.1 MiB/662.3 MiB (1.3 MiB/s) with 592 file(s) remaining
Completed 146.7 MiB/662.3 MiB (1.3 MiB/s) with 591 file(s) remaining
Completed 148.1 MiB/662.3 MiB (1.3 MiB/s) with 590 file(s) remaining
Completed 152.0 MiB/662.3 MiB (1.3 MiB/s) with 589 file(s) remaining
Completed 153.8 MiB/662.3 MiB (1.3 MiB/s) with 588 file(s) remaining
Completed 156.2 MiB/662.3 MiB (1.3 MiB/s) with 587 file(s) remaining
Completed 159.5 MiB/662.3 MiB (1.3 MiB/s) with 586 file(s) remaining
Completed 159.5 MiB/662.3 MiB (1.3 MiB/s) with 585 file(s) remaining
Completed 161.4 MiB/662.3 MiB (1.3 MiB/s) with 584 file(s) remaining
Completed 167.5 MiB/662.3 MiB (1.3 MiB/s) with 583 file(s) remaining
Completed 168.5 MiB/662.3 MiB (1.3 MiB/s) with 582 file(s) remaining
Completed 169.5 MiB/662.3 MiB (1.3 MiB/s) with 581 file(s) remaining
Completed 171.3 MiB/662.3 MiB (1.3 MiB/s) with 580 file(s) remaining
Completed 172.2 MiB/662.3 MiB (1.3 MiB/s) with 579 file(s) remaining
Completed 173.6 MiB/662.3 MiB (1.3 MiB/s) with 578 file(s) remaining
Completed 176.7 MiB/662.3 MiB (1.3 MiB/s) with 577 file(s) remaining
Completed 176.7 MiB/662.3 MiB (1.3 MiB/s) with 576 file(s) remaining
Completed 178.1 MiB/662.3 MiB (1.3 MiB/s) with 575 file(s) remaining
Completed 179.0 MiB/662.3 MiB (1.3 MiB/s) with 574 file(s) remaining
Completed 182.2 MiB/662.3 MiB (1.3 MiB/s) with 573 file(s) remaining
Completed 185.6 MiB/662.3 MiB (1.3 MiB/s) with 572 file(s) remaining
Completed 186.5 MiB/662.3 MiB (1.3 MiB/s) with 571 file(s) remaining
Completed 188.3 MiB/662.3 MiB (1.3 MiB/s) with 570 file(s) remaining
Completed 189.4 MiB/662.3 MiB (1.3 MiB/s) with 569 file(s) remaining
Completed 191.3 MiB/662.3 MiB (1.3 MiB/s) with 568 file(s) remaining
Completed 194.6 MiB/662.3 MiB (1.3 MiB/s) with 567 file(s) remaining
Completed 199.2 MiB/662.3 MiB (1.3 MiB/s) with 566 file(s) remaining
Completed 199.4 MiB/662.3 MiB (1.3 MiB/s) with 565 file(s) remaining
Completed 201.4 MiB/662.3 MiB (1.3 MiB/s) with 564 file(s) remaining
Completed 206.8 MiB/662.3 MiB (1.3 MiB/s) with 563 file(s) remaining
Completed 212.5 MiB/662.3 MiB (1.3 MiB/s) with 562 file(s) remaining
Completed 213.7 MiB/662.3 MiB (1.3 MiB/s) with 561 file(s) remaining
Completed 214.7 MiB/662.3 MiB (1.3 MiB/s) with 560 file(s) remaining
Completed 217.7 MiB/662.3 MiB (1.3 MiB/s) with 559 file(s) remaining
Completed 218.2 MiB/662.3 MiB (1.3 MiB/s) with 558 file(s) remaining
Completed 219.3 MiB/662.3 MiB (1.3 MiB/s) with 557 file(s) remaining
Completed 222.9 MiB/662.3 MiB (1.3 MiB/s) with 556 file(s) remaining
Completed 224.7 MiB/662.3 MiB (1.3 MiB/s) with 555 file(s) remaining
Completed 226.6 MiB/662.3 MiB (1.3 MiB/s) with 554 file(s) remaining
Completed 228.2 MiB/662.3 MiB (1.3 MiB/s) with 553 file(s) remaining
Completed 231.1 MiB/662.3 MiB (1.3 MiB/s) with 552 file(s) remaining
Completed 238.1 MiB/662.3 MiB (1.3 MiB/s) with 551 file(s) remaining
Completed 240.4 MiB/662.3 MiB (1.3 MiB/s) with 550 file(s) remaining
Completed 240.9 MiB/662.3 MiB (1.3 MiB/s) with 549 file(s) remaining
Completed 241.8 MiB/662.3 MiB (1.3 MiB/s) with 548 file(s) remaining
Completed 245.1 MiB/662.3 MiB (1.3 MiB/s) with 547 file(s) remaining
Completed 246.0 MiB/662.3 MiB (1.3 MiB/s) with 546 file(s) remaining
Completed 246.5 MiB/662.3 MiB (1.3 MiB/s) with 545 file(s) remaining
Completed 249.9 MiB/662.3 MiB (1.3 MiB/s) with 544 file(s) remaining
Completed 250.5 MiB/662.3 MiB (1.3 MiB/s) with 543 file(s) remaining
Completed 252.9 MiB/662.3 MiB (1.3 MiB/s) with 542 file(s) remaining
Completed 255.7 MiB/662.3 MiB (1.3 MiB/s) with 541 file(s) remaining
Completed 263.3 MiB/662.3 MiB (1.3 MiB/s) with 540 file(s) remaining
Completed 268.4 MiB/662.3 MiB (1.3 MiB/s) with 539 file(s) remaining
Completed 270.6 MiB/662.3 MiB (1.3 MiB/s) with 538 file(s) remaining
Completed 271.9 MiB/662.3 MiB (1.3 MiB/s) with 537 file(s) remaining
Completed 273.5 MiB/662.3 MiB (1.3 MiB/s) with 536 file(s) remaining
Completed 275.9 MiB/662.3 MiB (1.3 MiB/s) with 535 file(s) remaining
Completed 278.3 MiB/662.3 MiB (1.3 MiB/s) with 534 file(s) remaining
Completed 279.3 MiB/662.3 MiB (1.3 MiB/s) with 533 file(s) remaining
Completed 281.6 MiB/662.3 MiB (1.3 MiB/s) with 532 file(s) remaining
Completed 283.1 MiB/662.3 MiB (1.3 MiB/s) with 531 file(s) remaining
Completed 286.3 MiB/662.3 MiB (1.3 MiB/s) with 530 file(s) remaining
Completed 290.0 MiB/662.3 MiB (1.3 MiB/s) with 529 file(s) remaining
Completed 290.1 MiB/662.3 MiB (1.3 MiB/s) with 528 file(s) remaining
Completed 290.3 MiB/662.3 MiB (1.3 MiB/s) with 527 file(s) remaining
Completed 290.4 MiB/662.3 MiB (1.3 MiB/s) with 526 file(s) remaining
Completed 291.7 MiB/662.3 MiB (1.3 MiB/s) with 525 file(s) remaining
Completed 292.1 MiB/662.3 MiB (1.3 MiB/s) with 524 file(s) remaining
Completed 292.1 MiB/662.3 MiB (1.3 MiB/s) with 523 file(s) remaining
Completed 292.7 MiB/662.3 MiB (1.3 MiB/s) with 522 file(s) remaining
Completed 293.0 MiB/662.3 MiB (1.3 MiB/s) with 521 file(s) remaining
Completed 294.0 MiB/662.3 MiB (1.3 MiB/s) with 520 file(s) remaining
Completed 295.0 MiB/662.3 MiB (1.3 MiB/s) with 519 file(s) remaining
Completed 295.7 MiB/662.3 MiB (1.3 MiB/s) with 518 file(s) remaining
Completed 297.4 MiB/662.3 MiB (1.3 MiB/s) with 517 file(s) remaining
Completed 300.8 MiB/662.3 MiB (1.3 MiB/s) with 516 file(s) remaining
Completed 300.9 MiB/662.3 MiB (1.3 MiB/s) with 515 file(s) remaining
Completed 301.5 MiB/662.3 MiB (1.3 MiB/s) with 514 file(s) remaining
Completed 305.3 MiB/662.3 MiB (1.3 MiB/s) with 513 file(s) remaining
Completed 307.0 MiB/662.3 MiB (1.3 MiB/s) with 512 file(s) remaining
Completed 309.6 MiB/662.3 MiB (1.3 MiB/s) with 511 file(s) remaining
Completed 310.4 MiB/662.3 MiB (1.3 MiB/s) with 510 file(s) remaining
Completed 311.5 MiB/662.3 MiB (1.3 MiB/s) with 509 file(s) remaining
Completed 312.8 MiB/662.3 MiB (1.3 MiB/s) with 508 file(s) remaining
Completed 315.0 MiB/662.3 MiB (1.3 MiB/s) with 507 file(s) remaining
Completed 315.4 MiB/662.3 MiB (1.3 MiB/s) with 506 file(s) remaining
Completed 315.6 MiB/662.3 MiB (1.3 MiB/s) with 505 file(s) remaining
Completed 317.9 MiB/662.3 MiB (1.3 MiB/s) with 504 file(s) remaining
Completed 317.9 MiB/662.3 MiB (1.3 MiB/s) with 503 file(s) remaining
Completed 319.7 MiB/662.3 MiB (1.3 MiB/s) with 502 file(s) remaining
Completed 320.4 MiB/662.3 MiB (1.3 MiB/s) with 501 file(s) remaining
Completed 320.6 MiB/662.3 MiB (1.3 MiB/s) with 500 file(s) remaining
Completed 320.7 MiB/662.3 MiB (1.3 MiB/s) with 499 file(s) remaining
Completed 321.6 MiB/662.3 MiB (1.3 MiB/s) with 498 file(s) remaining
Completed 322.7 MiB/662.3 MiB (1.3 MiB/s) with 497 file(s) remaining
Completed 323.4 MiB/662.3 MiB (1.3 MiB/s) with 496 file(s) remaining
Completed 323.9 MiB/662.3 MiB (1.3 MiB/s) with 495 file(s) remaining
Completed 324.3 MiB/662.3 MiB (1.3 MiB/s) with 494 file(s) remaining
Completed 325.1 MiB/662.3 MiB (1.2 MiB/s) with 493 file(s) remaining
Completed 325.1 MiB/662.3 MiB (1.2 MiB/s) with 492 file(s) remaining
Completed 326.0 MiB/662.3 MiB (1.2 MiB/s) with 491 file(s) remaining
Completed 326.2 MiB/662.3 MiB (1.3 MiB/s) with 490 file(s) remaining
Completed 327.4 MiB/662.3 MiB (1.3 MiB/s) with 489 file(s) remaining
Completed 327.9 MiB/662.3 MiB (1.3 MiB/s) with 488 file(s) remaining
Completed 327.9 MiB/662.3 MiB (1.3 MiB/s) with 487 file(s) remaining
Completed 328.4 MiB/662.3 MiB (1.2 MiB/s) with 486 file(s) remaining
Completed 328.8 MiB/662.3 MiB (1.2 MiB/s) with 485 file(s) remaining
Completed 329.3 MiB/662.3 MiB (1.2 MiB/s) with 484 file(s) remaining
Completed 329.9 MiB/662.3 MiB (1.2 MiB/s) with 483 file(s) remaining
Completed 329.9 MiB/662.3 MiB (1.2 MiB/s) with 482 file(s) remaining
Completed 330.5 MiB/662.3 MiB (1.2 MiB/s) with 481 file(s) remaining
Completed 330.6 MiB/662.3 MiB (1.3 MiB/s) with 480 file(s) remaining
Completed 331.1 MiB/662.3 MiB (1.2 MiB/s) with 479 file(s) remaining
Completed 331.7 MiB/662.3 MiB (1.2 MiB/s) with 478 file(s) remaining
Completed 332.4 MiB/662.3 MiB (1.2 MiB/s) with 477 file(s) remaining
Completed 332.7 MiB/662.3 MiB (1.2 MiB/s) with 476 file(s) remaining
Completed 332.9 MiB/662.3 MiB (1.2 MiB/s) with 475 file(s) remaining
Completed 333.6 MiB/662.3 MiB (1.2 MiB/s) with 474 file(s) remaining
Completed 334.1 MiB/662.3 MiB (1.2 MiB/s) with 473 file(s) remaining
Completed 334.6 MiB/662.3 MiB (1.2 MiB/s) with 472 file(s) remaining
Completed 335.1 MiB/662.3 MiB (1.2 MiB/s) with 471 file(s) remaining
Completed 335.3 MiB/662.3 MiB (1.2 MiB/s) with 470 file(s) remaining
Completed 336.0 MiB/662.3 MiB (1.2 MiB/s) with 469 file(s) remaining
Completed 336.5 MiB/662.3 MiB (1.2 MiB/s) with 468 file(s) remaining
Completed 337.0 MiB/662.3 MiB (1.2 MiB/s) with 467 file(s) remaining
Completed 337.5 MiB/662.3 MiB (1.2 MiB/s) with 466 file(s) remaining
Completed 337.9 MiB/662.3 MiB (1.2 MiB/s) with 465 file(s) remaining
Completed 338.2 MiB/662.3 MiB (1.2 MiB/s) with 464 file(s) remaining
Completed 338.7 MiB/662.3 MiB (1.2 MiB/s) with 463 file(s) remaining
Completed 339.4 MiB/662.3 MiB (1.2 MiB/s) with 462 file(s) remaining
Completed 339.9 MiB/662.3 MiB (1.2 MiB/s) with 461 file(s) remaining
Completed 340.2 MiB/662.3 MiB (1.2 MiB/s) with 460 file(s) remaining
Completed 340.5 MiB/662.3 MiB (1.2 MiB/s) with 459 file(s) remaining
Completed 340.7 MiB/662.3 MiB (1.2 MiB/s) with 458 file(s) remaining
Completed 341.0 MiB/662.3 MiB (1.2 MiB/s) with 457 file(s) remaining
Completed 341.2 MiB/662.3 MiB (1.2 MiB/s) with 456 file(s) remaining
Completed 341.5 MiB/662.3 MiB (1.2 MiB/s) with 455 file(s) remaining
Completed 342.0 MiB/662.3 MiB (1.2 MiB/s) with 454 file(s) remaining
Completed 342.5 MiB/662.3 MiB (1.2 MiB/s) with 453 file(s) remaining
Completed 343.1 MiB/662.3 MiB (1.2 MiB/s) with 452 file(s) remaining
Completed 343.4 MiB/662.3 MiB (1.2 MiB/s) with 451 file(s) remaining
Completed 343.5 MiB/662.3 MiB (1.2 MiB/s) with 450 file(s) remaining
Completed 343.9 MiB/662.3 MiB (1.2 MiB/s) with 449 file(s) remaining
Completed 344.3 MiB/662.3 MiB (1.2 MiB/s) with 448 file(s) remaining
Completed 344.8 MiB/662.3 MiB (1.2 MiB/s) with 447 file(s) remaining
Completed 345.0 MiB/662.3 MiB (1.2 MiB/s) with 446 file(s) remaining
Completed 345.5 MiB/662.3 MiB (1.2 MiB/s) with 445 file(s) remaining
Completed 345.9 MiB/662.3 MiB (1.2 MiB/s) with 444 file(s) remaining
Completed 345.9 MiB/662.3 MiB (1.2 MiB/s) with 443 file(s) remaining
Completed 346.4 MiB/662.3 MiB (1.2 MiB/s) with 442 file(s) remaining
Completed 346.8 MiB/662.3 MiB (1.2 MiB/s) with 441 file(s) remaining
Completed 347.1 MiB/662.3 MiB (1.2 MiB/s) with 440 file(s) remaining
Completed 347.4 MiB/662.3 MiB (1.2 MiB/s) with 439 file(s) remaining
Completed 347.8 MiB/662.3 MiB (1.2 MiB/s) with 438 file(s) remaining
Completed 348.2 MiB/662.3 MiB (1.2 MiB/s) with 436 file(s) remaining
Completed 347.8 MiB/662.3 MiB (1.2 MiB/s) with 437 file(s) remaining
Completed 348.2 MiB/662.3 MiB (1.2 MiB/s) with 435 file(s) remaining
Completed 349.1 MiB/662.3 MiB (1.2 MiB/s) with 434 file(s) remaining
Completed 349.4 MiB/662.3 MiB (1.2 MiB/s) with 433 file(s) remaining
Completed 349.7 MiB/662.3 MiB (1.2 MiB/s) with 432 file(s) remaining
Completed 350.1 MiB/662.3 MiB (1.2 MiB/s) with 431 file(s) remaining
Completed 350.4 MiB/662.3 MiB (1.2 MiB/s) with 430 file(s) remaining
Completed 350.7 MiB/662.3 MiB (1.2 MiB/s) with 429 file(s) remaining
Completed 351.0 MiB/662.3 MiB (1.2 MiB/s) with 428 file(s) remaining
Completed 351.7 MiB/662.3 MiB (1.2 MiB/s) with 427 file(s) remaining
Completed 352.1 MiB/662.3 MiB (1.2 MiB/s) with 426 file(s) remaining
Completed 352.1 MiB/662.3 MiB (1.2 MiB/s) with 425 file(s) remaining
Completed 352.1 MiB/662.3 MiB (1.2 MiB/s) with 424 file(s) remaining
Completed 352.7 MiB/662.3 MiB (1.2 MiB/s) with 423 file(s) remaining
Completed 353.3 MiB/662.3 MiB (1.2 MiB/s) with 422 file(s) remaining
Completed 353.6 MiB/662.3 MiB (1.2 MiB/s) with 421 file(s) remaining
Completed 353.8 MiB/662.3 MiB (1.2 MiB/s) with 420 file(s) remaining
Completed 354.3 MiB/662.3 MiB (1.2 MiB/s) with 419 file(s) remaining
Completed 354.7 MiB/662.3 MiB (1.2 MiB/s) with 418 file(s) remaining
Completed 355.1 MiB/662.3 MiB (1.2 MiB/s) with 417 file(s) remaining
Completed 355.6 MiB/662.3 MiB (1.2 MiB/s) with 416 file(s) remaining
Completed 356.1 MiB/662.3 MiB (1.2 MiB/s) with 415 file(s) remaining
Completed 356.3 MiB/662.3 MiB (1.2 MiB/s) with 414 file(s) remaining
Completed 356.4 MiB/662.3 MiB (1.2 MiB/s) with 413 file(s) remaining
Completed 356.9 MiB/662.3 MiB (1.2 MiB/s) with 412 file(s) remaining
Completed 357.4 MiB/662.3 MiB (1.2 MiB/s) with 411 file(s) remaining
Completed 357.4 MiB/662.3 MiB (1.2 MiB/s) with 410 file(s) remaining
Completed 358.1 MiB/662.3 MiB (1.2 MiB/s) with 409 file(s) remaining
Completed 358.3 MiB/662.3 MiB (1.2 MiB/s) with 408 file(s) remaining
Completed 358.9 MiB/662.3 MiB (1.2 MiB/s) with 407 file(s) remaining
Completed 359.3 MiB/662.3 MiB (1.2 MiB/s) with 406 file(s) remaining
Completed 359.3 MiB/662.3 MiB (1.2 MiB/s) with 405 file(s) remaining
Completed 360.0 MiB/662.3 MiB (1.2 MiB/s) with 404 file(s) remaining
Completed 360.7 MiB/662.3 MiB (1.2 MiB/s) with 403 file(s) remaining
Completed 360.9 MiB/662.3 MiB (1.2 MiB/s) with 402 file(s) remaining
Completed 361.5 MiB/662.3 MiB (1.2 MiB/s) with 401 file(s) remaining
Completed 362.0 MiB/662.3 MiB (1.2 MiB/s) with 400 file(s) remaining
Completed 362.2 MiB/662.3 MiB (1.2 MiB/s) with 399 file(s) remaining
Completed 362.9 MiB/662.3 MiB (1.2 MiB/s) with 398 file(s) remaining
Completed 363.1 MiB/662.3 MiB (1.2 MiB/s) with 397 file(s) remaining
Completed 363.9 MiB/662.3 MiB (1.2 MiB/s) with 396 file(s) remaining
Completed 364.2 MiB/662.3 MiB (1.2 MiB/s) with 395 file(s) remaining
Completed 364.6 MiB/662.3 MiB (1.2 MiB/s) with 394 file(s) remaining
Completed 364.9 MiB/662.3 MiB (1.2 MiB/s) with 393 file(s) remaining
Completed 365.3 MiB/662.3 MiB (1.2 MiB/s) with 392 file(s) remaining
Completed 366.0 MiB/662.3 MiB (1.2 MiB/s) with 391 file(s) remaining
Completed 366.2 MiB/662.3 MiB (1.2 MiB/s) with 389 file(s) remaining
Completed 366.0 MiB/662.3 MiB (1.2 MiB/s) with 390 file(s) remaining
Completed 366.9 MiB/662.3 MiB (1.2 MiB/s) with 388 file(s) remaining
Completed 367.6 MiB/662.3 MiB (1.2 MiB/s) with 387 file(s) remaining
Completed 368.0 MiB/662.3 MiB (1.2 MiB/s) with 386 file(s) remaining
Completed 368.4 MiB/662.3 MiB (1.2 MiB/s) with 385 file(s) remaining
Completed 368.6 MiB/662.3 MiB (1.2 MiB/s) with 384 file(s) remaining
Completed 369.4 MiB/662.3 MiB (1.2 MiB/s) with 383 file(s) remaining
Completed 369.7 MiB/662.3 MiB (1.2 MiB/s) with 382 file(s) remaining
Completed 369.9 MiB/662.3 MiB (1.2 MiB/s) with 381 file(s) remaining
Completed 370.9 MiB/662.3 MiB (1.2 MiB/s) with 380 file(s) remaining
Completed 371.4 MiB/662.3 MiB (1.2 MiB/s) with 379 file(s) remaining
Completed 372.1 MiB/662.3 MiB (1.2 MiB/s) with 378 file(s) remaining
Completed 372.3 MiB/662.3 MiB (1.2 MiB/s) with 377 file(s) remaining
Completed 373.1 MiB/662.3 MiB (1.2 MiB/s) with 376 file(s) remaining
Completed 373.8 MiB/662.3 MiB (1.2 MiB/s) with 375 file(s) remaining
Completed 374.1 MiB/662.3 MiB (1.2 MiB/s) with 374 file(s) remaining
Completed 374.5 MiB/662.3 MiB (1.2 MiB/s) with 373 file(s) remaining
Completed 374.8 MiB/662.3 MiB (1.2 MiB/s) with 372 file(s) remaining
Completed 375.2 MiB/662.3 MiB (1.2 MiB/s) with 371 file(s) remaining
Completed 375.7 MiB/662.3 MiB (1.2 MiB/s) with 370 file(s) remaining
Completed 376.0 MiB/662.3 MiB (1.2 MiB/s) with 369 file(s) remaining
Completed 376.5 MiB/662.3 MiB (1.2 MiB/s) with 368 file(s) remaining
Completed 376.5 MiB/662.3 MiB (1.2 MiB/s) with 367 file(s) remaining
Completed 377.2 MiB/662.3 MiB (1.2 MiB/s) with 366 file(s) remaining
Completed 377.6 MiB/662.3 MiB (1.2 MiB/s) with 365 file(s) remaining
Completed 377.8 MiB/662.3 MiB (1.2 MiB/s) with 364 file(s) remaining
Completed 378.2 MiB/662.3 MiB (1.2 MiB/s) with 363 file(s) remaining
Completed 378.2 MiB/662.3 MiB (1.2 MiB/s) with 362 file(s) remaining
Completed 378.3 MiB/662.3 MiB (1.2 MiB/s) with 361 file(s) remaining
Completed 378.4 MiB/662.3 MiB (1.2 MiB/s) with 360 file(s) remaining
Completed 378.6 MiB/662.3 MiB (1.2 MiB/s) with 359 file(s) remaining
Completed 378.6 MiB/662.3 MiB (1.2 MiB/s) with 358 file(s) remaining
Completed 378.7 MiB/662.3 MiB (1.2 MiB/s) with 357 file(s) remaining
Completed 378.8 MiB/662.3 MiB (1.2 MiB/s) with 356 file(s) remaining
Completed 379.7 MiB/662.3 MiB (1.2 MiB/s) with 355 file(s) remaining
Completed 380.0 MiB/662.3 MiB (1.2 MiB/s) with 354 file(s) remaining
Completed 380.0 MiB/662.3 MiB (1.2 MiB/s) with 353 file(s) remaining
Completed 381.0 MiB/662.3 MiB (1.2 MiB/s) with 352 file(s) remaining
Completed 381.0 MiB/662.3 MiB (1.2 MiB/s) with 351 file(s) remaining
Completed 381.5 MiB/662.3 MiB (1.2 MiB/s) with 350 file(s) remaining
Completed 382.0 MiB/662.3 MiB (1.2 MiB/s) with 349 file(s) remaining
Completed 382.3 MiB/662.3 MiB (1.2 MiB/s) with 348 file(s) remaining
Completed 382.6 MiB/662.3 MiB (1.2 MiB/s) with 347 file(s) remaining
Completed 383.1 MiB/662.3 MiB (1.2 MiB/s) with 346 file(s) remaining
Completed 383.4 MiB/662.3 MiB (1.2 MiB/s) with 345 file(s) remaining
Completed 383.6 MiB/662.3 MiB (1.2 MiB/s) with 344 file(s) remaining
Completed 383.8 MiB/662.3 MiB (1.2 MiB/s) with 343 file(s) remaining
Completed 384.0 MiB/662.3 MiB (1.2 MiB/s) with 342 file(s) remaining
Completed 384.2 MiB/662.3 MiB (1.2 MiB/s) with 341 file(s) remaining
Completed 384.2 MiB/662.3 MiB (1.2 MiB/s) with 340 file(s) remaining
Completed 384.2 MiB/662.3 MiB (1.2 MiB/s) with 339 file(s) remaining
Completed 385.1 MiB/662.3 MiB (1.2 MiB/s) with 338 file(s) remaining
Completed 385.5 MiB/662.3 MiB (1.2 MiB/s) with 337 file(s) remaining
Completed 386.3 MiB/662.3 MiB (1.2 MiB/s) with 336 file(s) remaining
Completed 386.8 MiB/662.3 MiB (1.2 MiB/s) with 335 file(s) remaining
Completed 387.0 MiB/662.3 MiB (1.2 MiB/s) with 334 file(s) remaining
Completed 388.0 MiB/662.3 MiB (1.2 MiB/s) with 333 file(s) remaining
Completed 388.7 MiB/662.3 MiB (1.2 MiB/s) with 332 file(s) remaining
Completed 389.2 MiB/662.3 MiB (1.2 MiB/s) with 331 file(s) remaining
Completed 389.9 MiB/662.3 MiB (1.2 MiB/s) with 330 file(s) remaining
Completed 390.0 MiB/662.3 MiB (1.2 MiB/s) with 329 file(s) remaining
Completed 391.4 MiB/662.3 MiB (1.2 MiB/s) with 328 file(s) remaining
Completed 392.4 MiB/662.3 MiB (1.3 MiB/s) with 327 file(s) remaining
Completed 393.3 MiB/662.3 MiB (1.3 MiB/s) with 326 file(s) remaining
Completed 393.5 MiB/662.3 MiB (1.3 MiB/s) with 325 file(s) remaining
Completed 393.5 MiB/662.3 MiB (1.3 MiB/s) with 324 file(s) remaining
Completed 395.6 MiB/662.3 MiB (1.2 MiB/s) with 323 file(s) remaining
Completed 395.9 MiB/662.3 MiB (1.2 MiB/s) with 322 file(s) remaining
Completed 396.0 MiB/662.3 MiB (1.2 MiB/s) with 321 file(s) remaining
Completed 396.7 MiB/662.3 MiB (1.2 MiB/s) with 320 file(s) remaining
Completed 397.3 MiB/662.3 MiB (1.2 MiB/s) with 319 file(s) remaining
Completed 398.2 MiB/662.3 MiB (1.2 MiB/s) with 318 file(s) remaining
Completed 398.9 MiB/662.3 MiB (1.2 MiB/s) with 317 file(s) remaining
Completed 399.4 MiB/662.3 MiB (1.2 MiB/s) with 316 file(s) remaining
Completed 399.7 MiB/662.3 MiB (1.2 MiB/s) with 315 file(s) remaining
Completed 401.2 MiB/662.3 MiB (1.2 MiB/s) with 314 file(s) remaining
Completed 401.9 MiB/662.3 MiB (1.2 MiB/s) with 313 file(s) remaining
Completed 401.9 MiB/662.3 MiB (1.2 MiB/s) with 312 file(s) remaining
Completed 403.4 MiB/662.3 MiB (1.2 MiB/s) with 311 file(s) remaining
Completed 404.1 MiB/662.3 MiB (1.2 MiB/s) with 310 file(s) remaining
Completed 405.3 MiB/662.3 MiB (1.3 MiB/s) with 309 file(s) remaining
Completed 406.3 MiB/662.3 MiB (1.3 MiB/s) with 308 file(s) remaining
Completed 406.9 MiB/662.3 MiB (1.3 MiB/s) with 307 file(s) remaining
Completed 407.7 MiB/662.3 MiB (1.3 MiB/s) with 306 file(s) remaining
Completed 407.9 MiB/662.3 MiB (1.3 MiB/s) with 305 file(s) remaining
Completed 409.5 MiB/662.3 MiB (1.3 MiB/s) with 304 file(s) remaining
Completed 410.6 MiB/662.3 MiB (1.3 MiB/s) with 303 file(s) remaining
Completed 410.9 MiB/662.3 MiB (1.3 MiB/s) with 302 file(s) remaining
Completed 411.2 MiB/662.3 MiB (1.2 MiB/s) with 301 file(s) remaining
Completed 411.7 MiB/662.3 MiB (1.2 MiB/s) with 300 file(s) remaining
Completed 412.0 MiB/662.3 MiB (1.2 MiB/s) with 299 file(s) remaining
Completed 412.3 MiB/662.3 MiB (1.2 MiB/s) with 298 file(s) remaining
Completed 412.7 MiB/662.3 MiB (1.2 MiB/s) with 297 file(s) remaining
Completed 413.2 MiB/662.3 MiB (1.2 MiB/s) with 296 file(s) remaining
Completed 413.3 MiB/662.3 MiB (1.2 MiB/s) with 295 file(s) remaining
Completed 414.8 MiB/662.3 MiB (1.2 MiB/s) with 294 file(s) remaining
Completed 415.5 MiB/662.3 MiB (1.2 MiB/s) with 293 file(s) remaining
Completed 415.9 MiB/662.3 MiB (1.2 MiB/s) with 292 file(s) remaining
Completed 416.0 MiB/662.3 MiB (1.2 MiB/s) with 291 file(s) remaining
Completed 416.7 MiB/662.3 MiB (1.2 MiB/s) with 290 file(s) remaining
Completed 416.9 MiB/662.3 MiB (1.2 MiB/s) with 289 file(s) remaining
Completed 417.4 MiB/662.3 MiB (1.2 MiB/s) with 288 file(s) remaining
Completed 418.1 MiB/662.3 MiB (1.2 MiB/s) with 287 file(s) remaining
Completed 418.4 MiB/662.3 MiB (1.2 MiB/s) with 286 file(s) remaining
Completed 418.7 MiB/662.3 MiB (1.2 MiB/s) with 285 file(s) remaining
Completed 419.0 MiB/662.3 MiB (1.2 MiB/s) with 284 file(s) remaining
Completed 419.4 MiB/662.3 MiB (1.2 MiB/s) with 283 file(s) remaining
Completed 420.2 MiB/662.3 MiB (1.2 MiB/s) with 282 file(s) remaining
Completed 420.7 MiB/662.3 MiB (1.2 MiB/s) with 281 file(s) remaining
Completed 421.1 MiB/662.3 MiB (1.2 MiB/s) with 280 file(s) remaining
Completed 421.5 MiB/662.3 MiB (1.2 MiB/s) with 279 file(s) remaining
Completed 421.7 MiB/662.3 MiB (1.2 MiB/s) with 278 file(s) remaining
Completed 422.4 MiB/662.3 MiB (1.2 MiB/s) with 277 file(s) remaining
Completed 422.7 MiB/662.3 MiB (1.2 MiB/s) with 276 file(s) remaining
Completed 423.1 MiB/662.3 MiB (1.2 MiB/s) with 275 file(s) remaining
Completed 423.4 MiB/662.3 MiB (1.2 MiB/s) with 274 file(s) remaining
Completed 423.8 MiB/662.3 MiB (1.2 MiB/s) with 273 file(s) remaining
Completed 424.0 MiB/662.3 MiB (1.2 MiB/s) with 272 file(s) remaining
Completed 424.3 MiB/662.3 MiB (1.2 MiB/s) with 271 file(s) remaining
Completed 424.7 MiB/662.3 MiB (1.2 MiB/s) with 270 file(s) remaining
Completed 425.4 MiB/662.3 MiB (1.2 MiB/s) with 269 file(s) remaining
Completed 426.2 MiB/662.3 MiB (1.2 MiB/s) with 268 file(s) remaining
Completed 426.7 MiB/662.3 MiB (1.2 MiB/s) with 267 file(s) remaining
Completed 427.1 MiB/662.3 MiB (1.2 MiB/s) with 266 file(s) remaining
Completed 427.8 MiB/662.3 MiB (1.2 MiB/s) with 265 file(s) remaining
Completed 428.2 MiB/662.3 MiB (1.2 MiB/s) with 264 file(s) remaining
Completed 428.9 MiB/662.3 MiB (1.2 MiB/s) with 263 file(s) remaining
Completed 429.6 MiB/662.3 MiB (1.2 MiB/s) with 262 file(s) remaining
Completed 430.5 MiB/662.3 MiB (1.2 MiB/s) with 261 file(s) remaining
Completed 431.4 MiB/662.3 MiB (1.2 MiB/s) with 260 file(s) remaining
Completed 431.8 MiB/662.3 MiB (1.2 MiB/s) with 259 file(s) remaining
Completed 432.4 MiB/662.3 MiB (1.2 MiB/s) with 258 file(s) remaining
Completed 433.3 MiB/662.3 MiB (1.2 MiB/s) with 257 file(s) remaining
Completed 434.0 MiB/662.3 MiB (1.2 MiB/s) with 256 file(s) remaining
Completed 434.0 MiB/662.3 MiB (1.2 MiB/s) with 255 file(s) remaining
Completed 435.2 MiB/662.3 MiB (1.2 MiB/s) with 254 file(s) remaining
Completed 435.9 MiB/662.3 MiB (1.2 MiB/s) with 253 file(s) remaining
Completed 436.7 MiB/662.3 MiB (1.2 MiB/s) with 252 file(s) remaining
Completed 437.2 MiB/662.3 MiB (1.2 MiB/s) with 251 file(s) remaining
Completed 437.7 MiB/662.3 MiB (1.2 MiB/s) with 250 file(s) remaining
Completed 438.0 MiB/662.3 MiB (1.2 MiB/s) with 249 file(s) remaining
Completed 438.2 MiB/662.3 MiB (1.2 MiB/s) with 248 file(s) remaining
Completed 439.0 MiB/662.3 MiB (1.2 MiB/s) with 247 file(s) remaining
Completed 439.3 MiB/662.3 MiB (1.2 MiB/s) with 246 file(s) remaining
Completed 439.9 MiB/662.3 MiB (1.2 MiB/s) with 245 file(s) remaining
Completed 440.8 MiB/662.3 MiB (1.2 MiB/s) with 244 file(s) remaining
Completed 441.4 MiB/662.3 MiB (1.2 MiB/s) with 243 file(s) remaining
Completed 442.0 MiB/662.3 MiB (1.2 MiB/s) with 242 file(s) remaining
Completed 443.2 MiB/662.3 MiB (1.2 MiB/s) with 241 file(s) remaining
Completed 443.8 MiB/662.3 MiB (1.2 MiB/s) with 240 file(s) remaining
Completed 444.4 MiB/662.3 MiB (1.2 MiB/s) with 239 file(s) remaining
Completed 445.0 MiB/662.3 MiB (1.2 MiB/s) with 238 file(s) remaining
Completed 445.8 MiB/662.3 MiB (1.2 MiB/s) with 237 file(s) remaining
Completed 446.3 MiB/662.3 MiB (1.2 MiB/s) with 236 file(s) remaining
Completed 447.5 MiB/662.3 MiB (1.2 MiB/s) with 235 file(s) remaining
Completed 448.3 MiB/662.3 MiB (1.2 MiB/s) with 234 file(s) remaining
Completed 448.9 MiB/662.3 MiB (1.3 MiB/s) with 233 file(s) remaining
Completed 449.7 MiB/662.3 MiB (1.3 MiB/s) with 232 file(s) remaining
Completed 450.4 MiB/662.3 MiB (1.2 MiB/s) with 231 file(s) remaining
Completed 450.6 MiB/662.3 MiB (1.2 MiB/s) with 230 file(s) remaining
Completed 451.6 MiB/662.3 MiB (1.2 MiB/s) with 229 file(s) remaining
Completed 452.5 MiB/662.3 MiB (1.2 MiB/s) with 228 file(s) remaining
Completed 452.6 MiB/662.3 MiB (1.2 MiB/s) with 227 file(s) remaining
Completed 453.7 MiB/662.3 MiB (1.2 MiB/s) with 226 file(s) remaining
Completed 454.7 MiB/662.3 MiB (1.2 MiB/s) with 225 file(s) remaining
Completed 455.3 MiB/662.3 MiB (1.2 MiB/s) with 224 file(s) remaining
Completed 455.9 MiB/662.3 MiB (1.2 MiB/s) with 223 file(s) remaining
Completed 456.6 MiB/662.3 MiB (1.2 MiB/s) with 222 file(s) remaining
Completed 457.1 MiB/662.3 MiB (1.2 MiB/s) with 221 file(s) remaining
Completed 457.2 MiB/662.3 MiB (1.2 MiB/s) with 220 file(s) remaining
Completed 458.6 MiB/662.3 MiB (1.2 MiB/s) with 219 file(s) remaining
Completed 458.6 MiB/662.3 MiB (1.2 MiB/s) with 218 file(s) remaining
Completed 459.6 MiB/662.3 MiB (1.2 MiB/s) with 217 file(s) remaining
Completed 460.9 MiB/662.3 MiB (1.2 MiB/s) with 216 file(s) remaining
Completed 461.5 MiB/662.3 MiB (1.2 MiB/s) with 215 file(s) remaining
Completed 462.2 MiB/662.3 MiB (1.2 MiB/s) with 214 file(s) remaining
Completed 463.0 MiB/662.3 MiB (1.2 MiB/s) with 213 file(s) remaining
Completed 464.1 MiB/662.3 MiB (1.3 MiB/s) with 212 file(s) remaining
Completed 465.2 MiB/662.3 MiB (1.2 MiB/s) with 211 file(s) remaining
Completed 466.1 MiB/662.3 MiB (1.2 MiB/s) with 210 file(s) remaining
Completed 466.7 MiB/662.3 MiB (1.2 MiB/s) with 209 file(s) remaining
Completed 467.5 MiB/662.3 MiB (1.2 MiB/s) with 208 file(s) remaining
Completed 468.0 MiB/662.3 MiB (1.2 MiB/s) with 207 file(s) remaining
Completed 468.7 MiB/662.3 MiB (1.2 MiB/s) with 206 file(s) remaining
Completed 468.7 MiB/662.3 MiB (1.2 MiB/s) with 205 file(s) remaining
Completed 468.9 MiB/662.3 MiB (1.2 MiB/s) with 204 file(s) remaining
Completed 470.0 MiB/662.3 MiB (1.2 MiB/s) with 203 file(s) remaining
Completed 470.3 MiB/662.3 MiB (1.2 MiB/s) with 202 file(s) remaining
Completed 470.9 MiB/662.3 MiB (1.2 MiB/s) with 201 file(s) remaining
Completed 471.4 MiB/662.3 MiB (1.2 MiB/s) with 200 file(s) remaining
Completed 471.8 MiB/662.3 MiB (1.2 MiB/s) with 199 file(s) remaining
Completed 471.9 MiB/662.3 MiB (1.2 MiB/s) with 198 file(s) remaining
Completed 472.1 MiB/662.3 MiB (1.2 MiB/s) with 197 file(s) remaining
Completed 472.3 MiB/662.3 MiB (1.2 MiB/s) with 196 file(s) remaining
Completed 472.4 MiB/662.3 MiB (1.2 MiB/s) with 195 file(s) remaining
Completed 472.4 MiB/662.3 MiB (1.2 MiB/s) with 194 file(s) remaining
Completed 472.5 MiB/662.3 MiB (1.2 MiB/s) with 193 file(s) remaining
Completed 472.5 MiB/662.3 MiB (1.2 MiB/s) with 192 file(s) remaining
Completed 472.6 MiB/662.3 MiB (1.2 MiB/s) with 191 file(s) remaining
Completed 473.5 MiB/662.3 MiB (1.2 MiB/s) with 190 file(s) remaining
Completed 474.1 MiB/662.3 MiB (1.2 MiB/s) with 189 file(s) remaining
Completed 474.3 MiB/662.3 MiB (1.2 MiB/s) with 188 file(s) remaining
Completed 475.8 MiB/662.3 MiB (1.2 MiB/s) with 187 file(s) remaining
Completed 475.9 MiB/662.3 MiB (1.2 MiB/s) with 186 file(s) remaining
Completed 477.0 MiB/662.3 MiB (1.2 MiB/s) with 185 file(s) remaining
Completed 477.9 MiB/662.3 MiB (1.2 MiB/s) with 184 file(s) remaining
Completed 478.4 MiB/662.3 MiB (1.2 MiB/s) with 183 file(s) remaining
Completed 478.4 MiB/662.3 MiB (1.2 MiB/s) with 182 file(s) remaining
Completed 480.6 MiB/662.3 MiB (1.2 MiB/s) with 181 file(s) remaining
Completed 481.7 MiB/662.3 MiB (1.2 MiB/s) with 180 file(s) remaining
Completed 482.2 MiB/662.3 MiB (1.2 MiB/s) with 179 file(s) remaining
Completed 482.3 MiB/662.3 MiB (1.2 MiB/s) with 178 file(s) remaining
Completed 482.5 MiB/662.3 MiB (1.2 MiB/s) with 177 file(s) remaining
Completed 482.5 MiB/662.3 MiB (1.2 MiB/s) with 176 file(s) remaining
Completed 482.5 MiB/662.3 MiB (1.2 MiB/s) with 175 file(s) remaining
Completed 482.6 MiB/662.3 MiB (1.2 MiB/s) with 174 file(s) remaining
Completed 482.6 MiB/662.3 MiB (1.2 MiB/s) with 173 file(s) remaining
Completed 484.5 MiB/662.3 MiB (1.2 MiB/s) with 172 file(s) remaining
Completed 485.7 MiB/662.3 MiB (1.3 MiB/s) with 171 file(s) remaining
Completed 486.5 MiB/662.3 MiB (1.3 MiB/s) with 170 file(s) remaining
Completed 487.6 MiB/662.3 MiB (1.3 MiB/s) with 169 file(s) remaining
Completed 489.0 MiB/662.3 MiB (1.2 MiB/s) with 168 file(s) remaining
Completed 489.7 MiB/662.3 MiB (1.2 MiB/s) with 167 file(s) remaining
Completed 491.2 MiB/662.3 MiB (1.2 MiB/s) with 166 file(s) remaining
Completed 491.9 MiB/662.3 MiB (1.2 MiB/s) with 165 file(s) remaining
Completed 492.8 MiB/662.3 MiB (1.2 MiB/s) with 164 file(s) remaining
Completed 493.6 MiB/662.3 MiB (1.3 MiB/s) with 163 file(s) remaining
Completed 494.2 MiB/662.3 MiB (1.3 MiB/s) with 162 file(s) remaining
Completed 495.5 MiB/662.3 MiB (1.3 MiB/s) with 161 file(s) remaining
Completed 498.0 MiB/662.3 MiB (1.3 MiB/s) with 160 file(s) remaining
Completed 501.0 MiB/662.3 MiB (1.3 MiB/s) with 159 file(s) remaining
Completed 502.0 MiB/662.3 MiB (1.2 MiB/s) with 158 file(s) remaining
Completed 503.1 MiB/662.3 MiB (1.3 MiB/s) with 157 file(s) remaining
Completed 504.3 MiB/662.3 MiB (1.2 MiB/s) with 156 file(s) remaining
Completed 504.3 MiB/662.3 MiB (1.2 MiB/s) with 155 file(s) remaining
Completed 505.6 MiB/662.3 MiB (1.2 MiB/s) with 154 file(s) remaining
Completed 505.7 MiB/662.3 MiB (1.2 MiB/s) with 153 file(s) remaining
Completed 507.0 MiB/662.3 MiB (1.2 MiB/s) with 152 file(s) remaining
Completed 507.5 MiB/662.3 MiB (1.2 MiB/s) with 151 file(s) remaining
Completed 507.9 MiB/662.3 MiB (1.2 MiB/s) with 150 file(s) remaining
Completed 512.2 MiB/662.3 MiB (1.3 MiB/s) with 149 file(s) remaining
Completed 513.2 MiB/662.3 MiB (1.3 MiB/s) with 148 file(s) remaining
Completed 515.1 MiB/662.3 MiB (1.3 MiB/s) with 147 file(s) remaining
Completed 516.5 MiB/662.3 MiB (1.2 MiB/s) with 146 file(s) remaining
Completed 517.8 MiB/662.3 MiB (1.2 MiB/s) with 145 file(s) remaining
Completed 518.5 MiB/662.3 MiB (1.2 MiB/s) with 144 file(s) remaining
Completed 518.8 MiB/662.3 MiB (1.2 MiB/s) with 143 file(s) remaining
Completed 520.5 MiB/662.3 MiB (1.2 MiB/s) with 142 file(s) remaining
Completed 522.1 MiB/662.3 MiB (1.3 MiB/s) with 141 file(s) remaining
Completed 523.1 MiB/662.3 MiB (1.3 MiB/s) with 140 file(s) remaining
Completed 524.8 MiB/662.3 MiB (1.3 MiB/s) with 139 file(s) remaining
Completed 529.1 MiB/662.3 MiB (1.3 MiB/s) with 138 file(s) remaining
Completed 530.4 MiB/662.3 MiB (1.2 MiB/s) with 137 file(s) remaining
Completed 531.2 MiB/662.3 MiB (1.2 MiB/s) with 136 file(s) remaining
Completed 532.7 MiB/662.3 MiB (1.2 MiB/s) with 135 file(s) remaining
Completed 533.2 MiB/662.3 MiB (1.2 MiB/s) with 134 file(s) remaining
Completed 533.8 MiB/662.3 MiB (1.2 MiB/s) with 133 file(s) remaining
Completed 534.7 MiB/662.3 MiB (1.2 MiB/s) with 132 file(s) remaining
Completed 535.4 MiB/662.3 MiB (1.2 MiB/s) with 131 file(s) remaining
Completed 536.3 MiB/662.3 MiB (1.2 MiB/s) with 130 file(s) remaining
Completed 537.3 MiB/662.3 MiB (1.2 MiB/s) with 129 file(s) remaining
Completed 538.1 MiB/662.3 MiB (1.2 MiB/s) with 128 file(s) remaining
Completed 539.6 MiB/662.3 MiB (1.2 MiB/s) with 127 file(s) remaining
Completed 540.6 MiB/662.3 MiB (1.2 MiB/s) with 126 file(s) remaining
Completed 541.7 MiB/662.3 MiB (1.2 MiB/s) with 125 file(s) remaining
Completed 542.4 MiB/662.3 MiB (1.2 MiB/s) with 124 file(s) remaining
Completed 543.3 MiB/662.3 MiB (1.2 MiB/s) with 123 file(s) remaining
Completed 543.3 MiB/662.3 MiB (1.2 MiB/s) with 122 file(s) remaining
Completed 544.8 MiB/662.3 MiB (1.2 MiB/s) with 121 file(s) remaining
Completed 545.4 MiB/662.3 MiB (1.2 MiB/s) with 120 file(s) remaining
Completed 546.1 MiB/662.3 MiB (1.2 MiB/s) with 119 file(s) remaining
Completed 546.8 MiB/662.3 MiB (1.2 MiB/s) with 118 file(s) remaining
Completed 547.9 MiB/662.3 MiB (1.2 MiB/s) with 117 file(s) remaining
Completed 548.8 MiB/662.3 MiB (1.2 MiB/s) with 116 file(s) remaining
Completed 549.9 MiB/662.3 MiB (1.2 MiB/s) with 115 file(s) remaining
Completed 550.8 MiB/662.3 MiB (1.2 MiB/s) with 114 file(s) remaining
Completed 552.0 MiB/662.3 MiB (1.2 MiB/s) with 113 file(s) remaining
Completed 552.8 MiB/662.3 MiB (1.2 MiB/s) with 112 file(s) remaining
Completed 553.4 MiB/662.3 MiB (1.2 MiB/s) with 111 file(s) remaining
Completed 554.3 MiB/662.3 MiB (1.2 MiB/s) with 110 file(s) remaining
Completed 555.0 MiB/662.3 MiB (1.2 MiB/s) with 109 file(s) remaining
Completed 555.9 MiB/662.3 MiB (1.2 MiB/s) with 108 file(s) remaining
Completed 556.4 MiB/662.3 MiB (1.2 MiB/s) with 107 file(s) remaining
Completed 557.5 MiB/662.3 MiB (1.2 MiB/s) with 106 file(s) remaining
Completed 558.1 MiB/662.3 MiB (1.2 MiB/s) with 105 file(s) remaining
Completed 559.0 MiB/662.3 MiB (1.2 MiB/s) with 104 file(s) remaining
Completed 560.0 MiB/662.3 MiB (1.2 MiB/s) with 103 file(s) remaining
Completed 560.5 MiB/662.3 MiB (1.2 MiB/s) with 102 file(s) remaining
Completed 561.1 MiB/662.3 MiB (1.2 MiB/s) with 101 file(s) remaining
Completed 561.9 MiB/662.3 MiB (1.2 MiB/s) with 100 file(s) remaining
Completed 562.7 MiB/662.3 MiB (1.2 MiB/s) with 99 file(s) remaining
Completed 563.7 MiB/662.3 MiB (1.2 MiB/s) with 98 file(s) remaining
Completed 564.6 MiB/662.3 MiB (1.2 MiB/s) with 97 file(s) remaining
Completed 565.8 MiB/662.3 MiB (1.2 MiB/s) with 96 file(s) remaining
Completed 566.9 MiB/662.3 MiB (1.2 MiB/s) with 95 file(s) remaining
Completed 567.5 MiB/662.3 MiB (1.2 MiB/s) with 94 file(s) remaining
Completed 568.1 MiB/662.3 MiB (1.2 MiB/s) with 93 file(s) remaining
Completed 570.1 MiB/662.3 MiB (1.3 MiB/s) with 92 file(s) remaining
Completed 572.0 MiB/662.3 MiB (1.2 MiB/s) with 91 file(s) remaining
Completed 572.9 MiB/662.3 MiB (1.2 MiB/s) with 90 file(s) remaining
Completed 574.3 MiB/662.3 MiB (1.3 MiB/s) with 89 file(s) remaining
Completed 575.5 MiB/662.3 MiB (1.3 MiB/s) with 88 file(s) remaining
Completed 576.6 MiB/662.3 MiB (1.2 MiB/s) with 87 file(s) remaining
Completed 578.2 MiB/662.3 MiB (1.2 MiB/s) with 86 file(s) remaining
Completed 579.2 MiB/662.3 MiB (1.2 MiB/s) with 85 file(s) remaining
Completed 579.9 MiB/662.3 MiB (1.2 MiB/s) with 84 file(s) remaining
Completed 580.5 MiB/662.3 MiB (1.2 MiB/s) with 83 file(s) remaining
Completed 580.6 MiB/662.3 MiB (1.2 MiB/s) with 82 file(s) remaining
Completed 581.4 MiB/662.3 MiB (1.2 MiB/s) with 81 file(s) remaining
Completed 581.5 MiB/662.3 MiB (1.2 MiB/s) with 80 file(s) remaining
Completed 583.3 MiB/662.3 MiB (1.2 MiB/s) with 79 file(s) remaining
Completed 584.4 MiB/662.3 MiB (1.2 MiB/s) with 78 file(s) remaining
Completed 586.3 MiB/662.3 MiB (1.2 MiB/s) with 77 file(s) remaining
Completed 587.4 MiB/662.3 MiB (1.2 MiB/s) with 76 file(s) remaining
Completed 588.0 MiB/662.3 MiB (1.2 MiB/s) with 75 file(s) remaining
Completed 588.9 MiB/662.3 MiB (1.2 MiB/s) with 74 file(s) remaining
Completed 589.4 MiB/662.3 MiB (1.2 MiB/s) with 73 file(s) remaining
Completed 589.7 MiB/662.3 MiB (1.2 MiB/s) with 72 file(s) remaining
Completed 592.0 MiB/662.3 MiB (1.2 MiB/s) with 71 file(s) remaining
Completed 594.7 MiB/662.3 MiB (1.2 MiB/s) with 70 file(s) remaining
Completed 594.9 MiB/662.3 MiB (1.2 MiB/s) with 69 file(s) remaining
Completed 598.0 MiB/662.3 MiB (1.2 MiB/s) with 68 file(s) remaining
Completed 600.7 MiB/662.3 MiB (1.2 MiB/s) with 67 file(s) remaining
Completed 601.2 MiB/662.3 MiB (1.2 MiB/s) with 66 file(s) remaining
Completed 602.3 MiB/662.3 MiB (1.2 MiB/s) with 65 file(s) remaining
Completed 602.8 MiB/662.3 MiB (1.2 MiB/s) with 64 file(s) remaining
Completed 605.1 MiB/662.3 MiB (1.2 MiB/s) with 63 file(s) remaining
Completed 605.2 MiB/662.3 MiB (1.2 MiB/s) with 62 file(s) remaining
Completed 608.1 MiB/662.3 MiB (1.2 MiB/s) with 61 file(s) remaining
Completed 608.6 MiB/662.3 MiB (1.2 MiB/s) with 60 file(s) remaining
Completed 609.4 MiB/662.3 MiB (1.2 MiB/s) with 59 file(s) remaining
Completed 610.8 MiB/662.3 MiB (1.2 MiB/s) with 58 file(s) remaining
Completed 612.4 MiB/662.3 MiB (1.2 MiB/s) with 57 file(s) remaining
Completed 612.9 MiB/662.3 MiB (1.2 MiB/s) with 56 file(s) remaining
Completed 614.3 MiB/662.3 MiB (1.2 MiB/s) with 55 file(s) remaining
Completed 616.0 MiB/662.3 MiB (1.2 MiB/s) with 54 file(s) remaining
Completed 617.7 MiB/662.3 MiB (1.2 MiB/s) with 53 file(s) remaining
Completed 618.5 MiB/662.3 MiB (1.2 MiB/s) with 52 file(s) remaining
Completed 619.6 MiB/662.3 MiB (1.2 MiB/s) with 51 file(s) remaining
Completed 622.0 MiB/662.3 MiB (1.2 MiB/s) with 50 file(s) remaining
Completed 624.1 MiB/662.3 MiB (1.2 MiB/s) with 49 file(s) remaining
Completed 624.8 MiB/662.3 MiB (1.2 MiB/s) with 48 file(s) remaining
Completed 626.3 MiB/662.3 MiB (1.2 MiB/s) with 47 file(s) remaining
Completed 627.3 MiB/662.3 MiB (1.2 MiB/s) with 46 file(s) remaining
Completed 627.8 MiB/662.3 MiB (1.2 MiB/s) with 45 file(s) remaining
Completed 628.7 MiB/662.3 MiB (1.2 MiB/s) with 44 file(s) remaining
Completed 630.2 MiB/662.3 MiB (1.2 MiB/s) with 43 file(s) remaining
Completed 631.5 MiB/662.3 MiB (1.2 MiB/s) with 42 file(s) remaining
Completed 633.2 MiB/662.3 MiB (1.2 MiB/s) with 41 file(s) remaining
Completed 633.8 MiB/662.3 MiB (1.2 MiB/s) with 40 file(s) remaining
Completed 636.9 MiB/662.3 MiB (1.2 MiB/s) with 39 file(s) remaining
Completed 638.4 MiB/662.3 MiB (1.2 MiB/s) with 38 file(s) remaining
Completed 639.1 MiB/662.3 MiB (1.2 MiB/s) with 37 file(s) remaining
Completed 640.2 MiB/662.3 MiB (1.2 MiB/s) with 36 file(s) remaining
Completed 641.3 MiB/662.3 MiB (1.2 MiB/s) with 35 file(s) remaining
Completed 642.4 MiB/662.3 MiB (1.2 MiB/s) with 34 file(s) remaining
Completed 643.3 MiB/662.3 MiB (1.2 MiB/s) with 33 file(s) remaining
Completed 644.0 MiB/662.3 MiB (1.2 MiB/s) with 32 file(s) remaining
Completed 644.4 MiB/662.3 MiB (1.2 MiB/s) with 31 file(s) remaining
Completed 644.5 MiB/662.3 MiB (1.2 MiB/s) with 30 file(s) remaining
Completed 644.6 MiB/662.3 MiB (1.2 MiB/s) with 29 file(s) remaining
Completed 644.7 MiB/662.3 MiB (1.2 MiB/s) with 28 file(s) remaining
Completed 645.1 MiB/662.3 MiB (1.2 MiB/s) with 27 file(s) remaining
Completed 645.8 MiB/662.3 MiB (1.2 MiB/s) with 26 file(s) remaining
Completed 646.5 MiB/662.3 MiB (1.2 MiB/s) with 25 file(s) remaining
Completed 647.0 MiB/662.3 MiB (1.2 MiB/s) with 24 file(s) remaining
Completed 648.0 MiB/662.3 MiB (1.2 MiB/s) with 23 file(s) remaining
Completed 648.9 MiB/662.3 MiB (1.2 MiB/s) with 22 file(s) remaining
Completed 649.3 MiB/662.3 MiB (1.2 MiB/s) with 21 file(s) remaining
Completed 651.0 MiB/662.3 MiB (1.2 MiB/s) with 20 file(s) remaining
Completed 651.9 MiB/662.3 MiB (1.2 MiB/s) with 19 file(s) remaining
Completed 653.6 MiB/662.3 MiB (1.2 MiB/s) with 18 file(s) remaining
Completed 654.5 MiB/662.3 MiB (1.2 MiB/s) with 17 file(s) remaining
Completed 655.6 MiB/662.3 MiB (1.2 MiB/s) with 16 file(s) remaining
Completed 657.1 MiB/662.3 MiB (1.2 MiB/s) with 15 file(s) remaining
Completed 658.0 MiB/662.3 MiB (1.2 MiB/s) with 14 file(s) remaining
Completed 658.4 MiB/662.3 MiB (1.2 MiB/s) with 13 file(s) remaining
Completed 658.6 MiB/662.3 MiB (1.2 MiB/s) with 12 file(s) remaining
Completed 659.8 MiB/662.3 MiB (1.2 MiB/s) with 11 file(s) remaining
Completed 659.9 MiB/662.3 MiB (1.2 MiB/s) with 10 file(s) remaining
Completed 659.9 MiB/662.3 MiB (1.2 MiB/s) with 9 file(s) remaining
Completed 659.9 MiB/662.3 MiB (1.2 MiB/s) with 8 file(s) remaining
Completed 660.3 MiB/662.3 MiB (1.2 MiB/s) with 7 file(s) remaining
Completed 660.7 MiB/662.3 MiB (1.2 MiB/s) with 6 file(s) remaining
Completed 660.7 MiB/662.3 MiB (1.2 MiB/s) with 5 file(s) remaining
Completed 660.8 MiB/662.3 MiB (1.2 MiB/s) with 4 file(s) remaining
Completed 661.8 MiB/662.3 MiB (1.2 MiB/s) with 3 file(s) remaining
Completed 662.1 MiB/662.3 MiB (1.2 MiB/s) with 2 file(s) remaining
Completed 662.1 MiB/662.3 MiB (1.2 MiB/s) with 1 file(s) remaining
```
