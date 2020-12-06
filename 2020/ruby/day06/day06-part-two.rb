answers = File.read("day06-input.txt")

puts answers.split("\n\n").map { |input|
  input
    .lines(chomp: true)
    .map(&:chars)
    .inject { |g, a| g & a }
    .size
}.inject(:+)
