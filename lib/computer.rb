class Computer
  attr_reader :board, :cruiser, :submarine

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def place_ships
    @board.place(@cruiser, generated_cells(@cruiser))
    @board.place(@submarine, generated_cells(@submarine))
    binding.pry
  end

  def random_coordinates(cell_count)
    all_coords = []
    selected_coords = []
    all_coords << board.cells.keys
    all_coords.flatten!
    selected_coords << all_coords.sample(cell_count)
    selected_coords.flatten!
  end

  def generated_cells(ship)
    loop do
      @coordinates = random_coordinates(ship.length)
      if @board.valid_placement?(ship, @coordinates )
        break
      end
    end
    return @coordinates
  end

end
