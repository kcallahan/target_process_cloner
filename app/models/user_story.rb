class UserStory < TargetProcessEntity

  belongs_to :feature
  belongs_to :project
  has_many   :tasks

  def set_resource_type
    @resource_type     = "UserStory"
    self.resource_type = "UserStory"
  end

  def specific_remote_params
    params = {:project => {:id => self.project.cloned_remote_id}}
    params.merge!({:feature => {:id => self.feature.cloned_remote_id}}) unless self.feature.nil?
    params
  end

  def clone_remote_child_entities
    acid_ids = [@@target_process_project_to_clone]
=begin    
    @tasks = RemoteEntityCollection.new({:resource_type => 'Task', :acid_ids => acid_ids})
    @tasks.entities.each do |task|
      unless task.nil?        
        local_task = Task.new()
        local_task.map_source_entity_to_self(task)
        local_task.user_story = self
        local_task.save
        sleep 1
      end
    end    
=end    
  end

end