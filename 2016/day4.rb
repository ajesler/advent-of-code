class Letter < Struct.new(:char, :count)
  def <=>(other)
    if count != other.count
      other.count <=> count
    else
      char <=> other.char
    end
  end
end

class Shifter
  def initialize(distance)
    @distance = distance % 26
  end

  def shift(char)
    return " " if char == "-"
    # 97 - 122
    if (o = char.ord + @distance) <= 122
      o.chr
    else
      ((o % 122) + 96).chr
    end
  end
end

class Room < Struct.new(:encrypted_name, :sector_id, :checksum)
  def self.build(line)
    /(?<encrypted_name>[a-z\-]+{1,})(?<sector_id>[0-9]+)\[(?<checksum>[a-z0-9]+)\]/ =~ line

    Room.new(encrypted_name, sector_id.to_i, checksum)
  end

  def valid?
    most_common_room_name_letters == checksum
  end

  def decrypted_name
    shifter = Shifter.new(sector_id)
    encrypted_name.chars.map { |char| shifter.shift(char) }.join
  end

  private

  def most_common_room_name_letters
    letter_counts.values.sort.first(5).map(&:char).join
  end

  def letter_counts
    letter_hash = Hash.new { |hash, key| hash[key] = Letter.new(key, 0) }

    encrypted_name.delete("-").chars.inject(letter_hash) { |hash, char| hash[char].count += 1; hash }
  end
end

room_set1 = [
  "aaaaa-bbb-z-y-x-123[abxyz]",
  "a-b-c-d-e-f-g-h-987[abcde]",
  "not-a-real-room-404[oarel]",
  "totally-real-room-200[decoy]"
]

room_set2 = File.readlines("day4_input.txt")

rooms = room_set2.map do |line|
  Room.build(line)
end

valid_rooms = rooms.select(&:valid?)

sector_total = valid_rooms.map(&:sector_id).inject(:+)

rooms.select(&:valid?).each do |room|
  puts "#{room.sector_id.to_s.rjust(6)}: #{room.decrypted_name}"
end

puts "Sector Total: #{sector_total}"
