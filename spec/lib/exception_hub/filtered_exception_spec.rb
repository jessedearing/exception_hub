require 'spec_helper'

describe ExceptionHub::FilteredException do
  describe "FilteredException extends an exception" do
    before { @caller = caller }
    subject { no_method_error_filtered(@caller) }

    its(:filtered_message) { should == "undefined method `uniq!' for"}
    its(:formatted_backtrace) { should == @caller.reduce("") {|m,l| m << l << "\n" }}
  end
end
