require 'target_process'

# monkey patch TargetProcess gem to include the Epic entity
TargetProcess.module_eval("class Epic; include TargetProcess::Base; end")

# extend TargetProcess to retrieve nested tasks for a user story
module TargetProcess
  class UserStory

    def nested_tasks
      path = "UserStories/#{self.id}/tasks"
      options = {take: 1000}
      TargetProcess.client.get(path, options)[:items].collect! do |task|
        result = TargetProcess::Task.new
        result.attributes.merge!(task)
        result || []
      end
    end

  end
end
