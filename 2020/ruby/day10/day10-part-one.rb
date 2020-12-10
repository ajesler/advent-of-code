adapters = File.read("day10-input.txt").split("\n").map(&:to_i).sort

device_joltage = adapters.max + 3

adapters = [0, *adapters, device_joltage]

abort("invalid adapter sequence") unless adapters.each_cons(2).all? { |a,b| b <= a + 3 }

diff_counts = adapters.each_cons(2).map { |a, b| b - a }.tally
puts diff_counts[1] * diff_counts[3]
