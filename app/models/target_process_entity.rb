require 'pry'
class TargetProcessEntity < ActiveRecord::Base
  validate :source_remote_id#, numericality: { only_integer: true }
  validate :source_remote_id#, uniqueness: true
  validate :resource_type#, allow_blank: false
  validate :type#, allow_blank: false

  has_many :projects
  has_many :epics
  #has_many :features
  #has_many :user_stories

  after_initialize :set_resource_type

  before_save :map_source_entity_to_self
  before_save :create_remote_entity_and_save_id

  after_save :clone_remote_child_entities

  def create_remote_entity_and_save_id 
    remote_entity         = create_remote_entity
    self.cloned_remote_id = remote_entity.id
    remote_entity
  end

  def create_remote_entity
    new_remote_entity = self.initialize_new_remote_entity
    new_remote_entity.save
  end

  def map_source_entity_to_self
    @source_entity        = fetch_source_entity
    self.name             = @source_entity.name if self.name.blank?
    self.owner            = @source_entity.owner[:id]
    self.numeric_priority = @source_entity.numeric_priority
    self.description      = @source_entity.description
    return true
  end

  def fetch_source_entity
    eval "TargetProcess::#{self.resource_type}.find(#{self.source_remote_id})"
  end

  def initialize_new_remote_entity
    new_remote_entity                  = eval "TargetProcess::#{self.resource_type}.new"
    new_remote_entity.resource_type    = @resource_type
    new_remote_entity.name             = self.name
    new_remote_entity.owner            = {:id => self.owner}
    new_remote_entity.numeric_priority = self.numeric_priority
    new_remote_entity.description      = self.description
    new_remote_entity
  end

  def clone_remote_child_entities
  end
end