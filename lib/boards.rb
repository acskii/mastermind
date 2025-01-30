require_relative 'pegs'

class BoardBase
  attr_reader :pegs

  def initialize
    @pegs = ''
  end

  def change_pegs(seq)
    return false unless Pegs.valid_seq?(seq)

    @pegs = seq
    true
  end
end

module Boards
  class GameBoard < BoardBase
    attr_reader :hints

    def initialize
      super
      @hints = []
    end

    def add_hints(red, white)
      return false unless [red, white].all? { |n| n.instance_of? Integer }

      colors = Colors.get_hint_colors
      red.times { |_| @hints << colors[0] }
      white.times { |_| @hints << colors[1] }
      true
    end
  end

  class CodeBoard < BoardBase
    def initialize(seq)
      super()
      change_pegs(seq)
    end

    def same_as?(game_board)
      hints_with(game_board)[0] == 4
    end

    def get_hints(seq)
      return false unless Pegs.valid_seq?(seq)

      red = get_red_pegs(seq)
      [red, get_white_pegs(seq, red)]
    end

    def hints_with(game_board)
      get_hints(game_board.pegs)
    end

    private

    def get_red_pegs(seq)
      @pegs.chars.zip(seq.chars).count { |s, g| s == g }
    end

    def get_white_pegs(seq, red)
      seq_counts = Hash.new(0)
      code_counts = Hash.new(0)

      @pegs.chars.each { |c| code_counts[c] += 1 }
      seq.chars.each { |c| seq_counts[c] += 1 }

      code_counts.sum { |color, count| [count, seq_counts[color]].min } - red
    end
  end
end
