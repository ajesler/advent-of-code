require "matrix"

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

  ship, waypoint = instructions.reduce([[0, 0], [10, 1]]) { |((sx, sy), (wx, wy)), (i, c)|
    case i
    when :F
      [[sx + (wx * c), sy + (wy * c)], [wx, wy]]
    when :L, :R
      r = i == :L ? Matrix[[0, 1], [-1, 0]] : Matrix[[0, -1], [1, 0]]
      wnx, wny = Array.new(c / 90, r).inject(Matrix[[wx, wy]]) { |p, t| p * t }.row(0).to_a
      [[sx, sy], [wnx, wny]]
    else
      dx, dy = COMPASS[i]
      [[sx, sy], [wx + (dx * c), wy + (dy * c)]]
    end
  }
  ship.map(&:abs).sum
end

if solve(test_data) != 286
  abort("test failed")
end

input_data = File.read("day12-input.txt")
puts solve(input_data)
