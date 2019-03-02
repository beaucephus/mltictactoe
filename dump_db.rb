require "redis"
require "yaml"

r = Redis.new

keys = r.keys

keys.each do |key|
  puts "#{key} => #{YAML.safe_load(r.get(key))}"
end
