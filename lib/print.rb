require 'colorize'
require 'io/console'
require_relative 'colors'

module Print
  def self.print_options(msg, options)
    puts msg
    options.each_pair do |key, value|
      return false unless key.instance_of? Integer

      puts "[#{key}] #{value}"
    end
  end

  def self.get_option(msg, options)
    print_options(msg, options)

    print 'Option: '
    input = gets.chomp.to_i
    until options.keys.include? input
      puts 'INVALID OPTION'.colorize(:red)
      print 'Option: '
      input = gets.chomp.to_i
    end
    input
  end

  def self.get_color_seq
    colors = Colors.get_play_colors
    ans = ''

    4.times do |t|
      print "PEG ##{t + 1}: "
      chosen_color = gets.chomp.downcase

      until !chosen_color.empty? && colors.include?(chosen_color)
        puts 'INVALID INPUT, TRY AGAIN'.colorize(:red)
        print "PEG ##{t + 1}: "
        chosen_color = gets.chomp.downcase
      end
      ans << chosen_color
    end
    ans
  end

  def self.print_colors
    colors = Colors.get_play_colors
    puts 'AVAILABLE COLORS'.colorize(:white)
    colors.each do |color|
      cc = Colors.get_color(color)
      print "| #{color} #{cc} ".colorize(cc)
    end
    puts ''
  end

  def self.print_pegs(*colors)
    colors.each do |color|
      print '◉ '.colorize(color) unless color.nil?
    end
    puts ''
  end

  def self.clear_console
    $stdout.clear_screen
  end

  def self.print_title
    puts('WELCOME TO'.center(20, ' ').colorize(:light_white))
    puts('🄼 🄰 🅂 🅃 🄴 🅁 🄼 🄸 🄽 🄳'.center(20, ' ').colorize(:light_white))
    puts('=' * 20)
    puts ''

    puts('HOW TO PLAY'.center(20, ' ').colorize(:light_white))
    puts('=' * 20)
    puts('CREATOR CREATES A COLOR CODE'.center(20, ' ').colorize(:light_white))
    puts('BREAKER GUESSES A COLOR CODE'.center(20, ' ').colorize(:light_white))
    puts('CREATOR HINTS IF GUESS IS CLOSE'.center(20, ' ').colorize(:light_white))
    puts('BREAKER USES HINTS TO CRACK CODE'.center(20, ' ').colorize(:light_white))
    puts('WHO WILL LAUGH IN THE END!!'.center(20, ' ').colorize(:light_white))
    puts ''

    puts('HINTS'.center(20, ' ').colorize(:light_white))
    puts('=' * 20)
    puts('RED PEG   | ◉ | => Correct peg'.center(20, ' ').colorize(:light_red))
    puts('WHITE PEG | ◉ | => Correct peg but wrong position'.center(20, ' ').colorize(:light_white))
    puts('NONE      |   | => Wrong'.center(20, ' ').colorize(:white))
    puts ''
  end
end
