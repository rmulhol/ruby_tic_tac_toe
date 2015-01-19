require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent + "lib" + "input_output.rb"
require Pathname(__dir__).parent + "lib" + "mock_io_stream.rb"

class InputOutputTest < Minitest::Test
  def setup
    input_stream = MockIoStream.new
    output_stream = MockIoStream.new
    @io = InputOutput.new(input_stream, output_stream)
  end

  def test_puts
    assert_equal "puts was called", @io.puts("message")
  end

  def test_get_input
    assert_equal "gets was called", @io.get_input
  end
end