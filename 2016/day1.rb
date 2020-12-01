input = [
  "R2, L3",
  "R2, R2, R2",
  "R5, L5, R5, R3",
  "R4, R3, L3, L2, L1, R1, L1, R2, R3, L5, L5, R4, L4, R2, R4, L3, R3, L3, R3, R4, R2, L1, R2, L3, L2, L1, R3, R5, L1, L4, R2, L4, R3, R1, R2, L5, R2, L189, R5, L5, R52, R3, L1, R4, R5, R1, R4, L1, L3, R2, L2, L3, R4, R3, L2, L5, R4, R5, L2, R2, L1, L3, R3, L4, R4, R5, L1, L1, R3, L5, L2, R76, R2, R2, L1, L3, R189, L3, L4, L1, L3, R5, R4, L1, R1, L1, L1, R2, L4, R2, L5, L5, L5, R2, L4, L5, R4, R4, R5, L5, R3, L1, L3, L1, L1, L3, L4, R5, L3, R5, R3, R3, L5, L5, R3, R4, L3, R3, R1, R3, R2, R2, L1, R1, L3, L3, L3, L1, R2, L1, R4, R4, L1, L1, R3, R3, R4, R1, L5, L2, R2, R3, R2, L3, R4, L5, R1, R4, R5, R4, L4, R1, L3, R1, R3, L2, L3, R1, L2, R3, L3, L1, L3, R4, L4, L5, R3, R5, R4, R1, L2, R3, R5, L5, L4, L1, L1"
]


  HEADING_TRANSFORMS = {
    :NR => :E,
    :NL => :W,
    :ER => :S,
    :EL => :N,
    :SR => :W,
    :SL => :E,
    :WR => :N,
    :WL => :S
  }

class Point < Struct.new(:x, :y)
  def go_e(distance)
    Point.new(self.x + distance, self.y)
  end

  def go_w(distance)
    Point.new(self.x - distance, self.y)
  end

  def go_n(distance)
    Point.new(self.x, self.y + distance)
  end

  def go_s(distance)
    Point.new(self.x, self.y - distance)
  end

  def blocks_away
    x.abs + y.abs
  end
end

def to_points(path)
  sequence = path.split(", ")

  location = Point.new(0, 0)
  heading = :N
  
  first_repeat = nil
  travel = [location]
  path.split(", ").each do |action|
    heading = HEADING_TRANSFORMS["#{heading}#{action[0]}".to_sym]
    distance = action[1..-1].to_i
    
    distance.times do
      new_location = location.send("go_#{heading.to_s.downcase}", 1)
      travel << new_location
      location = new_location
    end
  end

  loop do
    head, tail = travel[0], travel[1..-1]
    break if tail.empty?

    if tail.include?(head)
      puts "Repeated visit at #{head.blocks_away} blocks away"
    end

    travel = tail
  end
end


# Solution to part 1
def process(path)
  # Start facing north
  travel = Hash.new(0)
  heading = :N

  sequence = path.split(", ")

  puts "Path: #{path}"
  sequence.each do |action|
    heading = heading_transforms["#{heading}#{action[0]}".to_sym]
    distance = action[1..-1].to_i
    travel[heading] += distance
    puts "#{heading} #{distance}"
  end

  puts travel
  puts ((travel[:E]-travel[:W]).abs+(travel[:N]-travel[:S]).abs)
end

input.each do |i|
  # process(i)
  puts "Path: #{i}"
  to_points(i)
end
