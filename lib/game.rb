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
  end

  def welcome_screen
    puts "Welcome to BATTLESHIP! \nEnter p to play. Enter q to quit."
    print "> "
    selection = gets.chomp.downcase

    while selection != "p" && selection != "q"
      puts "Please enter a valid selection"
      print "> "
      selection = gets.chomp.downcase
    end

    if selection == "p"
      setup
      turn
      results
      end_game
    elsif selection == "q"
      puts "\nSee Ya!!"
      exit
    end
  end

  def setup
    @computer.place_ships
    puts "\nI have laid out my ships on the grid.\nYou now need to lay out your two ships."
    puts "The Submarine is two units long, and the Cruiser is three units long.\n\n"
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
    puts ""
  end

  def turn
    while !@computer.all_ships_sunk? && !@player.all_ships_sunk?
      puts "==========Computer Board=========="
      puts @computer.board.render
      puts "==========Player Board=========="
      puts @player.board.render(true)

      puts ""
      puts "Where would you like to fire upon?"
      print "> "

      player_shot = gets.chomp.upcase
      computer_shot = @computer.computer_shot

      while !@player.valid_shot?(@computer.board.cells, player_shot)
        puts "#{player_shot} is invlaid, or has already been fired upon:"
        print "> "
        player_shot = gets.chomp.upcase
      end

      @computer.board.cells[player_shot].fire_upon
      @player.board.cells[computer_shot].fire_upon

      puts " "
      player_feedback(player_shot)
      computer_feedback(computer_shot)

    end
    puts "==========Computer Board=========="
    puts @computer.board.render
    puts "==========Player Board=========="
    puts @player.board.render(true)
  end

  def player_feedback(player_shot)
    if @computer.board.cells[player_shot].render == "X "
      puts "You sunk my #{@computer.board.cells[player_shot].ship.name}!"
    elsif @computer.board.cells[player_shot].render == "H "
      puts "Your shot on #{player_shot} was a hit."
    elsif @computer.board.cells[player_shot].render == "M "
      puts "Your shot on #{player_shot} was a miss."
    end
  end

  def computer_feedback(computer_shot)
    if @player.board.cells[computer_shot].render == "X "
      puts "I sunk your #{@player.board.cells[computer_shot].ship.name}!\n\n"
    elsif @player.board.cells[computer_shot].render == "H "
      puts "My shot on #{computer_shot} was a hit.\n\n"
    elsif @player.board.cells[computer_shot].render == "M "
      puts "My shot on #{computer_shot} was a miss.\n\n"
    end
  end

  def results
    if @computer.all_ships_sunk?
      puts ""
      puts "You won!!"
    elsif @player.all_ships_sunk?
      puts ""
      puts "I won!!"
    end
      puts ""
  end

  def end_game
    puts "Press p to play again or q to quit"
    game_end = gets.chomp
    if game_end == "p"
      @computer = Computer.new
      @player = Player.new
      puts ""
      start
    elsif game_end == "q"
      puts "Thanks for playing!!\nSee ya next time!!"
      exit
    else game_end != "p"||"q"
      end_game
    end
  end
end
