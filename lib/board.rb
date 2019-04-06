# Board
class Board
  attr_accessor(:tiles)

  def initialize
    @tiles = new_board
  end

  def new_board
    tile_hash = {}

    (0..2).each do |row|
      (0..2).each do |column|
        tile_hash[[row, column]] = ""
      end
    end

    tile_hash
  end

  def full?
    return false if @tiles.value?("")

    true
  end

  def update_all(token)
    @tiles.each_key do |k|
      @tiles[k] = token
    end
  end
end
