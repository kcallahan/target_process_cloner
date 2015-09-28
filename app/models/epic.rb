class Epic < TargetProcessEntity
  
  belongs_to :target_process_entity
  has_one    :project
  has_many   :features

  def set_resource_type
    @resource_type     = "Epic"
    self.resource_type = "Epic"
  end

  def project
    Project.find(self.project_id)
  end
end
