require 'csv'
require 'erb'
require 'time'
require 'google/apis/civicinfo_v2'

def clean_phonenumber phonenumber
  number = phonenumber.to_s.gsub(/\D/, '')

  if number.length == 11 and number[0] == '1'
    number = number.slice(1..10)
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

def get_date(datestr)
  Time.strptime(datestr, "%Y/%d/%m %k:%M") {|y| y + 2000}
end

def hot_keys dict
  dict.sort_by { |k, v| v }.reverse.map {|k, v| k}
end

def count_date(date, reg_hours, reg_days)
  reg_hours[date.hour] += 1
  reg_days[date.strftime("%A")] += 1
end

puts "EventManager initialized"

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

reg_hours = Hash.new(0)
reg_days = Hash.new(0)

contents.each do |row|
  #id = row[0]
  #name = row[:first_name]
  #phonenumber = clean_phonenumber row[:homephone]
  #zipcode = clean_zipcode(row[:zipcode])
  #legislators = legislators_by_zipcode(zipcode)
  count_date(get_date(row[:regdate]), reg_hours, reg_days)
  
  #form_letter = erb_template.result(binding) 

  #save_letter(id, form_letter)
end

hot_hours = hot_keys reg_hours
puts "The 3 best hours for advertisement are #{hot_hours.first(3).join(', ')}."

hot_days = hot_keys reg_days 
puts "The 3 days where ppl register are #{hot_days.first(3).join(', ')}."
