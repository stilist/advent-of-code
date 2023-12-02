# frozen_string_literal: true

require_relative '../lib/test_and_execute'

# --- Day 1: Trebuchet?! ---
#
# [...] On each line, the calibration value can be found by combining the
# *first digit* and the *last digit* (in that order) to form a single two-digit
# number.
#
# For example: [see 1-1.test-data]
#
# In this example, the calibration values of these four lines are `12`, `38`,
# `15`, and `77`. Adding these together produces `142`.
#
# Consider your entire calibration document. What is the sum of all of the
# calibration values?
test_and_execute(__FILE__) do |data|
  data.lines.reduce(0) do |memo, line|
    digits = line.scan(/\d/)
    memo + [digits.first, digits.last].join.to_i
  end
end
