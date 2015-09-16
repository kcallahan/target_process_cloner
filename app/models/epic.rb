class Epic < ActiveRecord::Base
  
  has_one :project

  validates :source_remote_id, numericality: { only_integer: true }
  validates :project_id, numericality: { only_integer: true }

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
    new_remote_epic.save
  end

  def project
    Project.find(self.project_id)
  end
end
