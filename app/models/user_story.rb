class UserStory < TargetProcessEntity
  has_one :project
  has_one :feature

  validates :project_id, numericality: { only_integer: true }
  validates :feature_id, numericality: { only_integer: true }

  before_save :create_remote_user_story_and_save_id
  
  def initialize
    self.type = 'user_story'
  end

  def create_remote_user_story_and_save_id
    remote_user_story = create_remote_user_story
    self.cloned_remote_id = remote_user_story.id
  end

  def create_remote_user_story
    new_remote_user_story = TargetProcess::UserStory.new
    new_remote_user_story.resource_type = "UserStory"
    new_remote_user_story.name = self.name
    new_remote_user_story.owner = {:id => self.owner}
    new_remote_user_story.project = {:id => self.project.cloned_remote_id}
    new_remote_user_story.feature = {:id => self.feature.cloned_remote_id}
    new_remote_user_story.numeric_priority = self.numeric_priority
    new_remote_user_story.save
  end

  def feature
    Feature.find(self.feature_id)
  end

  def project
    Project.find(self.project_id)
  end
end
