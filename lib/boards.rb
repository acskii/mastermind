require_relative 'pegs'

module Boards
  class Board
    def initialize
      @pegs = []

      4.times do |index|
        @pegs << PlayPeg.new(:neutral, index)
      end
    end

    def pegs
      @pegs.map { |peg| peg.color }
    end

    def color_pegs(*colors)
      return false unless len(colors) == len(@pegs)

      colors.each_with_index do |color, index|
        @pegs[index].edit_color(color)
      end
    end
  end

  class GameBoard < Board
    attr_reader :hints

    def initialize
      super
      @hints = []
    end

    def add_hints(red, white)
      return false unless [red, white].all? { |n| n.instance_of? Integer }

      red.times { |_| @hints << HintPeg.new('c') }
      white.times { |_| @hints << HintPeg.new('w') }
      true
    end
  end

  class CodeBoard < Board
    def initialize(*colors)
      super()

      color_pegs(*colors)
    end

    def hints_with(game_board)
      hints = [0, 0]

      len(@pegs).times do |index|
        if pegs[index] == game_board.pegs[index]
          hints[0] += 1
        elsif pegs.include? game_board.pegs[index]
          hints[1] += 1
        end
      end

      hints
    end
  end
end
