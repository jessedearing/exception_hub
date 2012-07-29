require 'spec_helper'

describe ExceptionHub::Validator::FileSystem do
  context "create_issue?" do
    let(:storage_dbl) {double("storage") }
    let(:exception) {"Exception asdf asdf"}
    let(:digest) {Digest::SHA2.hexdigest(exception)}
    let(:env) { Hash.new }

    before do
      ExceptionHub.storage = storage_dbl
      ExceptionHub.storage.stub(:find).and_return(digest)
      ExceptionHub.storage.stub(:load)
    end

    subject {ExceptionHub::Validator::FileSystem.new.create_issue?(exception, env)}

    describe "existing exception not found" do
      before do
        ExceptionHub.storage.should_receive(:load).
          with(digest).
          and_return(nil)
      end

      it { should == true }
    end

    describe "existing exception found" do
      before do
        ExceptionHub.storage.should_receive(:load).
          with(digest).
          and_return({:exception => exception, :stacktrace => caller})
      end

      it { should == false }
    end

    describe "existing exception with specific object_id" do
      let(:exception) {"NoMethodError: undefined method `uniq!' for #<Class:0x10197a34>"}
      let(:filtered_exception) {"NoMethodError: undefined method `uniq!' for"}
      let(:digest) {Digest::SHA2.hexdigest("NoMethodError: undefined method `uniq!' for")}

      before do
        ExceptionHub.storage.should_receive(:load).
          with(digest).
          and_return({:exception => exception, :stacktrace => caller})
        ExceptionHub.storage.should_receive(:find).
          with(filtered_exception).
          and_return(digest)
      end

      it { should == false}
    end
  end
end
