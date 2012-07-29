require 'spec_helper'

describe ExceptionHub::FilteredException do
  describe "FilteredException extends an exception" do
    subject { no_method_error_filtered }

    its(:filtered_message) { should == "undefined method `uniq!' for"}
  end
end
