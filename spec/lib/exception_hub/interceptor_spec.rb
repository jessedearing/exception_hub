require 'spec_helper'

describe ExceptionHub::Interceptor do
  before do
    @interceptor = ExceptionHub::Interceptor.new(Exception.new("Production error!"), {})
    ExceptionHub.validators = []
  end

  describe "create_issue?" do
    subject {@interceptor.create_issue?}

    context "validator return true" do
      let(:all_the_exceptions_validator) { Class.new {def create_issue?(exception,env); true; end}}
      before do
        ExceptionHub.validators = all_the_exceptions_validator
        ENV['RACK_ENV'] = 'production'
      end

      after do
        ExceptionHub.validators = ExceptionHub::Validator::FileSystem
        ENV['RACK_ENV'] = nil
      end

      it {should == true}
    end

    it "should not create issues if it's on the ignored_exceptions list" do
      ExceptionHub.define_defaults
      ExceptionHub.ignored_exceptions << "Exception"

      should be_false
      ExceptionHub.ignored_exceptions = nil
      ExceptionHub.define_defaults
    end

    it "should run in a Rails reporting environment" do
      Rails.env = 'production'

      should be_true
      Rails.env = "development"
    end

    it "should run in a Sinatra::Base reporting environment" do
      module Sinatra
        class Base
          def self.environment
            :production
          end
        end
      end

      should be_true
      Object.send(:remove_const, :Sinatra)
    end

    it "should run in a RACK_ENV reporting environment" do
      ENV['RACK_ENV'] = 'production'

      should be_true
      ENV['RACK_ENV'] = nil
    end

    it "should default to false" do
      should be_false
    end
  end

  describe "should create issues" do
    before do
      ENV['RACK_ENV'] = 'production'
    end

    after do
      ENV['RACK_ENV'] = nil
    end

    describe "intercept!" do
      before do
        @notifier_mock = mock(:notifier)
        @notifier_mock.stub(:perform => @notifier_mock)
        ExceptionHub::Notifier.stub(:new => @notifier_mock)
      end

      subject {@interceptor}

      it "should notify on an exception" do
        @notifier_mock.should_receive(:perform)
        subject.intercept!
      end
    end

    describe "callbacks" do
      before do
        @notifier_mock = mock(:notifier)
        @notifier_mock.stub(:notify!)
        @notifier_mock.stub(:perform => @notifier_mock)
        ExceptionHub::Notifier.stub(:new => @notifier_mock)
      end

      after do
        ExceptionHub.before_create_exception_callbacks.delete_at(0)
        ExceptionHub.after_create_exception_callbacks.delete_at(0)
      end

      subject {@interceptor}

      it "should callback before notifying of the exception" do
        @before_callback_called = false
        ExceptionHub.before_create_exception do
          @before_callback_called = true
        end

        subject.intercept!

        @before_callback_called.should be_true
      end

      it "should callback after notifying of the exception" do
        @after_callback_called = false
        ExceptionHub.after_create_exception do
          @after_callback_called = true
        end

        subject.intercept!

        @after_callback_called.should be_true
      end
    end
  end
end
