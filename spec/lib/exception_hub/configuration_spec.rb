require 'spec_helper'

describe ExceptionHub::Configuration do
  it "should let me configure through a configuration block" do
    ExceptionHub.config do |config|
      config.repo_name = 'test_repo'
    end

    ExceptionHub.repo_name.should == 'test_repo'
  end

  it "should alias organization_name to user_name" do
    ExceptionHub.config do |config|
      config.organization_name = 'foo'
    end

    ExceptionHub.user_name.should == 'foo'
  end

  it "should add callbacks for the after_create_exception hook" do
    p = proc {}
    p2 = proc {}
    ExceptionHub.configure do |config|
      config.after_create_exception(&p)
      config.after_create_exception(&p2)
    end

    ExceptionHub.after_create_exception_callbacks.should include p
    ExceptionHub.after_create_exception_callbacks.should include p2
  end

  it "should add callbacks for the before_create_exception hook" do
    p = proc {}
    p2 = proc {}
    ExceptionHub.configure do |config|
      config.before_create_exception(&p)
      config.before_create_exception(&p2)
    end

    ExceptionHub.before_create_exception_callbacks.should include p
    ExceptionHub.before_create_exception_callbacks.should include p2
  end
end
