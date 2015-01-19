class InputOutput
  attr_reader :input_stream, :output_stream

  def initialize(input_stream = $stdin, output_stream = $stdout)
    @input_stream = input_stream
    @output_stream = output_stream
  end

  def puts(message)
    output_stream.puts(message)
  end

  def get_input
    input_stream.gets.chomp
  end
end