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

  def test_that_computer_can_place_ships #need to have assertions written 
    skip
    computer = Computer.new
    computer.place_ships

    # expected = "  1 2 3 4 \nA H . . M \nB . . . . \nC . X . . \nD . X . . \n"
    assert_equal expected, computer.place_ships
  end

  def test_that_computer_board_can_be_rendered #need to have assertions written
    skip

  end








end
