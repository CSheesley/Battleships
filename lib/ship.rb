class Ship
attr_reader :name, :length, :health

  def initialize(name, length)
    @name = name
    @health = length
    @length = length
    @sunk = false
  end

  def sunk?
    if @health == 0 then @sunk = true else @sunk end
  end

  def hit
    @health -= 1
  end
end
