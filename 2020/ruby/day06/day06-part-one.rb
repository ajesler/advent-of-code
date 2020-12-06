answers = File.read("day06-input.txt")

puts answers.split("\n\n").map { |input|
  input
    .lines(chomp: true)
    .join
    .chars
    .uniq
    .size
}.inject(:+)
