# frozen_string_literal: true

require_relative '../lib/test_and_execute'

# [...] As you continue your walk, the Elf poses a second question: in each
# game you played, what is the fewest number of cubes of each color that could
# have been in the bag to make the game possible?
#
# Again consider the example games from earlier: [see `2-1.test-data`]
#
# - In game 1, the game could have been played with as few as 4 red, 2 green,
#   and 6 blue cubes. If any color had even one fewer cube, the game would have
#   been impossible.
# - Game 2 could have been played with a minimum of 1 red, 3 green, and 4 blue
#   cubes.
# - Game 3 must have been played with at least 20 red, 13 green, and 6 blue
#   cubes.
# - Game 4 required at least 14 red, 3 green, and 15 blue cubes.
# - Game 5 needed no fewer than 6 red, 3 green, and 2 blue cubes in the bag.
#
# The power of a set of cubes is equal to the numbers of red, green, and blue
# cubes multiplied together. The power of the minimum set of cubes in game 1 is
# `48`. In games 2-5 it was `12`, `1560`, `630`, and `36`, respectively. Adding
# up these five powers produces the sum 2286.
#
# For each game, find the minimum set of cubes that must have been present.
# What is the sum of the power of these sets?
test_and_execute(__FILE__) do |data|
  data.lines.reduce(0) do |memo, line|
    draws = line.split(';')

    minimums = {
      'red' => 0,
      'green' => 0,
      'blue' => 0,
    }

    draws.each do |draw|
      cubes = draw.scan(/(\d+) (red|green|blue)/)
      cubes.each do |count, color|
        minimums[color] = [minimums[color], count.to_i].max
      end
    end

    memo + minimums.values.reduce(&:*)
  end
end
