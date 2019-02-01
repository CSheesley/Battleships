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

  def valid_placement?(ship, coordinates)
    each_coordinate_valid?(ship, coordinates) &&
    ship_length_equals_coord_length?(ship, coordinates) &&
    consecutive_coordinates?(ship, coordinates) &&
    no_overlap(ship, coordinates)
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def each_coordinate_valid?(ship, coordinates)
    coordinates.all? do |coordinate|
      valid_coordinate?(coordinate)
    end
  end

  def ship_length_equals_coord_length?(ship, coordinates) #more readable - previously if/else w/ !
    ship.length == coordinates.length
  end

  def consecutive_coordinates?(ship, coordinates)
    rows = []
    columns =[]
    coordinates.each do |coordinate|
      rows << coordinate[0]
      columns << coordinate[1]
    end

    valid_columns = []
    ("1".."4").to_a.each_cons(ship.length) { |columns| valid_columns << columns }
    valid_rows =[]
    ("A".."D").to_a.each_cons(ship.length) { |rows| valid_rows << rows}

    if rows.uniq.length == 1 && valid_columns.include?(columns)
      true
    elsif columns.uniq.length == 1 && valid_rows.include?(rows)
      true
    else
      false
    end
  end

  def no_overlap(ship, coordinates)
    coordinates.none? do |coord|
      overlap?(coord)
    end
  end

  def overlap?(coordinate)
    @cells[coordinate].ship != nil
  end

  def place(ship, coordinates)
    coordinates.each do |coord|
      place_on_cell(ship, coord)
    end
  end

  def place_on_cell(ship, cell)
    @cells[cell].place_ship(ship)
  end

  def render(display_option = false)
    puts "  1 2 3 4 "
    puts "A " + render_each_cell("A1") + render_each_cell("A2") + render_each_cell("A3") + render_each_cell("A4")
    puts "B " + render_each_cell("B1") + render_each_cell("B2") + render_each_cell("B3") + render_each_cell("B4")
    puts "C " + render_each_cell("C1") + render_each_cell("C2") + render_each_cell("C3") + render_each_cell("C4")
    puts "D " + render_each_cell("D1") + render_each_cell("D2") + render_each_cell("D3") + render_each_cell("D4")
  end
  # 
  # def row_a
  #   row_a = ["A1","A2","A3","A4"]
  #     row_a.each do |coord|
  #       render_each_cell(coord)
  #     end
  # end

  # def row_a
  #   row_a = ["A1","A2","A3","A4"]
  #   row_a_new = []
  #   row_a.map do |coord|
  #     row_a_new << render_each_cell(coord)
  #   end
  #   return "A #{row_a_new.flatten}"
  # end

  def render_each_cell(cell)
    @cells[cell].render
  end

end
