require_relative "spec_helper.rb"
require_relative "../lib/player.rb"
require_relative "../lib/weights_helper.rb"

boards = [
  [["", "", ""], ["", "", ""], ["", "", ""]],
  [["x", "", ""], ["", "", ""], ["", "", ""]],
  [["o", "", ""], ["", "", ""], ["", "", ""]],
  [["x", "x", "x"], ["x", "x", "x"], ["x", "x", ""]], # rubocop:disable Style/WordArray
  [["o", "o", "o"], ["o", "o", "o"], ["o", "o", ""]] # rubocop:disable Style/WordArray
]

describe Player do
  boards.each do |board|
    context "with board #{board.join(',')}" do
      describe "#take_turn" do
        before(:all) do
          @player = Player.new("x", "x")
          @expected_board = Marshal.load(Marshal.dump(board))
          @actual_board = @player.take_turn(board, Redis.new)
        end

        it "updates a single empty tile" do
          expect(@actual_board).to(update_single_empty_tile(@expected_board))
        end

        it "doesn't change existing token tiles" do
          expect(@actual_board).to not_change_token_tiles(@expected_board)
        end
      end
    end
  end

  describe "#decide" do
    before(:all) do
      @player = Player.new("x", "x")
    end

    ios = [
      [
        [%w[100 0 0], %w[0 0 0], %w[0 0 0]], [0, 0]
      ],
      [
        [%w[0 0 0], %w[0 100 0], %w[0 0 0]], [1, 1]
      ],
      [
        [%w[0 0 0], %w[0 0 0], %w[0 0 100]], [2, 2]
      ]
    ]

    ios.each do |io|
      context "with input:#{io[0]}" do
        it "returns #{io[1]}" do
          expect(@player.decide(io[0])).to eq(io[1])
        end
      end
    end
  end
end
