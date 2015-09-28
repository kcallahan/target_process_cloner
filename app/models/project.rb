require 'target_process_integration_toolkit'

class Project < TargetProcessEntity
  include TargetProcessIntegrationToolkit

  belongs_to :target_process_entity

  after_initialize :set_instance_name, :set_target_process_project_to_clone
  
  def set_instance_name
    @name = self.name
  end

  def set_resource_type
    @resource_type     = "Project"
    self.resource_type = "Project"
  end

  def set_target_process_project_to_clone
    @@target_process_project_to_clone = self.source_remote_id
  end

  def clone_remote_child_entities
    @epics = RemoteEntityCollection.new({:resource_type => 'Epic', :acid_ids => [self.source_remote_id]})
    @epics.each do |epic|
      local_epic = Epic.new()
      local_epic.map_source_entity_to_self(epic)
      local_epic.project_id = self.id
      local_epic.save
    end


#    map_remote_epics_to_local_objects(self)
#    map_remote_features_to_local_objects(self)
#    map_remote_user_stories_to_local_objects(self)
  end

  def clone_entity(entity_to_clone)
    

    ENTITY_PARAMS.each do |key|
      local_params[key] = entity_to_clone[key]  
    end

  end

  def clean_up_local_db
=begin    
    self.epics.each do |epic|
      epic.delete
    end
    self.features.each do |feature|
      feature.delete
    end
    self.user_stories.each do |user_story|
      user_story.delete
    end
=end    
    self.delete
  end

end
