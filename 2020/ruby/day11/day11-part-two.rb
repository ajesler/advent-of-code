test_state = <<~STATE
  L.LL.LL.LL
  LLLLLLL.LL
  L.L.L..L..
  LLLL.LL.LL
  L.LL.LL.LL
  L.LLLLL.LL
  ..L.L.....
  LLLLLLLLLL
  L.LLLLLL.L
  L.LLLLL.LL
STATE

class Automata
  EMPTY = "L"
  OCCUPIED = "#"
  FLOOR = "."

  def initialize(state)
    @state = state.split("\n").map { |l| l.chars }
  end

  def iterate
    new_state = Array.new(height) { Array.new(width, nil) }

    (0...height).each do |y|
      (0...width).each do |x|
        new_state[y][x] = next_state(x, y)
      end
    end

    @state = new_state
    self
  end

  def iterate_until_stable
    while true
      prev_state = @state.dup

      iterate

      break if prev_state == @state
    end

    self
  end

  def cell(x, y)
    @state[y][x]
  end

  def next_state(x, y)
    ns = neighbours(x, y).map { |x1, y1| @state[y1][x1] }
    cell = @state[y][x]

    if cell == EMPTY && ns.none? { |s| s == OCCUPIED }
      OCCUPIED
    elsif cell == OCCUPIED && ns.count { |s| s == OCCUPIED } >= 5
      EMPTY
    else
      cell
    end
  end

  def within_bounds?(x, y)
    x >= 0 && x < width  && y >= 0 && y < height
  end

  def neighbours(x, y)
    #     U       UR        R       DR      D       DL      L       UL
    directions = [[0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1]]
    coords = directions.map do |dx, dy|
      Enumerator.produce([x + dx, y + dy]) { |x1, y1| [dx + x1, dy + y1] }
        .lazy
        .take_while { |x1, y1| within_bounds?(x1, y1) }
        .detect { |x1, y1| cell(x1, y1) != FLOOR }
    end.compact

    coords
  end

  def occupied_seats
    to_s.chars.count { |s| s == OCCUPIED }
  end

  def to_s
    @state.map { |l| l.join }.join("\n")
  end

  def height
    @height ||= @state.size
  end

  def width
    @width ||= @state.first.size
  end

  def dimensions
    [width, height]
  end

  def state
    @state
  end
end

test = Automata.new(test_state)
test.iterate_until_stable

occupied = test.occupied_seats
if occupied != 26
  abort("\n\ntest failed")
end

initial_state = File.read("day11-input.txt")
automata = Automata.new(initial_state)

puts automata.iterate_until_stable.occupied_seats
