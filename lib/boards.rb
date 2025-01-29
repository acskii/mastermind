require_relative 'pegs'

module Boards
  class Board
    attr_reader :pegs

    def initialize
      @pegs = []

      4.times do |index|
        @pegs << Pegs::PlayPeg.new(:neutral, index)
      end
    end

    def color_pegs(colors)
      return false unless colors.length == @pegs.length

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

      red.times { |_| @hints << Pegs::HintPeg.new('c') }
      white.times { |_| @hints << Pegs::HintPeg.new('w') }
      true
    end
  end

  class CodeBoard < Board
    def initialize(colors)
      super()

      color_pegs(colors)
    end

    def same_as?(game_board)
      hints_with(game_board)[0] == 4
    end

    def hints_with(game_board)
      hints = [0, 0]
      correct = []

      @pegs.length.times do |index|
        if pegs[index].color == game_board.pegs[index].color
          correct << game_board.pegs[index].color
          hints[0] += 1
        end
      end

      @pegs.length.times do |index|
        next unless pegs.map do |peg|
          peg.color
        end.include?(game_board.pegs[index].color) && !correct.include?(game_board.pegs[index].color)

        hints[1] += 1
      end

      hints
    end
  end
end
