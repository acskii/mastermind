module Colors
  COLORS = {
    'r' => :light_red,
    'c' => :cyan,
    'b' => :blue,
    'g' => :light_green,
    'y' => :yellow,
    'p' => :magenta,
    'w' => :white
  }

  def self.get_color(code)
    COLORS.dig code
  end

  def self.get_hint_colors
    %w[r w]
  end

  def self.get_play_colors
    COLORS.reject { |k, _| k == 'w' }.map { |k, _| k }
  end
end
