NLETTERS = 26

def alpha?(char) 
  char.between?('a', 'z') || char.between?('A', 'Z')
end

def upper?(char)
  char == char.upcase
end

def shift_factor(char)
  (upper?(char) ? 'A'.ord: 'a'.ord)
end

def shift_letter(c, shift)
  (((c.ord + shift) % shift_factor(c)) % NLETTERS + shift_factor(c)).chr
end

def caesar_cipher(string, shift)
  shift = shift % NLETTERS
  string.each_char.map {|c| alpha?(c) ? shift_letter(c, shift) : c}.join
end

