class IgnorableExceptionSinceSidekiqWillRetry < StandardError
  def initialize(exception)
    super(exception.message)
    @cause = exception
  end

  def cause = @cause
end
