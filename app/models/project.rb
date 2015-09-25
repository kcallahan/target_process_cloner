class Project < TargetProcessEntity

  belongs_to :target_process_entity

  after_initialize :set_instance_name
  
  def set_instance_name
    @name = self.name
  end

  def set_resource_type
    @resource_type     = "Project"
    self.resource_type = "Project"
  end

  def clone_remote_child_entities
#    map_remote_epics_to_local_objects(self)
#    map_remote_features_to_local_objects(self)
#    map_remote_user_stories_to_local_objects(self)
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
