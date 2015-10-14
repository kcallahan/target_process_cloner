class Epic < TargetProcessEntity

  belongs_to :project
  has_many   :features

  def set_resource_type
    @resource_type     = "Epic"
    self.resource_type = "Epic"
  end

  def specific_remote_params
    {
      :project => {
        :id => self.project.cloned_remote_id
      }
    }
  end

end