#!/usr/bin/env ruby

Dir["lib/*.rb"].each { |file| require_relative file }
require "pry"
require "pry-byebug"
require "yaml"
require "redis"
include WeightsHelper

weights_lookup = Redis.new
num_rounds = ARGV[0].to_i
puts "Playing #{num_rounds} rounds..."
x_wins = 0
o_wins = 0
draws = 0

num_rounds.times do
  one_game = TicTacToe.new(weights_lookup)
  one_game.play

  if one_game.winner.nil?
    # puts "It's a draw!"
    draws += 1
  else
    # puts "#{one_game.winner} won!"
    if one_game.winner.token == "x"
      x_wins += 1
    else
      o_wins += 1
    end
    update_weights(weights_lookup, one_game.winner.decisions, one_game.loser.decisions)
  end
  # one_game.print_board
end

puts "x_wins: #{x_wins}(#{x_wins * 100.0 / num_rounds}%) \
       o_wins: #{o_wins}(#{o_wins * 100.0 / num_rounds}%) \
       ties: #{draws}(#{draws * 100.0 / num_rounds}%)"
