class ErrorsController < ApplicationController
  def generic_exception
    raise "Uh oh"
  end
end
