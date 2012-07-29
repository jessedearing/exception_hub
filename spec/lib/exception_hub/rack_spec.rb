require 'spec_helper'

describe ExceptionHub::Rack do
  before do
    @rack_app_mock = mock(:rack_app)
    @rack = ExceptionHub::Rack.new(@rack_app_mock)
  end

  subject {@rack}

  it "should catch and log exceptions" do
    @rack_app_mock.stub(:call) {raise "Production error!"}
    ExceptionHub.should_receive(:handle_exception)
    expect { subject.call({}) }.to raise_error "Production error!"
  end

  it "should log rack errors" do
    @rack_app_mock.stub(:call)
    ExceptionHub.should_receive(:handle_exception)
    subject.call({'rack.exception' => Exception.new("Rack error")})
  end
end
