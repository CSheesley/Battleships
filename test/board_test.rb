require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BoardTest < Minitest::Test

  def test_to_make_sure_the_board_is_an_instance_of_the_board_class
    board = Board.new

    assert_instance_of Board, board
  end

  def test_to_make_sure_the_board_holds_16_cells
    board = Board.new

    assert_equal 16, board.cells.count
  end

  def test_to_make_sure_that_a_key_references_a_cell_object
    board = Board.new

    assert_equal Cell, board.cells["A1"].class
  end

  def test_to_verify_valid_coordinates
    board = Board.new

    assert board.valid_coordinate?("A1")
    assert board.valid_coordinate?("D2")ls
    
    refute board.valid_coordinate?("G50")
    refute board.valid_coordinate?("A5")
  end

end
