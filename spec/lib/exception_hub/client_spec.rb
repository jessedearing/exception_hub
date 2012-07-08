require 'spec_helper'

describe ExceptionHub::Client do
  describe "authenticated Octokit client" do
    before do
      ExceptionHub.github_api_token = 'abc123'
      ExceptionHub.github_user_name = 'jessedearing'
    end

    subject {ExceptionHub.current_octokit}

    its(:oauth_token) {should == ExceptionHub.github_api_token }
    its(:login) {should == ExceptionHub.github_user_name }
  end

  describe "unauthenticated Octokit client" do
    before do
      ExceptionHub.github_api_token = nil
      ExceptionHub.github_user_name = nil
      ExceptionHub.reload_octokit!
    end

    subject {ExceptionHub.current_octokit}

    its(:oauth_token) {should == nil}
    its(:login) {should == nil}
  end
end
