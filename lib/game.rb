require_relative 'boards'
require_relative 'players'
require_relative 'print'
require_relative 'pegs'
require 'colorize'

class Game
  attr_accessor :rounds

  def initialize
    @rounds = 6 # Default value of rounds
    @creator, @breaker = get_players
  end

  def start_game
    secret_code = @creator.create_code
    code_board = Boards::CodeBoard.new(*secret_code)
    prev_game_boards = []
    game_won = false

    rounds.times do |round|
      puts "ROUND ##{round + 1}"
      current_board = Boards::GameBoard.new

      next unless @breaker.guess_code

      current_board.color_pegs(*@breaker.guess)
      current_board.add_hints(code_board.hints_with(current_board))

      Print.print_pegs(*current_board.hints.map { |hint| HintPeg::COLORS.fetch(hint.color) })
      Print.print_pegs(*current_board.pegs.map { |peg| PlayPeg::COLORS.fetch(peg.color) })

      if code_board.same_as? current_board
        game_won = true
        break
      end

      prev_game_boards << current_board
    end

    puts 'CODE WAS BROKEN'.colorize(:light_green) if game_won
    puts 'CODE REMAINS UNTOUCHED'.colorize(:light_red) unless game_won
  end

  private

  def get_players
    creator = if Print.get_option('CHOOSE CODE CREATOR',
                                  { 1 => 'Computer'.colorize(:green),
                                    2 => 'Human'.colorize(:white) }) == 1
                Players::ComputerPlayer.new
              else
                Players::HumanPlayer.new
              end
    breaker = if Print.get_option('CHOOSE CODE BREAKER',
                                  { 1 => 'Computer'.colorize(:white),
                                    2 => 'Human'.colorize(:green) }) == 1
                Players::ComputerPlayer.new
              else
                Players::HumanPlayer.new
              end
    [creator, breaker]
  end
end
