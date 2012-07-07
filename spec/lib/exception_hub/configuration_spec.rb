require 'spec_helper'

describe ExceptionHub::Configuration do
  it "should let me configure through a configuration block" do
    ExceptionHub.config do |config|
      config.repo_name = 'test_repo'
    end

    ExceptionHub.repo_name.should == 'test_repo'
  end

  describe "#user_org_name" do
    it "should return organization_name if that is present" do
      ExceptionHub.configure do |config|
        config.organization_name = 'Foo Bar Inc.'
        config.user_name = nil
      end

      ExceptionHub.user_org_name.should == 'Foo Bar Inc.'
    end

    it "should return user_name when org name is not present" do
      ExceptionHub.configure do |config|
        config.organization_name = nil
        config.user_name = 'Johnny User'
      end

      ExceptionHub.user_org_name.should == 'Johnny User'
    end
  end

  it "should add callbacks for the after_create_exception hook" do
    p = proc {}
    p2 = proc {}
    ExceptionHub.configure do |config|
      config.after_create_exception(&p)
      config.after_create_exception(&p2)
    end

    ExceptionHub.after_create_exception_callback.should include p
    ExceptionHub.after_create_exception_callback.should include p2
  end

  it "should add callbacks for the before_create_exception hook" do
    p = proc {}
    p2 = proc {}
    ExceptionHub.configure do |config|
      config.before_create_exception(&p)
      config.before_create_exception(&p2)
    end

    ExceptionHub.before_create_exception_callback.should include p
    ExceptionHub.before_create_exception_callback.should include p2
  end
end
