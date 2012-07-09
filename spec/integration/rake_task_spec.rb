require 'spec_helper'

describe "ExceptionHub Rake tasks", :slow_test do
  it "should show up when listing tasks" do
    output = `cd spec/integration/exception_hub_integration && rake -T`

    output.should include "rake exception_hub:generate_initializer"
  end
end
