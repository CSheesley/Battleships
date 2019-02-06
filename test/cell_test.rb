require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require 'pry'

class CellTest < Minitest::Test

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

    assert_equal true, cell.empty?
  end

  def test_to_see_if_ship_can_be_placed_on_a_cell
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
  end

  def test_to_see_if_cell_is_empty_after_ship_placed
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal false, cell.empty?
  end

  def test_to_see_if_cell_has_been_fired_upon_before_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?
  end

  def test_to_check_cell_is_fired_upon_after_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon

    assert_equal true, cell.fired_upon?
  end

  def test_outcome_of_firing_upon_an_occupied_cell_and_ship_health_impact
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon

    assert_equal 2, cell.ship.health
  end

  def test_to_see_if_cells_blank_cells_are_properly_rendered
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    assert_equal ". ", cell.render
  end

  def test_to_see_if_user_can_see_own_ship_placement
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal "S ", cell.render(true)
  end

  def test_to_see_that_hits_and_misses_render_correctly
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.fire_upon

    assert_equal "M ", cell.render

    cell.place_ship(cruiser)

    assert_equal "H ", cell.render
  end

  def test_to_make_sure_a_sunk_ship_renders_with_an_x
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    cruiser.hit
    cruiser.hit

    assert_equal "X ", cell.render
  end

end
