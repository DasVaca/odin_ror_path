$to_roman_map = {
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I"
}

$from_roman_map = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1
}

def from_roman(string)
  return 0 unless string

  if string.size == 1
    return $from_roman_map[string] 
  end

  pair = string[..2]
  rest = string[3..]

  if $from_roman_map.has_key?(pair)
    n = $from_roman_map[pair]
  else
    n = from_roman(pair[0]) + from_roman(pair[1])
  end

  n + from_roman(rest)
end

def to_roman(number)
  if number == 0
    return ''
  end
  
  t = 10**(number.to_s.size - 1)
  d = number.to_s[0].to_i 
  n = d * t

  if $to_roman_map.key?(n)
    return $to_roman_map[n] + to_roman(number - n)
  elsif $to_roman_map.key? (t)
    return $to_roman_map[t]*d + to_roman(number - n)
  end
end

puts "To Roman test"
p "123 -> #{to_roman(123)}"
p "951 -> #{to_roman(951)}"
p "54  -> #{to_roman(54)}"

puts "From Roman test"
p "XX  -> #{from_roman('XX')}"
p "IV  -> #{from_roman('IV')}"
p "MLI -> #{from_roman('MLI')}"
