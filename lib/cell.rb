class Cell
  attr_reader :coordinate, :ship, :empty, :fired_upon

  def initialize(coordinate_arg)
    @coordinate = coordinate_arg
    @ship = ship
    @empty = true
    @fired_upon = false
  end

  def empty?
    @empty
  end

  def place_ship(ship_arg)
    @empty = false
    @ship = ship_arg
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true

    if empty?
      "Miss" #may remove
    else
      @ship.hit
      "Hit!" #may remove
    end
  end

  def render(display_option = false)
    if @ship && @ship.sunk?
      "X"
    elsif !empty? && fired_upon?
      "H"
    elsif empty? && fired_upon?
      "M"
    elsif display_option && !empty?
      "S"
    else
      "."
    end
  end

end
