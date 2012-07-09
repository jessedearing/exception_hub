module ExceptionHub
  # Issue marshals exception information
  class Issue
    # !@attribute [rw]
    # @return [Integer] The issue ID in Github
    attr_accessor :github_issue_id

    # !@attribute [rw]
    # @return [String] Title of the Github issue
    attr_accessor :title

    # !@attribute [rw]
    # @return [String] Description to be displayed in the body of the Github issue
    attr_accessor :description

    # Creates the current Issue in Github
    def send_to_github
      ExceptionHub.current_octokit.create_issue("#{ExceptionHub.repo_owner}/#{ExceptionHub.repo_name}", self.title, self.description, :open_timeout => 5)
    end

    def to_yaml_properties
      ['@github_issue_id', '@title']
    end
  end
end
