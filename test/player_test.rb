require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require './lib/player'
require 'pry'


class PlayerTest < Minitest::Test

  def test_it_exists
    player = Player.new

    assert_instance_of Player, player
  end

  def test_it_has_a_board_object
    player = Player.new

    assert_instance_of Board, player.board
  end

  def test_it_has_a_both_a_cruiser_and_a_submarine_ship_object
    player = Player.new

    assert_instance_of Ship, player.cruiser
    assert_instance_of Ship, player.submarine
  end

  def test_it_can_place_ships
    player = Player.new
    player.place_ship(player.cruiser, ["A1", "A2", "A3"])
    player.place_ship(player.submarine, ["C4", "D4"])

    expected = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . S \nD . . . S \n"

    assert_equal expected, player.board.render(true)
  end

  def test_player_cannot_place_ships_on_invalid_cells
    player = Player.new

    expected = "Those are invalid coordiantes. Please try again:"

    assert_equal expected, player.place_ship(player.cruiser, ["A3", "A4", "A5"])
    assert_equal expected, player.place_ship(player.submarine, ["A1", "B2"])
  end

  def test_it_can_determine_when_all_player_ships_are_sunk
    player = Player.new
    2.times { player.cruiser.hit }
    1.times { player.submarine.hit }

    refute player.all_ships_sunk?

    player.cruiser.hit

    refute player.all_ships_sunk?

    player.submarine.hit

    assert player.all_ships_sunk?
  end

end
