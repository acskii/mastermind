module Pegs
  class PlayPeg
    attr_reader :color

    COLORS = {
      red: :light_red,
      cyan: :cyan,
      blue: :blue,
      green: :light_green,
      yellow: :yellow,
      purple: :magenta,
      neutral: :light_white
    }

    def initialize(color, index)
      color_code = COLORS.fetch(color)
      @color = color_code || COLORS[:neutral]

      @index = index.to_i
    end

    def edit_color(color)
      color_code = COLORS.fetch(color)
      if color_code
        @color = color_code
        true
      end
      false
    end
  end

  class HintPeg
    COLORS = {
      red: :red,
      white: :white
    }

    def initialize(type)
      return unless %w[c w].any? { |t| t == type.downcase }

      if type.downcase == 'c'
        @answer_correct = true
        @wrong_pos = false
        @color = COLORS[:red]
      else
        @answer_correct = false
        @wrong_pos = true
        @color = COLORS[:white]
      end
    end
  end
end
