class Player
  attr_reader :board, :cruiser, :submarine

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def place_ship(ship, coordinates)
    if @board.valid_placement?(ship, coordinates) == true
      @board.place(ship, coordinates)
    else
      return "Those are invalid coordiantes. Please try again:" #probably not even needed
    end
  end

  def all_ships_sunk?
    if @cruiser.sunk? && @submarine.sunk?
      true
    else
      false
    end
  end

  def valid_shot?(computer_board_and_cells, player_shot)
    if computer_board_and_cell.include?(player_shot) && !computer_board_and_cell[player_shot].fired_upon?
      true
    else
      false
    end
  end

end
