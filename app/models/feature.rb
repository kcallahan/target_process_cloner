class Feature < TargetProcessEntity

  has_one :project
  has_one :epic

  validates :project_id, numericality: { only_integer: true }
  validates :epic_id, numericality: { only_integer: true }

  before_save :create_remote_feature_and_save_id

  def initialize
    self.type = 'feature'
    self.resource_type = "Feature"
  end

  def create_remote_feature_and_save_id
    remote_feature = create_remote_feature
    self.cloned_remote_id = remote_feature.id
  end

  def create_remote_feature
    new_remote_feature = TargetProcess::Feature.new
    new_remote_feature.resource_type = "Feature"
    new_remote_feature.name = self.name
    new_remote_feature.owner = {:id => self.owner}
    new_remote_feature.project = {:id => self.project.cloned_remote_id}
    new_remote_feature.epic = {:id => self.epic.cloned_remote_id}
    new_remote_feature.numeric_priority = self.numeric_priority
    new_remote_feature.save
  end

  def epic
    Epic.find(self.epic_id)
  end

  def project
    Project.find(self.project_id)
  end

end
