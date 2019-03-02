# TicTacToe
class TicTacToe
  attr_accessor :board, :weights_lookup, :turn_player, :player_x, :player_y, :winner, :loser

  def initialize(weights_lookup)
    @board = [
      ["", "", ""],
      ["", "", ""],
      ["", "", ""]
    ]
    @weights_lookup = weights_lookup
    @player_x = Player.new("Xavier", "x")
    @player_o = Player.new("Ophelia", "o")
    @turn_player = @player_x
    @waiting_player = @player_o
    @winner = nil
    @loser = nil
  end

  def print_board
    @board.each do |row|
      puts row.map { |e| e.empty? ? " " : e }.join("|")
    end
  end

  def check_column_win
    if @board.all? { |column| column[0] == @turn_player.token } || \
       @board.all? { |column| column[1] == @turn_player.token } || \
       @board.all? { |column| column[2] == @turn_player.token }
      @winner = @turn_player
      @loser = @waiting_player
    end
  end

  def check_row_win
    if @board[0].all? { |row| row == @turn_player.token } || \
       @board[1].all? { |row| row == @turn_player.token } || \
       @board[2].all? { |row| row == @turn_player.token }
      @winner = @turn_player
      @loser = @waiting_player
    end
  end

  def check_diagonal_win # rubocop:disable Metrics/AbcSize
    if [@board[0][0], @board[1][1], @board[2][2]].all? { |diagonal| diagonal == @turn_player.token } || \
       [@board[0][2], @board[1][1], @board[2][0]].all? { |diagonal| diagonal == @turn_player.token }
      @winner = @turn_player
      @loser = @waiting_player
    end
  end

  def update_winner_loser
    check_column_win
    check_row_win
    check_diagonal_win
  end

  def rotate_players
    player_holder = @turn_player
    @turn_player = @waiting_player
    @waiting_player = player_holder
  end

  def play
    while @winner.nil? && @board.any? { |row| row.any?(&:empty?) }
      @board = @turn_player.take_turn(@board, @weights_lookup)
      update_winner_loser
      rotate_players if @winner.nil?
    end
  end
end
