def raw_data
  return @raw_data if defined?(@raw_data)

  input_type = ARGV.first == "test" ? "test-data" : "data"
  day = File.basename($0, '.rb')
  @raw_data = File.read("#{day}.#{input_type}").each_line
end
