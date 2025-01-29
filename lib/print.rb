require 'colorize'

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

  def self.print_pegs(*colors)
    colors.each do |color|
      print '_'.colorize(color) unless color.nil?
    end
    puts ''
  end
end
