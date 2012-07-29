require 'spec_helper'

describe ExceptionHub::Validator::FileSystem do
  context "create_issue?" do
    let(:storage_dbl) {double("storage") }
    let(:exception) {"Exception asdf asdf"}
    let(:env) { Hash.new }

    before do
      ExceptionHub.storage = storage_dbl
      ExceptionHub.storage.should_receive(:find).
        with(exception).
        and_return('26c89dec54fb98fd5d16113cb65e5c4eb89f6b89f0228b2ca706e70891a7790b')
      ExceptionHub.storage.stub(:load)
    end

    subject {ExceptionHub::Validator::FileSystem.new.create_issue?(exception, env)}

    describe "existing exception not found" do
      before do
        ExceptionHub.storage.should_receive(:load).
          with('26c89dec54fb98fd5d16113cb65e5c4eb89f6b89f0228b2ca706e70891a7790b').
          and_return(nil)
      end

      it { should == true }
    end

    describe "existing exception found" do
      before do
        ExceptionHub.storage.should_receive(:load).
          with('26c89dec54fb98fd5d16113cb65e5c4eb89f6b89f0228b2ca706e70891a7790b').
          and_return({:exception => exception, :stacktrace => caller})
      end

      it { should == false }
    end
  end
end
