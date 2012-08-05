require 'spec_helper'

describe ExceptionHub::Storage::Json do
  before do
    ExceptionHub.storage_path = "/tmp"
    io.stub(:exists? => true)
    dir.stub(:exists? => true)
  end

  after do
    ExceptionHub.storage_path = Pathname.new(File.expand_path('tmp'))
  end

  let(:io) {mock("IO")}
  let(:dir) {mock('Dir')}

  describe "save" do
    before do
      io.should_receive(:write).with(Pathname("/tmp/foo.json"), '{"foo":"bar"}')
      dir.stub(:exists? => false)
      dir.should_receive(:mkdir).with(ExceptionHub.storage_path)
    end

    subject {ExceptionHub::Storage::Json.new(io, dir).save("foo", {'foo' => 'bar'})}

    it { should == Pathname("/tmp/foo.json") }
  end

  describe "load" do
    let(:file_mock) {mock("File")}

    before do
      file_mock.stub(:readlines => ['{"foo":"bar","baz": "bat"}'])
      io.should_receive(:open).with(Pathname("/tmp/bar.json"), "r").and_yield(file_mock)
    end

    subject {ExceptionHub::Storage::Json.new(io, dir).load("bar")}

    it { should == {'foo' => 'bar', 'baz' => 'bat'} }
  end

  describe "find" do
    subject {ExceptionHub::Storage::Json.new.find("Exception asdf asdf")}

    it { should == "26c89dec54fb98fd5d16113cb65e5c4eb89f6b89f0228b2ca706e70891a7790b"}
  end
end
