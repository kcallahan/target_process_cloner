require 'rails_helper'
require 'target_process_integration_toolkit'

RSpec.describe Task, type: :model do
  before(:context) do
    @project = FactoryGirl.build(:project)
    @project.cloned_remote_id = 12345

    @user_story = FactoryGirl.build(:user_story)
    @user_story.cloned_remote_id = 6779
    @user_story.project = @project

    @task = FactoryGirl.build(:task)
    @task.user_story = @user_story
  end
  
  it "sets resource_type to task" do
    expect(@task.resource_type).to eq "Task"
  end

  describe "specific_remote_params" do
    before(:context) do
      @params = @task.specific_remote_params
    end

    it "returns a param hash" do
      expect(@params).to be_instance_of(Hash)
    end

    it "param hash has a project" do
      expect(@params[:project][:id]).to eq @project.cloned_remote_id
    end

    it "param hash has an user story" do 
      expect(@params[:userstory][:id]).to eq @user_story.cloned_remote_id
    end

  end
end