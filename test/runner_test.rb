require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/runner'
require 'pry'

class RunnerTest < MiniTest::Test

  def test_existance_of
    runner = Runner.new

    assert_instance_of Runner, runner
  end

  def test_welcome_screen
    runner = Runner.new

    assert_equal "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit.", runner.welcome_screen
  end

  
end
