require 'spec_helper'

describe ExceptionHub do
  it "should log exceptions to ExceptionHub.logger" do
    message = "All aboard the failcraft carrier"
    ex = Exception.new(message)
    ex.set_backtrace(caller)
    @errors = []

    logger = double(:logger)
    ExceptionHub.logger = logger

    logger.should_receive(:error).twice do |log|
      @errors << log
    end

    ExceptionHub.log_exception_hub_exception(ex)

    @errors.first.should =~ /ExceptionHub: Exception: #{message}/
  end
end
