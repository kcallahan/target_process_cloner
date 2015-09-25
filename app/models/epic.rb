class Epic < TargetProcessEntity
  
  belongs_to :target_process_entity
  has_one    :project
  has_many   :features

  before_save :create_remote_epic_and_save_id


  def create_remote_epic_and_save_id
    remote_epic = create_remote_epic
    self.cloned_remote_id = remote_epic.id
  end

  def create_remote_epic
    new_remote_epic = TargetProcess::Epic.new
    new_remote_epic.resource_type = "Epic"
    new_remote_epic.name = self.name
    new_remote_epic.owner = {:id => self.owner}
    new_remote_epic.project = {:id => self.project.cloned_remote_id}
    new_remote_epic.numeric_priority = self.numeric_priority
    new_remote_epic.save
  end

  def project
    Project.find(self.project_id)
  end
end
