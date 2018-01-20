OUTPUT_WORDS = 280
NONWORD = " "

#Get our input formatted as an array of strings, each element being a word from the input
#Some formatting and randomness applied here as well
def data_array(path)
  lines = File.readlines(path)
  rand = (0 + rand(lines.length)).to_i
  lines.rotate(rand).join("\n").gsub("/\\\//", "").tr('"', '').gsub("\n"," ").split(" ")
end

#Create a table representing a prefix (key) and the common suffixes (value) for that prefix
#In this representation, prefixes are 2 words, or N = 2
def freq_table(data)

  freq_table = {}
  x = NONWORD
  y = NONWORD

  data.each do |word|
    (freq_table["#{x} #{y}"] ||= []) << word
    x = y
    y = word
  end

  (freq_table["#{x} #{y}"] ||= []) << NONWORD

  freq_table

end

#Generate the output by sampling from our frequency table
def output(table)
  
  output = ""
  x = NONWORD
  y = NONWORD

  OUTPUT_WORDS.times do
    word = table["#{x} #{y}"].sample 
    break if word == NONWORD
    output << "#{word} "
    x = y
    y = word
  end

  output

end

def main

  if ARGV[0]
    data = data_array(ARGV[0])
    table = freq_table(data)
    p output(table)
  else
    p "Path is missing. Aborting"
  end

end

main
