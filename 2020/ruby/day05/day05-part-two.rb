seat_descriptors = File.read("input.txt").lines(chomp: true)

def partition(range, action)
  delta = range.last - range.first
  adjustment = (delta.to_f / 2)

  result = case action
           when "F", "L"
             (range.first..(range.first + adjustment.floor))
           when "B", "R"
             ((range.first + adjustment.ceil)..range.last)
           end

  return result.first if result.first == result.last

  result
end

def extract_seat(descriptor)
  row = descriptor.chars.first(7).inject(0..127) { |result, action| partition(result, action) }
  column = descriptor.chars.last(3).inject(0..7) { |result, action| partition(result, action) }

  { row: row, column: column, seat_id: (row * 8) + column }
end

puts seat_descriptors
  .map { |d| extract_seat(d) }
  .map { |s| s[:seat_id] }
  .sort
  .each_cons(2)
  .find { |a, b| a + 1 != b }
  .first + 1
