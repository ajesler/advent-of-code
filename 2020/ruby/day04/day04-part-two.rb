input = File.read("input.txt")

FIELD_VALIDATIONS = {
  "byr" => proc { |v| (1920..2002).include?(v.to_i) },
  "iyr" => proc { |v| (2010..2020).include?(v.to_i) },
  "eyr" => proc { |v| (2020..2030).include?(v.to_i) },
  "hgt" => proc do |v|
    md = /\A(?<size>\d{2,3})(?<units>(cm|in))\z/.match(v)
    md && (md[:units] == "cm" ? (150..193).include?(md[:size].to_i) : (59..76).include?(md[:size].to_i))
  end,
  "hcl" => proc { |v| /\A#[0-9a-f]{6}\z/.match?(v) },
  "ecl" => proc { |v| %w(amb blu brn gry grn hzl oth).include?(v) },
  "pid" => proc { |v| /\A\d{9}\z/.match?(v) },
}

REQUIRED_FIELDS = %w(byr iyr eyr hgt hcl ecl pid)
passports = input.split("\n\n")
  .map { |b|
    b.split(/\n|\s/)
      .map { |s| s.split(":") }
      .to_h
      .reject { |k, _| k == "cid" }
  }

puts passports
  .select { |p| REQUIRED_FIELDS.all? { |f| p.key?(f) } }
  .count { |p| p.all? { |k, v| FIELD_VALIDATIONS[k].(v) } }
