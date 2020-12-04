input = File.read("input.txt")

REQUIRED_FIELDS = %w(byr iyr eyr hgt hcl ecl pid)

passports = input.split("\n\n")
  .map { |b|
    b.split(/\n|\s/)
      .map { |s| s.split(":") }
      .to_h
      .reject { |k, _| k == "cid" }
  }

puts passports.count { |p| REQUIRED_FIELDS.all? { |f| p.key?(f) } }
