adapters = File.read("day10-input.txt").split("\n").map(&:to_i).sort

device_joltage = adapters.max + 3

adapters = [0, *adapters, device_joltage]

adapter_totals = Hash.new(0)
adapter_totals[0] = 1

adapters.each do |a|
  [-1, -2, -3]
    .map { |o| a + o }
    .each { |i| adapter_totals[a] += adapter_totals[i] }
end

puts adapter_totals.values.max
