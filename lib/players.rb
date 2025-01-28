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

    def guess_complete?
      @guess.length == 4
    end

    def clear_guess
      @guess.clear
    end

    private
    def print_colors
      colors = Pegs::PlayPeg::COLORS
      puts "AVAILABLE COLORS".colorize(:white)
      colors.each_with_index do |color|
      puts "[#{cc[index]}] #{color.to_s}".colorize(colors[color])
    end
  end

  class HumanPlayer < PlayerBasic
    def create_code
      print_colors
      get_color 4
    end

    def guess_code
      return false if guess_complete?

      print_colors
      @guess << get_color(1)
      true
    end

    private
    def get_color(t)
      colors = Pegs::PlayPeg::COLORS
      cc = colors.map { |key| key.to_s[0] }
      ans = []

      t.times do |ip|
        print "PEG ##{ip+1}: "
        chosen_color = gets.chomp.downcase
        
        until cc.include? chosen_color
          puts 'INVALID COLOR, TRY AGAIN'.colorize(:red)
          print "PEG ##{ip+1}: "
          chosen_color = gets.chomp.downcase
        end
        ans << a.to_a[cc.index(chosen_color)][0]
      end
      ans
    end
  end

  class ComputerPlayer < PlayerBasic
    def create_code
      print_colors
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
