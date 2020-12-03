# frozen_string_literal: true

# Run the solver with the input after __END__
# $ ruby solver.rb
#
# Run the solver using a file as input
# $ ruby solver.rb test_input.txt
#
# Run solver specs with
# $ ruby solver.rb --specs

class Solver
  def solve
  end
end

require 'test/unit'
Test::Unit::AutoRunner.need_auto_run = false

class SolverSpec < Test::Unit::TestCase
end

if $PROGRAM_NAME == __FILE__
  first_argument = ARGV.shift

  if first_argument == '--specs'
    # Run the specs
    Test::Unit::AutoRunner.need_auto_run = true
  else
    data_source = first_argument.nil? ? DATA.read : File.read(first_argument)
    lines = data_source.lines

    Solver.new.solve
  end
end

__END__
lines
of
data
