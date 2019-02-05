require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/main_menu'
require './lib/computer'
require './lib/player'
require 'pry'


class Game
  def initialize
    @computer = Computer.new
    @player = Player.new
  end

  def start
    welcome_screen
    setup
    turn
  end

  def welcome_screen
    puts "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit."
    print "> "
    gets.chomp.downcase

  end

  def setup
    @computer.place_ships
    puts "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Submarine is two units long and the Cruiser is three units long."
    puts @player.board.render

    puts "Select coordinates for Submarine. (2 coordiantes)"
    print "> "
    coords = gets.chomp.upcase.split
    while !@player.board.valid_placement?(@player.submarine, coords)
      puts "Those are invalid coordiantes. Please try again:"
      print "> "
      coords = gets.chomp.upcase.split
    end
    @player.board.place(@player.submarine, coords)
    puts @player.board.render(true)

    puts "Select coordinates for Cruiser. (3 coordiantes)"
    print "> "
    coords = gets.chomp.upcase.split
    while !@player.board.valid_placement?(@player.cruiser, coords)
      puts "Those are invalid coordiantes. Please try again:"
      print "> "
      coords = gets.chomp.upcase.split
    end
    @player.board.place(@player.cruiser, coords)
    puts @player.board.render(true)
    puts "Ships have been placed.\nLets begin!"
  end

  def turn

    puts "==========Computer Board=========="
    puts @computer.board.render
    puts "==========Player Board=========="
    puts @player.board.render(true)
    puts "Where would you like to fire upon?"
    print "> "
    gets.chomp

  #     puts "Where would you like to fire upon?"
  #     gets.chomp
  #     if @cell.render == 2
  #     end
  #   end
  end
  # puts "Select valid cooridnates for Cruiser"
  # gets.chomp # input should look like A1 A2 A3
  # puts "Select valid cooridnates for Submarine"
  # gets.chomp # input should look like C3 B3
end
