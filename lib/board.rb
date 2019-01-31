class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate_arg)
    @cells.has_key?(coordinate_arg)
  end

  def valid_placement?(ship_arg, coordinates_arg)
    ship_length_equals_coord_length(ship_arg, coordinates_arg)

# if on same row (letter) - check that they are each_cons (number value) = ship length
# are the letters all the same
# if in same column (number) - check that they are ordinal values (alphabet order) = ship length
# is the column the same
  end

  def ship_length_equals_coord_length(ship_arg, coordinates_arg)
    if ship_arg.length != coordinates_arg.length
      false
    else
      true
    end
  end


end
