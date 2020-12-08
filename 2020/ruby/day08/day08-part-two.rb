require "set"

instructions_lines = File.read("day08-input.txt").lines(chomp: true)

instructions = instructions_lines.map { |i| i.split("\s") }.map.with_index { |(op, arg), i| [i + 1, op, arg.to_i] }

class Program
  def initialize(instructions)
    @instructions = instructions

    @acc = 0
    @instruction_pointer = 1
    @executed_instructions = Set.new
  end

  def run
    while !@executed_instructions.include?(@instruction_pointer) && @instruction_pointer <= @instructions.size
      i, op, arg = @instructions[@instruction_pointer - 1]

      @executed_instructions << i

      case op
      when "acc"
        @acc += arg
        @instruction_pointer += 1
      when "jmp"
        @instruction_pointer += arg
      when "nop"
        @instruction_pointer += 1
      end
    end

    halted = @instruction_pointer > @instructions.size
    [halted, @acc]
  end
end

instructions.each do |i|
  next if i[1] == "acc"

  mutation = instructions.dup
  mutation[i[0]-1] = [i[0], i[1] == "nop" ? "jmp" : "nop", i[2]]

  halted, acc = Program.new(mutation).run

  if halted
    puts acc
    break
  end
end
