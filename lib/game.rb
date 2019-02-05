require './lib/ship'
require './lib/cell'
require './lib/board'
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
    turn # shoot & feedback loop until ships sunk
    #end_of_game
  end

  def player_feedback(player_shot)
    if @computer.board.cells[player_shot].render == "X "
      "You sunk my #{@computer.board.cells[player_shot].ship.name}!"
    elsif @computer.board.cells[player_shot].render == "H "
      "Your shot on #{player_shot} was a hit."
    elsif @computer.board.cells[player_shot].render == "M "
      "Your shot on #{player_shot} was a miss"
    end
  end

  def computer_feedback(computer_shot)
    if @player.board.cells[computer_shot].render == "X "
      "I sunk your #{@player.board.cells[computer_shot].ship.name}!\n"
    elsif @player.board.cells[computer_shot].render == "H "
      "My shot on #{computer_shot} was a hit.\n"
    elsif @player.board.cells[computer_shot].render == "M "
      "My shot on #{computer_shot} was a miss.\n"
    end
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
    @player.place_ship(@player.submarine, coords)
    puts @player.board.render(true)

    puts "Select coordinates for Cruiser. (3 coordiantes)"
    print "> "
    coords = gets.chomp.upcase.split
    while !@player.board.valid_placement?(@player.cruiser, coords)
      puts "Those are invalid coordiantes. Please try again:"
      print "> "
      coords = gets.chomp.upcase.split
    end
    @player.place_ship(@player.cruiser, coords)
    puts @player.board.render(true)
    puts "Ships have been placed.\nLets begin!"
  end

  def turn
      #
      # @computer.all_sunk?
      # @player.all_sunk?

    while !@computer.all_ships_sunk? || !@player.all_ships_sunk?
      puts "==========Computer Board=========="
      puts @computer.board.render
      puts "==========Player Board=========="
      puts @player.board.render(true)


      puts "Where would you like to fire upon?"
      print "> "
      print ""
      player_shot = gets.chomp.upcase
      computer_shot = @computer.computer_shot

      while !@player.valid_shot?(@computer.board.cells, player_shot)
        puts "#{player_shot} is invlaid, or has already been fired upon:"
        print "> "
        player_shot = gets.chomp.upcase
      end

        @computer.board.cells[player_shot].fire_upon
        @player.board.cells[computer_shot].fire_upon

        puts player_feedback(player_shot)
        puts computer_feedback(computer_shot)

    end




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
