module Pegs
    class PlayPeg
        attr_reader :color

        COLORS = {
            red:'',
            orange:'',
            blue:'',
            green:'',
            yellow:'',
            purple:''
        }

        def initialize(color)
            color_code = COLORS.fetch(color)
            if color_code
                @color = color_code
            else
                @color = COLORS[:red]
            end
        end
    end

    class HintPeg
        COLORS = {
            red:'',
            white:''
        }

        def initialize(type)
            return unless ['c', 'w'].any? { |t| t == type.downcase() }

            if type.downcase() == 'c'
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