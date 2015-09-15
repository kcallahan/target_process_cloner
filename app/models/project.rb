class Project < ActiveRecord::Base
	include TargetProcess
  include TargetProcessUtilities

  has_many :epics

  validates :source_remote_id, numericality: { only_integer: true }

  before_save :create_remote_project_and_save_id

  def create_remote_project_and_save_id
    remote_project = create_remote_project
    self.cloned_remote_id = remote_project.id
  end

  def create_remote_project
    new_remote_project = TargetProcess::Project.new
    new_remote_project.resource_type = "Project"
    new_remote_project.name = self.name
    new_remote_project.owner = {:id => self.owner}
    new_remote_project.save
  end

end
