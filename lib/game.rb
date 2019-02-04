require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/main_menu'
require './lib/computer'
require 'pry'


class Game
  def initialize
    @computer = Computer.new

  end

  def start
    puts "==========Computer Board=========="
    puts @computer.board.render

    puts "==========Player Board=========="
    #player.board.render(true)




  end

   puts "I placed my ships - you place yours"

  
  # puts "Select valid cooridnates for Cruiser"
  # gets.chomp # input should look like A1 A2 A3
  # puts "Select valid cooridnates for Submarine"
  # gets.chomp # input should look like C3 B3




end
