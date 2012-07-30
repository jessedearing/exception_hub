require 'spec_helper'

describe ExceptionHub::ExceptionStorage do
  before do
    ExceptionHub.storage = mock('storage').tap do |m|
      m.stub(:new => m)
      m.should_receive(:find).and_return('abc123')
      m.should_receive(:save).with('abc123', {:message => exception.message,
                                   :backtrace => exception.formatted_backtrace})
    end
  end
  let(:exception) {no_method_error_filtered}
  subject {ExceptionHub::ExceptionStorage.new.perform(exception, {})}

  it { should == subject}

end
