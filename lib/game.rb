require_relative 'boards'
require_relative 'players'
require_relative 'print'
require_relative 'pegs'
require_relative 'colors'
require 'colorize'

class Game
  attr_accessor :rounds

  def initialize
    Print.print_title

    @rounds = 12 # Default value of rounds
    @creator, @breaker = get_players
  end

  def start_new_game
    puts 'START NEW GAME?'
    print '[Y]/[N]: '
    ans = gets.chomp.upcase

    until %w[Y N].include?(ans)
      puts 'INVALID INPUT, TRY AGAIN'.colorize(:red)
      print '[Y]/[N]: '
      ans = gets.chomp.upcase
    end

    return true if ans == 'Y'

    false if ans == 'N'
  end

  def start_game
    loop do
      secret_code = @creator.create_code
      code_board = Boards::CodeBoard.new(secret_code)
      prev_game_boards = []
      game_won = false

      rounds.times do |round|
        Print.clear_console

        prev_game_boards.each do |board|
          Print.print_pegs(*board.hints.map { |hint| Colors.get_color(hint) })
          Print.print_pegs(*board.pegs.chars.map { |peg| Colors.get_color(peg) })
          puts '---------------------------------'
        end

        puts "ROUND ##{round + 1}"
        current_board = Boards::GameBoard.new

        if @breaker.instance_of? Players::ComputerPlayer
          next unless @breaker.guess_code code_board
        else
          next unless @breaker.guess_code
        end
        current_board.change_pegs(@breaker.guess)
        current_board.add_hints(*code_board.hints_with(current_board))

        Print.print_pegs(*current_board.hints.map { |hint| Colors.get_color(hint) })
        Print.print_pegs(*current_board.pegs.chars.map { |peg| Colors.get_color(peg) })

        if code_board.same_as? current_board
          game_won = true
          break
        end

        prev_game_boards << current_board
      end

      puts 'CODE WAS BROKEN'.colorize(:light_green) if game_won
      puts 'CODE REMAINS UNTOUCHED'.colorize(:light_red) unless game_won

      break unless start_new_game
    end
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
