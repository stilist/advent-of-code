# @see https://adventofcode.com/2021/day/1

input_file = ARGV.first || "input"
input_filename = "1-#{input_file}.txt"

depths = File.read(input_filename).each_line.map(&:to_i)

def increases(depths = [], window_size = 1)
  window = depths.first(window_size)

  tallied = depths.reduce([0, window]) do |(count, previous_window), depth|
    current_window = [
      previous_window.last(window_size - 1),
      depth,
    ].flatten

    memory_sum = previous_window.reduce(:+) || 0
    current_sum = current_window.reduce(:+)

    [
      current_sum > memory_sum ? count + 1 : count,
      current_window
    ]
  end

  tallied.first
end

puts "Individual measurements: increased #{increases(depths)} times"
puts "Sliding window: increased #{increases(depths, 3)} times"
