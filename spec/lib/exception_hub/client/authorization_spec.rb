require 'spec_helper'

describe ExceptionHub::Client::Authorization do
  describe "#get_api_token" do
    before do
      @octokit = double(:octokit_double)
      Octokit::Client.stub(:new => @octokit)
    end

    it "should call Github to create a new token" do
      Octokit::Client.should_receive(:new).with(:login => 'jessedearing', :password => 'asdfasdf').and_return(@octokit)
      @octokit.should_receive(:create_authorization).with(:scopes => [:repo], :note => 'ExceptionHub', :note_url => 'http://github.com/jessedearing/exception_hub')
      ExceptionHub.get_api_token('jessedearing', 'asdfasdf')
    end

    it "should create an initializer" do
      output = ExceptionHub.generate_initializer('jessedearing', 'asdf', 123, 'exception_hub', 'jessedearing')
      output.should include "user_name = 'jessedearing'"
      output.should include "api_token = 'asdf'"
    end
  end
end
