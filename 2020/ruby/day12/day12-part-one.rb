test_data = <<~INPUT
  F10
  N3
  F7
  R90
  F11
INPUT

COMPASS = { N: [0, 1], E: [1, 0], S: [0, -1], W: [-1, 0] }

def solve(data)
  instructions = data.split("\n").map { |i| i.split("", 2) }.map { |i, c| [i.to_sym, c.to_i] }

  instructions.reduce([:E, [0, 0]]) { |(d, (x, y)), (i, c)|
    puts "#{d} #{x} #{y} #{i} #{c}"
    i = i == :F ? d : i

    case i
    when :L
      dd = (COMPASS.keys.index(d) - (c / 90)) % 4
      [COMPASS.keys[dd], [x, y]]
    when :R
      dd = (COMPASS.keys.index(d) + (c / 90)) % 4
      [COMPASS.keys[dd], [x, y]]
    else
      dx, dy = COMPASS[i]
      [d, [x + (dx * c), y + (dy * c)]]
    end
  }.last.map(&:abs).sum
end

if solve(test_data) != 25
  abort("test failed")
end

input_data = File.read("day12-input.txt")
puts solve(input_data)
