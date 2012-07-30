require 'spec_helper'

describe ExceptionHub::Notifier do
  before do
    @issue_mock = mock(:issue)
    @issue_mock.stub(:description=)
    @issue_mock.stub(:title=)
    @issue_mock.stub(:send_to_github)
    ExceptionHub::Issue.stub(:new => @issue_mock)
    ExceptionHub.define_defaults
  end

  subject {ExceptionHub::Notifier.new}

  it "should notify Github" do
    @issue_mock.should_receive(:send_to_github)
    subject.perform(Exception.new("Production error!"), {'foo' => {'bar' => 42}})
  end

  it "should log but swallow exceptions" do
    logger_mock = mock(:logger)
    logger_mock.should_receive(:error).twice
    ExceptionHub.logger = logger_mock
    @issue_mock.stub(:send_to_github) { raise "error sending to Github" }

    subject.perform(Exception.new("Production error!"), {})

    ExceptionHub.logger = nil
    ExceptionHub.define_defaults
  end
end
