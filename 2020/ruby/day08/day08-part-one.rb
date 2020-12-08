require "set"

instructions_lines = File.read("day08-input.txt").lines(chomp: true)

instructions = instructions_lines.map { |i| i.split("\s") }.map.with_index { |(op, arg), i| [i + 1, op, arg.to_i] }

acc = 0
instruction_pointer = 1
executed_instructions = Set.new

while !executed_instructions.include?(instruction_pointer)
  i, op, arg = instructions[instruction_pointer - 1]

  executed_instructions << i

  case op
  when "acc"
    acc += arg
    instruction_pointer += 1
  when "jmp"
    instruction_pointer += arg
  when "nop"
    instruction_pointer += 1
  end
end

puts acc
