input = File.readlines("day3_input.txt")

def possible_triangle?(a, b, c)
  (a < b + c) && (b < c + a) && (c < a + b)
end

puts "Part 1"

total = input.map { |line| line.split(" ").map(&:to_i) }.count { |numbers| possible_triangle?(*numbers) }
puts "\tCount: #{total}"


puts "Part 2"

three_line_groups = File.readlines("day3_input.txt").each_slice(3)
numbers = three_line_groups.map do |one, two, three|
  x = one.split(" ").map(&:to_i)
  y = two.split(" ").map(&:to_i)
  z = three.split(" ").map(&:to_i)

  [
    [x[0], y[0], z[0]],
    [x[1], y[1], z[1]],
    [x[2], y[2], z[2]]
  ]
end

total = numbers.inject(:+).count { |numbers| possible_triangle?(*numbers) }
puts "\tCount: #{total}"