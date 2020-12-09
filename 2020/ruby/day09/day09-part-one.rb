numbers = File.read("day09-input.txt").lines(chomp: true).map(&:to_i)
preamble_size = 25

sequence = numbers.drop(preamble_size).each.with_index
puts sequence.detect { |n, offset| !numbers[offset, preamble_size].combination(2).any? { |a, b| a + b == n } }.first
