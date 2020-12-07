require "set"

bag_rules = File.read("day07-input.txt")

Bag = Struct.new(:adjective, :colour)

bags_may_contain = bag_rules.lines(chomp: true).map do |rule|
  bag_description, contents = rule.split("\sbags contain\s")
  bag = Bag.new(*bag_description.split("\s"))

  [bag, contents
          .tap { |c| c == "no other bags." ? "" : c }
          .split(", ")
          .map { |l| l.split("\s") }
          .map { |_, adj, col, _| Bag.new(adj, col) }]
end.to_h

shiny_gold_bag = Bag.new("shiny", "gold")

searched = Set.new
can_contain_bag = Set.new
search_queue = [shiny_gold_bag]

while search_queue.size > 0
  search = search_queue.shift
  searched << search

  contained_by = bags_may_contain.select { |k, v| v.include?(search) }.keys

  contained_by.each { |b| can_contain_bag << b }
  contained_by.reject { |b| searched.include?(b) }.each { |b| search_queue << b }
end

puts can_contain_bag.count
