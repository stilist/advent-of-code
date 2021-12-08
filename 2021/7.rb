# @see https://adventofcode.com/2021/day/7

require_relative '../lib/raw_data'
# XXX
require 'pp'

positions = raw_data.split(',').map(&:to_i)
unique_positions = positions.uniq.sort

lowest_cost = Float::INFINITY
unique_positions.each do |position|
  sum = positions.map { |p| [p, position].sort.reverse.reduce(:-) }.reduce(:+)
  lowest_cost = [lowest_cost, sum].min
end

puts "Part 1: lowest cost is #{lowest_cost} fuel"
