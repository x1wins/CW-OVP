# config/initializers/redis.rb

$redis = Redis::Namespace.new("cw_ovp", :redis => Redis.new(:host => '127.0.0.1', :port => 7001))

