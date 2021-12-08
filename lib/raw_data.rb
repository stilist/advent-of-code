def raw_data
  return @raw_data if defined?(@raw_data)

  input_type = ARGV.first == "test" ? "test-data" : "data"
  day = File.basename($0, '.rb')
  filename = "#{day}.#{input_type}"
  path = File.expand_path(File.join(File.dirname($0), filename))
  @raw_data = File.read(path)
end
