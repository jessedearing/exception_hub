require 'spec_helper'

describe ExceptionHub::Storage::Json do
  before do
    ExceptionHub.storage_path = "/tmp"
  end

  after do
    ExceptionHub.storage_path = Pathname.new(File.expand_path('tmp'))
  end

  describe "save" do
    before do
      @io = mock("IO")
      @io.should_receive(:write).with(Pathname("/tmp/foo.json"), '{"foo":"bar"}')
    end

    subject {ExceptionHub::Storage::Json.new(@io).save("foo", {'foo' => 'bar'})}

    it { should == Pathname("/tmp/foo.json") }
  end

  describe "load" do
    before do
      @io = mock("IO")
      file = mock("File")
      file.stub(:readlines => ['{"foo":"bar","baz": "bat"}'])
      @io.should_receive(:open).with(Pathname("/tmp/bar.json"), "r").and_yield(file)
    end

    subject {ExceptionHub::Storage::Json.new(@io).load("bar")}

    it { should == {'foo' => 'bar', 'baz' => 'bat'} }
  end

  describe "find" do
    subject {ExceptionHub::Storage::Json.new.find("Exception asdf asdf")}

    it { should == "26c89dec54fb98fd5d16113cb65e5c4eb89f6b89f0228b2ca706e70891a7790b"}
  end
end
