class Cell
  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if empty?
    else
      @ship.hit
    end
  end

  def render(display_option = false)
    if !empty? && @ship.sunk?
      "X "
    elsif !empty? && fired_upon?
      "H "
    elsif empty? && fired_upon?
      "M "
    elsif display_option && !empty?
      "S "
    else
      ". "
    end
  end

end
