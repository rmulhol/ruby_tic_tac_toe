class MockIoStream
  def initialize(user_input = ["gets was called"])
    @user_input = user_input
  end

  def puts(message)
    "puts was called"
  end

  def gets
    @user_input.shift
  end
end