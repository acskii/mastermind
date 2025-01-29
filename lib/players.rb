require_relative 'boards'
require_relative 'pegs'
require 'colorize'

module Players
  class PlayerBasic
    attr_accessor :score
    attr_reader :guess

    def initialize
      @guess = []
    end

    def clear_guess
      @guess.clear
    end

    private

    def print_colors
      colors = Pegs::PlayPeg::COLORS

      puts 'AVAILABLE COLORS'.colorize(:white)
      colors.each_pair do |dis, col|
        puts "[#{dis.to_s[0]}] #{dis}".colorize(col)
      end
    end
  end

  class HumanPlayer < PlayerBasic
    def create_code
      puts 'CREATE THE CODE:'.colorize(:white)
      print_colors
      get_color 4
    end

    def guess_code
      print_colors
      @guess = get_color(4)
      true
    end

    private

    def get_color(t)
      colors = Pegs::PlayPeg::COLORS
      ans = []

      t.times do |ip|
        print "PEG ##{ip + 1}: "
        chosen_color = gets.chomp.downcase
        cc = colors.map { |color, _| color.to_s[0] }

        until cc.include?(chosen_color) && !chosen_color.empty?
          puts 'INVALID COLOR, TRY AGAIN'.colorize(:red)
          print "PEG ##{ip + 1}: "
          chosen_color = gets.chomp.downcase
        end
        ans << colors.select { |color, _| color.to_s[0] == chosen_color }.keys[0]
      end
      ans
    end
  end

  class ComputerPlayer < PlayerBasic
    def create_code
      get_color 4
    end

    # guess_code here soon

    private

    def get_color(t)
      colors = Pegs::PlayPeg::COLORS.keys
      ans = []

      t.times { |_| ans << colors.sample }
      ans
    end
  end
end
