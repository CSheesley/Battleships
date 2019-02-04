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

  def test_that_it_has_a_board
    computer = Computer.new

    assert computer.board
  end

  def test_it_starts_with_a_cruiser_and_a_submarine
    computer = Computer.new

    assert computer.cruiser
    assert computer.submarine
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

  def test_it_can_make_a_shot_selection
    computer = Computer.new

    assert_equal 16, computer.shot_options.count
  end

  def test_it_runs_out_of_shot_options_after_16_shots
    computer = Computer.new
    16.times { computer.shot_selection }

    assert_equal 0, computer.shot_options.count
  end

end
