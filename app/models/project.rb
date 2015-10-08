require 'target_process_integration_toolkit'

class Project < TargetProcessEntity
  include TargetProcessIntegrationToolkit

  has_many :epics
  has_many :features
  has_many :user_stories
  
  after_initialize :set_instance_name, :set_target_process_project_to_clone

  before_save :map_source_entity_to_self, prepend: true

  def set_instance_name
    @name = self.name
  end

  def set_resource_type
    @resource_type     = "Project"
    self.resource_type = "Project"
  end

  def set_target_process_project_to_clone
    raise("Source project must be set!") if self.source_remote_id.nil?
    @@target_process_project_to_clone = self.source_remote_id
  end

  def clone_remote_child_entities    
    acid_ids = [@@target_process_project_to_clone]

    @epics = RemoteEntityCollection.new({:resource_type => 'Epic', :acid_ids => acid_ids})
    @epics.entities.each do |epic|
      unless epic.nil?
        local_epic = Epic.new()
        local_epic.map_source_entity_to_self(epic)
        local_epic.project = self
        local_epic.save
        sleep 2
      end
    end 

    @features = RemoteEntityCollection.new({:resource_type => 'Feature', :acid_ids => acid_ids})
    @features.entities.each do |feature|
      unless feature.nil?
        local_feature = Feature.new()
        local_feature.map_source_entity_to_self(feature)
        epic = Epic.where("source_remote_id = #{feature.epic[:id]}") unless feature.epic.nil?
        local_feature.epic = epic.first unless epic.nil?
        local_feature.project = self
        local_feature.save
        sleep 2
      end
    end

    @user_stories = RemoteEntityCollection.new({:resource_type => 'UserStory', :acid_ids => acid_ids})
    @user_stories.entities.each do |user_story|
      unless user_story.nil?
        local_user_story = UserStory.new()
        local_user_story.map_source_entity_to_self(user_story)
        feature = Feature.where("source_remote_id = #{user_story.feature[:id]}") unless user_story.feature.nil?
        local_user_story.feature = feature.first unless feature.nil?        
        local_user_story.project = self        
        local_user_story.save
        sleep 2
      end
    end 
  end

  def clone_entity(entity_to_clone)
  end

  def clean_up_local_db
    self.epics.each do |epic|
      epic.delete
    end
    self.features.each do |feature|
      feature.delete
    end
    self.user_stories.each do |user_story|
      user_story.delete
    end
    self.delete
  end

end
