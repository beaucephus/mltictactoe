Dir["../lib/*.rb"].each { |file| require_relative file }
require "pry"
require "pry-byebug"
require "redis"

RSpec::Matchers.define :not_change_token_tiles do |expected|
  match do |actual|
    (0..2).each do |i|
      (0..2).each do |j|
        return false if !expected[i][j].empty? && actual[i][j] != expected[i][j]
      end
    end
    true
  end
end

RSpec::Matchers.define :update_single_empty_tile do |expected|
  match do |actual|
    updated_tiles = 0
    (0..2).each do |i|
      (0..2).each do |j|
        updated_tiles += 1 if expected[i][j].empty? && !actual[i][j].empty?
      end
    end
    return false if updated_tiles != 1

    true
  end
end
