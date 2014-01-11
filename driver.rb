require './game_of_life'


# exercise the GameOfLife class
initial_game_board = Matrix[
    [0, 1, 0, 0, 0],
    [1, 0, 0, 1, 1],
    [1, 1, 0, 0, 1],
    [0, 1, 0, 0, 0],
    [1, 0, 0, 0, 1]]

generations = 3

GameOfLife.new(initial_game_board).run(generations)