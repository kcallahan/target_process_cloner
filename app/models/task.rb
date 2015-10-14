class Task < TargetProcessEntity

  belongs_to :user_story

  def set_resource_type
    @resource_type     = "Task"
    self.resource_type = "Task"
  end

  def specific_remote_params
    {
      :project => {:id => self.user_story.project.cloned_remote_id}, 
      :userstory => {:id => self.user_story.cloned_remote_id}
    }
  end
end