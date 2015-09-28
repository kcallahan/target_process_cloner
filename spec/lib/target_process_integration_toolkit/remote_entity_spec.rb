require 'rails_helper'
require 'target_process_integration_toolkit'

RSpec.describe TargetProcessIntegrationToolkit::RemoteEntity do
  before(:context) do
    @remote_entity = TargetProcessIntegrationToolkit::RemoteEntity.new
  end

  describe "creates a template target process entity" do   
    it "has an id" do
      expect(@remote_entity).to respond_to(:id)
    end

    it "has a project" do
      expect(@remote_entity).to respond_to(:project)
    end

    it "has a resource_type" do
      expect(@remote_entity).to respond_to(:resource_type)
    end

    it "has a name" do
      expect(@remote_entity).to respond_to(:name)
    end

    it "has a description" do
      expect(@remote_entity).to respond_to(:description)
    end

    it "has an owner" do
      expect(@remote_entity).to respond_to(:owner)
    end

    it "has a numeric_priority" do
      expect(@remote_entity).to respond_to(:numeric_priority)
    end
  end

  describe "has_project?" do
    it "projects do not have projects" do
      answer = @remote_entity.has_project? "Project"
      expect(answer).to be false
    end

    it "user stories do have projects" do
      answer = @remote_entity.has_project? "UserStory"
      expect(answer).to be true
    end

    it "epics do have projects" do
      answer = @remote_entity.has_project? "Epic"
      expect(answer).to be true
    end

    it "features do have projects" do
      answer = @remote_entity.has_project? "Feature"
      expect(answer).to be true
    end

    it "tasks do have projects" do
      answer = @remote_entity.has_project? "Task"
      expect(answer).to be false
    end
  end
end