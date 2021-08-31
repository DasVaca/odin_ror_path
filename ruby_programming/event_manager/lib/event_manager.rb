require 'csv'
require 'erb'
require 'google/apis/civicinfo_v2'

def clean_phonenumber phonenumber
  number = phonenumber.to_s.gsub(/\D/, '')

  if number.length == 11
    if number[0] == '1'
      number.slice!(1..10)
    else
      number = '0'*10
    end
  elsif number.length < 10 or number.length > 11
    number = '0'*10
  end

  number.slice(0...10)
end

def clean_zipcode zipcode
  zipcode.to_s.rjust(5, '0').slice(-5..-1)
end

def legislators_by_zipcode zipcode
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_letter(id, letter)
  Dir.mkdir('letters') unless Dir.exist? 'letters'

  filename = "letters/#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts letter
  end 
end

puts "EventManager initialized"

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phonenumber = clean_phonenumber row[:homephone]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  
  form_letter = erb_template.result(binding) 

  save_letter(id, form_letter)
end
