require_relative "spec_helper.rb"
require_relative "../lib/board.rb"

describe Board do
  before(:all) do
    @test_board = Board.new
  end

  describe("#new_board") do
    it "returns a hash of tile positions" do
      expect(@test_board.tiles).to be_instance_of(Hash)
    end

    it "returns a board of empty tiles" do
      @test_board.tiles.each_value do |tile|
        expect(tile).to eq("")
      end
    end
  end

  describe("#full?") do
    it "returns false with a fresh board" do
      expect(@test_board.full?).to eq(false)
    end

    it "returns true with a full board" do
      @test_board.update_all("x")
      expect(@test_board.full?).to eq(true)
    end
  end
end
