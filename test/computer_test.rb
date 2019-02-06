require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require 'pry'

class RunnerTest < MiniTest::Test

  def test_that_a_computer_object_exists
    computer = Computer.new

    assert_instance_of Computer, computer
  end

  def test_that_it_has_a_board_object
    computer = Computer.new

    assert_instance_of Board, computer.board
  end

  def test_it_has_a_both_a_cruiser_and_a_submarine_ship_object
    computer = Computer.new

    assert_instance_of Ship, computer.cruiser
    assert_instance_of Ship, computer.submarine
  end

  def test_that_computer_can_place_ships
    computer = Computer.new
    computer.place_ships

    refute computer.board.cells.all? { |coordinate, cell| cell.ship == nil }
  end

  def test_that_computer_board_can_be_rendered
    computer = Computer.new
    computer.place_ships

    expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected, computer.board.render
  end

  def test_it_begins_with_a_selection_of_16_unique_shot_options
    computer = Computer.new

    assert_equal 16, computer.shot_options.uniq.count
  end

  def test_it_runs_out_of_shot_options_after_16_shots
    computer = Computer.new
    16.times { computer.computer_shot }

    assert_equal 0, computer.shot_options.count
  end

  def test_it_can_determine_when_all_computer_ships_are_sunk
    computer = Computer.new
    2.times { computer.cruiser.hit }
    1.times { computer.submarine.hit }

    assert_equal false, computer.all_ships_sunk?

    computer.cruiser.hit

    assert_equal false, computer.all_ships_sunk?

    computer.submarine.hit

    assert_equal true, computer.all_ships_sunk?
  end

end
