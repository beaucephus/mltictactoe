require_relative "weights_helper.rb"

# Player
class Player
  include WeightsHelper
  attr_accessor :name, :token, :decisions

  def initialize(name, token)
    @name = name
    @token = token
    @decisions = []
  end

  def to_s
    @name
  end

  def simple_turn(board)
    board.each_index do |i|
      board[i].each_index do |j|
        if board[i][j].empty?
          board[i][j] = @token
          return board
        end
      end
    end
  end

  def decide(weights)
    num = rand(1..100)
    i = 0
    j = 0
    count = 0
    while num > weights[i][j].to_i
      count += 1
      # binding.pry
      raise "Out of bounds!" if i > 2 || j > 2

      num -= weights[i][j].to_i
      if j >= 2
        j = 0
        i += 1
      else
        j += 1
      end
    end
    [i, j]
  end

  def weighted_turn(board, weights_lookup)
    weights_key = "#{board.join('_')}_#{@token}"
    decision = []
    weights = read_weights(weights_lookup, weights_key)

    loop do
      if weights.nil?
        decision[0] = rand(0..2)
        decision[1] = rand(0..2)
      else
        decision = decide(weights)
      end
      # puts "board: #{board}, decision: #{decision}"
      break if board[decision[0]][decision[1]].empty?
    end

    board[decision[0]][decision[1]] = @token
    @decisions << [weights_key, decision[0], decision[1]]
    board
  end

  def take_turn(board, weights_lookup)
    raise("Can't take a turn on a full board!") unless board.any? { |row| row.any?(&:empty?) }

    # simple_turn(board)
    weighted_turn(board, weights_lookup)
  end
end
