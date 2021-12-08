# @see https://adventofcode.com/2021/day/7

require_relative '../lib/raw_data'

positions = raw_data.split(',').map(&:to_i).freeze

def movement_costs(target_position, current_positions)
  current_positions.map do |position|
    # sort + reverse ensures the result will be a natural number [0,+∞)
    [position, target_position].sort
      .reverse
      .reduce(:-)
  end
end

def lowest_cost(positions)
  unique_positions = positions.uniq.sort

  lowest = Float::INFINITY
  (0..unique_positions.max).each do |target|
    costs = movement_costs(target, positions)
    sum = yield(costs)
    lowest = [lowest, sum].min
  end

  lowest
end

flat_rate = lowest_cost(positions) { |costs| costs.reduce(:+) }
puts "Part 1: lowest cost is #{flat_rate} fuel"

def triangle_number(n)
  (n * (n + 1)) / 2
end
triangle_rate = lowest_cost(positions) do |costs|
  costs.reduce(0) { |memo, n| memo + triangle_number(n) }
end
puts "Part 2: lowest cost is #{triangle_rate} fuel"
