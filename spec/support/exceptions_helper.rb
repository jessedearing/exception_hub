module ExceptionsHelper
  def no_method_error_filtered(calla=caller)
    NoMethodError.new("undefined method `uniq!' for #<Class:0x10197a34>").tap do |e|
      e.extend ExceptionHub::FilteredException
      e.set_backtrace(calla)
    end
  end
end
