# frozen_string_literal: true

class MissingBlockError < StandardError
  def initialize(msg = 'Missing block')
    super
  end
end

class TestFailureError < StandardError
  def initialize(test_result, expected_test_result)
    super <<~MSG
      Test failed
      Got:
      #{test_result}
      Expected:
      #{expected_test_result}
    MSG
  end
end

# @yieldparam data [String] The data to be processed
# @yieldreturn [String] The result of processing the data

# @example
# require_relative '../lib/test_and_execute'
# test_and_execute(__FILE__) do |data|
#   # implement behavior for `data`...
# end
def test_and_execute(calling_filename)
  raise MissingBlockError unless block_given?

  basename = File.basename calling_filename, '.rb'

  test_data = File.read "#{basename}.test-data"
  test_result = yield test_data
  expected_test_result = File.read "#{basename}.test-result"
  unless test_result.to_s == expected_test_result.strip
    raise TestFailureError.new test_result, expected_test_result
  end

  data_basename = basename.sub(/-\d+/, '')
  real_data = File.read "#{data_basename}.data"
  puts yield real_data
end
