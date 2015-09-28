require 'target_process_integration_toolkit'

class TargetProcessEntity < ActiveRecord::Base
  include TargetProcessIntegrationToolkit

  validate :source_remote_id
  validate :resource_type
  validate :type

  has_many :projects
  has_many :epics
  #has_many :features
  #has_many :user_stories
  
  after_initialize :set_resource_type

  before_save :map_source_entity_to_self
  before_save :create_remote_entity_and_save_id

  after_save :clone_remote_child_entities

  @@target_process_project_to_clone = 0
  
  def target_process_project_to_clone
    @@target_process_project_to_clone
  end

  def create_remote_entity_and_save_id 
    entity_to_clone_into  = create_remote_entity
    self.cloned_remote_id = entity_to_clone_into.id
    entity_to_clone_into
  end

  def map_source_entity_to_self(source_entity = nil)
    source_entity         ||= SourceRemoteEntity.new(self.resource_type, self.source_remote_id)

    self.name             = source_entity.name if self.name.blank? # only projects set a name, which needs to be retained
    self.owner            = source_entity.owner[:id]
    self.numeric_priority = source_entity.numeric_priority
    self.description      = source_entity.description
    return true
  end

  def create_remote_entity
    new_remote_entity = self.initialize_new_remote_entity
    new_remote_entity.project = @@target_process_project_to_clone if new_remote_entity.has_project?(@resource_type)
    new_remote_entity.save
  end  

  def initialize_new_remote_entity
    params = {
      :resource_type    => @resource_type,
      :name             => self.name,
      :owner            => {:id => self.owner},
      :numeric_priority => self.numeric_priority,
      :description      => self.description
    }
    NewRemoteEntity.new(params)
  end

  def clone_remote_child_entities
  end
end