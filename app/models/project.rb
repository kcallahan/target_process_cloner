class Project < ActiveRecord::Base
	include TargetProcess

  validates :source_remote_id, numericality: { only_integer: true }

  before_save :create_new_remote_project

  def create_new_remote_project
  	new_remote_project = TargetProcess::Project.new
    new_remote_project.resource_type = "Project"
  	new_remote_project.name = self.name
  	new_remote_project.owner = {:id => self.owner}

  	response = new_remote_project.save
  	self.cloned_remote_id = response.id
  end
end
