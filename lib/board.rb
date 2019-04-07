# Board
class Board
  def initialize
    @tiles = new_board
  end

  def new_board
    tile_hash = {}

    %w[a b c].each do |file|
      %w[1 2 3].each do |rank|
        tile_hash["#{file}#{rank}"] = ""
      end
    end

    tile_hash
  end

  def state
    state = ""
    %w[a b c].each do |file|
      %w[3 2 1].each do |rank|
        state += "#{tile(file, rank)}_"
      end
    end

    state[0, state.length - 1]
  end

  def to_s
    %w[3 2 1].each do |rank|
      puts "#{formatted_tile('a', rank)}|#{formatted_tile('b', rank)}|#{formatted_tile('c', rank)}"
    end

    nil
  end

  def formatted_tile(file, rank)
    return " " if tile(file, rank).empty?

    tile(file, rank)
  end

  def play_token_on_tile(token, file, rank)
    @tiles["#{file}#{rank}"] = token.to_s
  end

  def tile(file, rank)
    @tiles["#{file}#{rank}"]
  end

  def tiles_in_file(file)
    # TODO
  end

  def tiles_in_rank(rank)
    # TODO
  end

  def tiles_in_diagonal(file, rank)
    # TODO
  end

  def full?
    return false if @tiles.value?("")

    true
  end

  def update_all_tiles(token)
    @tiles.each_key do |k|
      @tiles[k] = token
    end
  end
end
