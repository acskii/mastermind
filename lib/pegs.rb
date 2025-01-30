require_relative 'colors'

module Pegs
  LOCATION_BIN = '../mastermind/seq.bin'

  def self.valid_peg?(peg)
    return false unless peg.instance_of? String

    !Colors::COLORS.dig(peg).to_s.empty?
  end

  def self.valid_hint?(peg)
    valid_peg?(peg) && Colors.get_hint_colors.include?(peg)
  end

  def self.get_hint_meaning(hint)
    return [] unless valid_hint?(hint)
    return [true, false] unless Colors.get_hint_colors[0] == hint

    [false, true] unless Colors.get_hint_colors[1] == hint
  end

  def self.valid_seq?(seq)
    return false unless seq.instance_of?(String) && seq.length == 4

    seq.chars.all? do |c|
      valid_peg?(c)
    end
  end

  def self.get_permutations
    return nil unless File.exist?(LOCATION_BIN)

    seq = []
    File.open(LOCATION_BIN, 'r') do |f|
      seq << f.read(4) until f.eof?
    end
    seq
  end

  def self.generate_permutations
    return true if File.exist? LOCATION_BIN

    seq = Colors.get_play_colors.permutation(4).map { |p| p.join('') }

    begin
      File.open(LOCATION_BIN, 'w') do |f|
        seq.each { |s| f.write(s) }
      end
    rescue IOError
      false
    end
    true
  end
end
