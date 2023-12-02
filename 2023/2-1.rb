# frozen_string_literal: true

require_relative '../lib/test_and_execute'

RULE = {
  'red' => 12,
  'green' => 13,
  'blue' => 14
}.freeze

# --- Day 2: Cube Conundrum ---
#
# [...] As you walk, the Elf shows you a small bag and some cubes which are
# either red, green, or blue. Each time you play this game, he will hide a
# secret number of cubes of each color in the bag, and your goal is to figure
# out information about the number of cubes.
#
# To get information, once a bag has been loaded with cubes, the Elf will reach
# into the bag, grab a handful of random cubes, show them to you, and then put
# them back in the bag. He'll do this a few times per game.
#
# You play several games and record the information from each game (your puzzle
# input). Each game is listed with its ID number (like the `11`` in
# `Game 11: ...`) followed by a semicolon-separated list of subsets of cubes
# that were revealed from the bag (like `3 red, 5 green, 4 blue`).
#
# For example, the record of a few games might look like this: [see
# `2-1.test-data`]
#
# In game 1, three sets of cubes are revealed from the bag (and then put back
# again). The first set is 3 blue cubes and 4 red cubes; the second set is 1
# red cube, 2 green cubes, and 6 blue cubes; the third set is only 2 green
# cubes.
#
# The Elf would first like to know which games would have been possible if the
# bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?
#
# In the example above, games 1, 2, and 5 would have been possible if the bag
# had been loaded with that configuration. However, game 3 would have been
# impossible because at one point the Elf showed you 20 red cubes at once;
# similarly, game 4 would also have been impossible because the Elf showed you
# 15 blue cubes at once. If you add up the IDs of the games that would have
# been possible, you get `8`.
#
# Determine which games would have been possible if the bag had been loaded
# with only 12 red cubes, 13 green cubes, and 14 blue cubes. What is the sum of
# the IDs of those games?
test_and_execute(__FILE__) do |data|
  data.lines.reduce(0) do |memo, line|
    draws = line.split(';')
    valid = true

    draws.each do |draw|
      cubes = draw.scan(/(\d+) (red|green|blue)/)
      cubes.each do |count, color|
        valid = count.to_i <= RULE[color]
        break unless valid
      end
      break unless valid
    end

    id = line.match(/^Game (?<id>\d+):/)[:id].to_i
    valid ? memo + id : memo
  end
end
