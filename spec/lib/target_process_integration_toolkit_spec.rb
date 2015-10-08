require 'rails_helper'
require 'target_process_integration_toolkit'

RSpec.describe TargetProcessIntegrationToolkit, :type => :helper do

  describe "entity_has_project?" do
    it "a project does not have a project" do
      test = entity_has_project?("Project")
      expect(test).to be false
    end

    it "a epic has a project" do
      test = entity_has_project?("Epic")
      expect(test).to be true
    end

    it "a feature has a project" do
      test = entity_has_project?("Feature")
      expect(test).to be true
    end

    it "a user story has a project" do
      test = entity_has_project?("UserStory")
      expect(test).to be true
    end

    it "a task has a project" do
      test = entity_has_project?("Task")
      expect(test).to be true
    end    
  end
end