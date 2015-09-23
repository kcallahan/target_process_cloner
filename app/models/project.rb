require 'target_process_utilities'

class Project < ActiveRecord::Base
  include TargetProcessUtilities

  has_many :epics

  validates :source_remote_id, numericality: { only_integer: true }
  validates :source_remote_id, uniqueness: true

  before_save :create_remote_project_and_save_id
  after_save :clone_remote_child_entities

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

  def clone_remote_child_entities
    map_remote_epics_to_local_objects(self)
  end

  def clean_up_local_db
    self.epics.each do |epic|
      epic.delete
    end
    self.delete
  end

end
