numbers = File.read("day09-input.txt").lines(chomp: true).map(&:to_i)

invalid_number = 85848519

sequences = (2..numbers.size).map { |size| numbers.each_cons(size).lazy }.inject(&:chain)
puts sequences.detect { |s| s.sum == invalid_number }.minmax.sum
