class Feature < TargetProcessEntity

  belongs_to :project
  belongs_to :epic
  has_many   :user_stories

  def set_resource_type
    @resource_type     = "Feature"
    self.resource_type = "Feature"
  end

  def specific_remote_params
    params = {
      :project => {
        :id => self.project.cloned_remote_id
      }
    }
    params.merge!({
      :epic => {
        :id => self.epic.cloned_remote_id
      }
    }) unless self.epic.nil?
    params
  end
end