# frozen_string_literal: true

require_relative '../lib/test_and_execute'

WORDS = [
  'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'
]

def digitize maybe_word
  return maybe_word.to_i if maybe_word.match?(/\d/)
  WORDS.index(maybe_word) + 1
end

# Your calculation isn't quite right. It looks like some of the digits are
# actually spelled out with letters: one, two, three, four, five, six, seven,
# eight, and nine also count as valid "digits".
#
# Equipped with this new information, you now need to find the real first and
# last digit on each line. For example: [see `1-2.test-data`]
#
# In this example, the calibration values are `29`, `83`, `13`, `24`, `42`,
# `14`, and `76`. Adding these together produces `281`.
#
# What is the sum of all of the calibration values?
test_and_execute(__FILE__) do |data|
  data.lines.reduce(0) do |memo, line|
    digits = line.scan(/(?=(\d|#{WORDS.join '|'}))/).flatten
    memo + (digitize(digits.first) * 10) + digitize(digits.last)
  end
end
