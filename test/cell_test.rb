require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require 'pry'

class CellTest < Minitest::Test

  def setup
  end

  def test_that_it_exist
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_that_cell_has_a_coordinate
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_to_verify_that_no_ship_is_in_cell_at_start
    cell = Cell.new("B4")

    assert_nil cell.ship
  end

  def test_to_see_if_cell_is_empty
    cell = Cell.new("B4")

    assert cell.empty?
  end

  def test_to_see_if_ship_can_be_placed_in_a_cell
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
  end

  def test_to_see_if_cell_is_empty_after_ship_placed
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    refute cell.empty?
  end

  def test_to_see_if_cell_has_been_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    refute cell.fired_upon?
  end

  def test_to_check_result_of_firing_upon_an_empty_cell
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    assert_equal "Miss", cell.fire_upon
  end

  def test_outcome_of_firing_upon_an_occupied_cell_and_its_result
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal "Hit!", cell.fire_upon
    assert_equal 2, cell.ship.health
  end

end
