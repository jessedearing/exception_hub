module ExceptionHub
  # Issue marshals exception information
  class Issue
    # !@attribute [rw]
    # @return [Integer] The issue ID in Github
    attr_accessor :github_issue_id

    # !@attribute [rw]
    # @return [String] Name of the exception class
    attr_accessor :exception_class

    # !@attribute [rw]
    # @return [String] The message body of the exception
    attr_accessor :exception_message

    # !@attribute [rw]
    # @return [String] Description to be displayed in the body of the Github issue
    attr_accessor :description

    # Creates the current Issue in Github
    def send_to_github
      #TODO Create issue in Github
    end

    def to_yaml_properties
      ['@github_issue_id', '@exception_class', '@exception_message']
    end
  end
end
