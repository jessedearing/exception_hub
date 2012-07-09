require 'spec_helper'

describe ExceptionHub::Issue do
  before do
    ExceptionHub.repo_name = 'exception_hub'
  end

  after do
    ExceptionHub.repo_name = nil
  end

  subject {ExceptionHub::Issue.new}

  it "should send issues to Github" do
    ExceptionHub.current_octokit.should_receive(:create_issue).with(ExceptionHub.repo_name, "Tissue Issue", "Elaborate", :open_timeout => 5)

    subject.title = "Tissue Issue"
    subject.description = "Elaborate"

    subject.send_to_github
  end

  its(:to_yaml_properties) {should_not include '@description'}
end
