require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require 'pry'


class ShipTest < Minitest::Test

  def setup

  end

  def test_that_it_exist
    cruiser = Ship.new("Cruiser", 3)

    assert_instance_of Ship, cruiser
  end

  def test_have_attributes
    cruiser = Ship.new("Cruiser", 3)

    assert_equal "Cruiser", cruiser.name
    assert_equal 3, cruiser.length
  end

  def test_ship_starts_with_full_health
    cruiser = Ship.new("Cruiser", 3)

    assert_equal cruiser.length, cruiser.health
  end

  def test_if_ship_is_sunk
    cruiser = Ship.new("Cruiser", 3)

    refute cruiser.sunk?
  end

  def test_that_ship_loses_1_health_when_hit
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 2, cruiser.hit
    assert_equal 1, cruiser.hit
  end

  def test_the_ship_is_sunk_when_health_hits_zero
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    cruiser.hit
    cruiser.hit

    assert cruiser.sunk?
  end
end
