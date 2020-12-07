bag_rules = File.read("day07-input.txt")

Bag = Struct.new(:adjective, :colour)

bags_contain = bag_rules.lines(chomp: true).map do |rule|
  bag_description, contents = rule.split("\sbags contain\s")
  bag = Bag.new(*bag_description.split("\s"))

  [bag, contents
          .tap { |c| c == "no other bags." ? "" : c }
          .split(", ")
          .map { |l| l.split("\s") }
          .map { |count, adj, col, _| [Bag.new(adj, col), count.to_i] }
          .to_h]
end.to_h

shiny_gold_bag = Bag.new("shiny", "gold")

bag_count = 0
queue = [shiny_gold_bag]

while queue.size > 0
  bags_contain[queue.shift].each { |b, c| c.times { queue << b } }
  bag_count += 1
end

puts bag_count - 1
