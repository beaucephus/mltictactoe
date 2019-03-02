Dir["lib/*.rb"].each { |file| require_relative file }
require "pry"
require "pry-byebug"
require "yaml"
require "redis"
include WeightsHelper

weights_lookup = Redis.new
num_rounds = ARGV[0].to_i
puts "Playing #{num_rounds} rounds..."

num_rounds.times do
  one_game = TicTacToe.new(weights_lookup)
  one_game.play

  if one_game.winner.nil?
    puts "It's a draw!"
  else
    puts "#{one_game.winner} won!"
    update_weights(weights_lookup, one_game.winner.decisions, one_game.loser.decisions)
  end
  one_game.print_board
end
