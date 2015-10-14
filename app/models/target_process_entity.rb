class TargetProcessEntity < ActiveRecord::Base
  include TargetProcessIntegrationToolkit

  validate :source_remote_id
  validate :resource_type
  validate :type
  
  after_initialize :set_resource_type

  before_save :create_remote_entity_and_save_id
  after_save :clone_remote_child_entities

  @@target_process_project_to_clone  = 0
  @@target_process_cloned_project_id = 0
  
  def target_process_project_to_clone
    @@target_process_project_to_clone
  end

  def target_process_cloned_project_id
    @@target_process_cloned_project_id
  end

  def create_remote_entity_and_save_id 
    entity_to_clone_into  = create_remote_entity
    self.cloned_remote_id = entity_to_clone_into.id
    entity_to_clone_into
  end

  def map_source_entity_to_self(source_entity = nil)
    #TODO: There are several places where this type of mapping occurs; clean it up through a dynamic mapper
    source_entity         ||= SourceRemoteEntity.new(self.resource_type, self.source_remote_id) 
    self.name             = source_entity.name unless @resource_type == "Project"
    self.owner            = source_entity.owner[:id]
    self.numeric_priority = source_entity.numeric_priority
    self.description      = source_entity.description
    self.source_remote_id = source_entity.id    
    true
  end

  def create_remote_entity
    new_remote_entity = self.initialize_new_remote_entity
    new_remote_entity.save
  end  

  def initialize_new_remote_entity
    #TODO: There are several places where this type of mapping occurs; clean it up through a dynamic mapper
    params = {
      :resource_type    => @resource_type,
      :name             => self.name,
      :owner            => {:id => self.owner},
      :numeric_priority => self.numeric_priority,
      :description      => self.description
    }.merge(self.specific_remote_params)

    NewRemoteEntity.new(params)
  end

  def specific_remote_params
    {}
  end

  def clone_remote_child_entities
  end

  def set_resource_type
  end
end