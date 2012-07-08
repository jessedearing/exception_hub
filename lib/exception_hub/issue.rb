module ExceptionHub
  # Issue marshals exception information
  class Issue
    attr_accessor :github_issue_id, :exception_class, :exception_message, :description

    def to_yaml_properties
      ['@github_issue_id', '@exception_class', '@exception_message']
    end
  end
end
