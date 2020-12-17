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
    elsif cell == OCCUPIED && ns.count { |s| s == OCCUPIED } >= 4
      EMPTY
    else
      cell
    end
  end

  def neighbours(x, y)
    n = [[0, 1], [0, -1], [-1, 0], [1, 0], [-1, 1], [1, 1], [ -1, -1], [1, -1]].map { |xo, yo| [x + xo, y + yo] }
    n.select { |x1, y1| (0...width).cover?(x1) && (0...height).cover?(y1) }
  end

  def occupied_seats
    to_s.chars.count { |s| s == OCCUPIED }
  end

  def to_s
    @state.map { |l| l.join }.join("\n")
  end

  def height
    @state.size
  end

  def width
    @state.first.size
  end

  def state
    @state
  end
end

test = Automata.new(test_state)
test.iterate_until_stable

occupied = test.occupied_seats
if occupied != 37
  abort("\n\ntest failed")
end

initial_state = File.read("day11-input.txt")
automata = Automata.new(initial_state)

puts automata.iterate_until_stable.occupied_seats
