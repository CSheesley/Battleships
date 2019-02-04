class Computer
  attr_reader :board, :cruiser, :submarine, :shot_options

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @shot_options = all_coords
  end

  def place_ships
    @board.place(@cruiser, generated_coords(@cruiser))
    @board.place(@submarine, generated_coords(@submarine))
  end

  def random_coords(cell_count)
    selected_coords = []
    selected_coords << all_coords.sample(cell_count)
    selected_coords.flatten!
  end

  def all_coords
    all_coords = []
    all_coords << board.cells.keys
    all_coords.flatten!
  end

  def generated_coords(ship)
    loop do
      @coordinates = random_coords(ship.length)
      if @board.valid_placement?(ship, @coordinates )
        break
      end
    end
    return @coordinates
  end

  def shot_selection
    @shot_options.shuffle!
    shot = @shot_options.pop
    return shot
  end

end
