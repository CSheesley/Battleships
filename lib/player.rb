class Player
  attr_reader :board, :cruiser, :submarine

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

#is this even needed?
  def place_ship(ship, coordinates)
    if @board.valid_placement?(ship, coordinates) == true
      @board.place(ship, coordinates)
    else
      return "Those are invalid coordiantes. Please try again:"
    end
  end

end
