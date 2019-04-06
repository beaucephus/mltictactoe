#!/usr/bin/env ruby

Dir["lib/*.rb"].each { |file| require_relative file }
require "pry"
require "pry-byebug"
require "yaml"
require "redis"
include WeightsHelper

weights_lookup = Redis.new

one_game = TicTacToe.new(weights_lookup)
one_game.play_interactive

if one_game.winner.nil?
  puts "It's a draw!"
else
  puts "#{one_game.winner} won!"
  update_weights(weights_lookup, one_game.winner.decisions, one_game.loser.decisions)
end
