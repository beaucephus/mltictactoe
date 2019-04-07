require_relative "spec_helper.rb"
require_relative "../lib/board.rb"

describe Board do
  before(:each) do
    @test_board = Board.new
  end

  describe("#new_board") do
    it "returns a hash of tile positions" do
      expect(@test_board.new_board).to be_instance_of(Hash)
    end

    it "returns a board of empty tiles" do
      @test_board.new_board.each_value do |tile|
        expect(tile).to eq("")
      end
    end
  end

  describe("#full?") do
    it "returns false with a fresh board" do
      expect(@test_board.full?).to eq(false)
    end

    it "returns true with a full board" do
      @test_board.update_all_tiles("x")
      expect(@test_board.full?).to eq(true)
    end
  end

  describe("#play_token_on_tile") do
    before do
      @test_board.play_token_on_tile("x", "a", "1")
    end

    it "sets a tile with the specified token" do
      expect(@test_board.instance_variable_get(:@tiles)["a1"]).to eq("x")
    end
  end

  describe("#tile") do
    before do
      @test_board.play_token_on_tile("x", "a", "1")
    end

    it "gets a tile with the specified position" do
      expect(@test_board.tile("a", "1")).to eq("x")
    end
  end

  describe("#state") do
    it "returns board state string" do
      expect(@test_board.state).to eq("________")
    end
  end
end
