require_relative 'boards'
require_relative 'print'
require_relative 'pegs'
require 'colorize'

class PlayerBasic
  attr_reader :guess

  def initialize
    @guess = ''
  end

  def clear_guess
    @guess = ''
  end
end

module Players
  class HumanPlayer < PlayerBasic
    def create_code
      puts ''
      puts 'CREATE THE CODE:'.colorize(:white)
      Print.print_colors
      Print.get_color_seq
    end

    def guess_code
      Print.print_colors
      @guess = Print.get_color_seq
      true
    end
  end

  class ComputerPlayer < PlayerBasic
    def create_code
      colors = Colors.get_play_colors
      ans = ''
      4.times { |_| ans << colors.sample }
      ans
    end

    def guess_code(code_board)
      # I can't figure this out yet
      @guess = code_board.pegs
    end
  end
end
