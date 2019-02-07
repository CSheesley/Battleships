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

  def test_to_verify_that_the_coordinate_is_on_the_board
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D2")

    assert_equal false, board.valid_coordinate?("G50")
    assert_equal false, board.valid_coordinate?("A5")
  end

  def test_that_each_coordinate_of_placement_is_valid
    board = Board.new

    assert_equal false, board.each_coordinate_valid?(["D4", "D5"])
    assert_equal true, board.each_coordinate_valid?(["A2","B2"])

  end

  def test_that_ship_length_equals_coord_length
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.ship_length_equals_coord_length?(cruiser,["A1","A2"])
    assert_equal false, board.ship_length_equals_coord_length?(submarine,["A1","A2","A3"])

    assert_equal true, board.ship_length_equals_coord_length?(cruiser,["C1","C2","C3"])
    assert_equal true, board.ship_length_equals_coord_length?(submarine,["C1","C2"])
  end

  def test_that_placement_is_valid
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(cruiser, ["G1", "G2", "G3"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "B1", "C1"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])

    assert_equal false, board.valid_placement?(submarine, ["B1", "C2"])
    assert_equal true, board.valid_placement?(submarine, ["D1", "D2"])
  end

  def test_that_a_ship_has_been_placed_on_a_cell
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal cruiser, board.cells["A1"].ship
  end

  def test_that_the_same_ship_can_occupy_more_than_one_cell
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal cruiser, board.cells["A1"].ship
    assert_equal cruiser, board.cells["A2"].ship
    assert_equal cruiser, board.cells["A3"].ship
    assert_equal true, board.cells["A1"].ship == board.cells["A2"].ship
  end

  def test_to_make_sure_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.consecutive_coordinates?(cruiser, ["A1", "A2", "A3"])
    assert_equal false, board.consecutive_coordinates?(submarine, ["A1", "A3"])
  end

  def test_to_make_sure_that_ships_cannot_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
    assert_equal true, board.valid_placement?(submarine, ["B1", "B2"])
  end

  def test_that_the_board_can_render_clean_at_beginning_of_game
    board = Board.new
    expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

    assert_equal expected, board.render
  end

  def test_that_board_can_render_with_a_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    expected = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

    assert_equal expected, board.render(true)
  end

  def test_that_board_can_render_with_a_sunken_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon
    board.cells["A2"].fire_upon
    board.cells["A3"].fire_upon

    expected = "  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n"

    assert_equal expected, board.render(true)
  end

  def test_that_board_can_render_with_hits_misses_and_a_sunken_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["C2","D2"])
    board.cells["A1"].fire_upon
    board.cells["A4"].fire_upon
    board.cells["C2"].fire_upon
    board.cells["D2"].fire_upon

    expected = "  1 2 3 4 \nA H . . M \nB . . . . \nC . X . . \nD . X . . \n"

    assert_equal expected, board.render
  end

end
