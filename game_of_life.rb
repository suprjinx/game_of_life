require 'matrix'

class GameOfLife

  attr_accessor :game_board

  # Create a GameOfLife instance
  # @param initial_board [Matrix] initial board matrix
  def initialize(initial_board) 
    self.game_board = initial_board
    print_game_board "Initial board state"
  end

  # Evolve the game board N times
  # @param repeat_count [int] number of generations evolve (default 1)
  def run(repeat_count = 1)
    (1..repeat_count).each do |count|
      evolve_game_board
      print_game_board "After #{count} generation(s)"
    end
  end

  # evolve the game board one generation
  def evolve_game_board
    rows = game_board.row_vectors.collect { |row| row.to_a }
    game_board.each_with_index do |cell, row, col|

      # find a sub-section of the matrix based on the current element's position
      neighboring_row_range = 
        (row == 0 ? row : row - 1)..(row > game_board.row_size ? row : row + 1)
      neighboring_col_range =
        (col == 0 ? col : col - 1)..(col > game_board.column_size ? col : col + 1)

      # count the living neighbors (subtracting the current element)
      neighbors = game_board.minor neighboring_row_range, neighboring_col_range
      living_neighbor_count = neighbors.each.count { |i| i == 1 } - cell

      # apply the game rules based on living neighbor count
      rows[row][col] = alive_for_next_generation?(cell, living_neighbor_count) ? 1 : 0
    end
    # replace the game board with a new Matrix reflecting
    self.game_board = Matrix.rows(rows)
  end

  # indicate whether a given cell should be "living" in the next generation
  # based on living neighbor count
  # param cell [Numeric] the
  def alive_for_next_generation?(cell, living_neighbor_count)
    if cell == 1
      (2..3).include?(living_neighbor_count)
    else
      living_neighbor_count == 3
    end
  end

  # print out the game board
  # @param heading [String] the heading to place above the board
  def print_game_board(heading = nil)
    puts heading if heading
    puts game_board.to_a.map(&:inspect)
  end
end
