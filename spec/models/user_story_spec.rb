require 'target_process_integration_toolkit'
require 'rails_helper'

RSpec.describe UserStory, type: :model do
  before(:context) do
    @project = FactoryGirl.build(:project)
    @project.save

    @epic = @project.epics.first
    @feature = @project.features.first
    @user_story = @project.user_stories.first
  end

  after(:context) do
    TargetProcess::Project.find(@project.cloned_remote_id).delete
  end

  describe "initialize" do
    it "sets the resource type to user story" do
      expect(UserStory.new.resource_type).to eq "UserStory"
    end
  end

  describe "specific_remote_params" do
    it "sets the feature parameter if one is set" do
      expect(@user_story.specific_remote_params[:feature][:id]).to eq @feature.id
    end
    
    before(:example) do
      @user_story.feature = nil
    end

    after (:example) do
      @user_story.feature = @feature
    end

    it "does not set the feature parameter if one is not set" do
      expect(@user_story.specific_remote_params[:feature][:id].nil?).to be true
    end
  end
end
