require "redis"
require "yaml"

r = Redis.new

keys = r.keys

keys.each do |key|
  key_a = key.split("_")
  puts "#{key} => #{YAML.safe_load(r.get(key))}"
end
