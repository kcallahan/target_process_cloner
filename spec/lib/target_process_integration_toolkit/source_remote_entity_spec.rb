require 'rails_helper'
require 'target_process_integration_toolkit'

RSpec.describe TargetProcessIntegrationToolkit::SourceRemoteEntity do
  
  before(:context) do
    # FIXME: these are hooked to a live TP Project; mock and stub the interface!
    @tp_project = TargetProcess::Project.find(191)

    @resource_type = 'Project'
    @id = 191
    @source_entity = TargetProcessIntegrationToolkit::SourceRemoteEntity.new(@resource_type, @id)
  end

  describe "initialize" do
    it "retrieves a remote entity to clone and stores in remote_entity attribute" do
      expect(@source_entity.remote_entity).to be_instance_of(TargetProcess::Project)
    end
    
    it "maps the id" do
      expect(@source_entity.id).to eq 191
    end

    it "maps the source resource_type" do
      expect(@source_entity.resource_type).to eq 'Project'
    end

    it "maps the name" do
      expect(@source_entity.name).to eq @tp_project.name
    end

    it "maps the description" do
      expect(@source_entity.description).to eq @tp_project.description
    end

    it "the owner is a hash" do
      expect(@source_entity.owner).to be_instance_of(Hash)
    end

    it "maps the owner hash" do
      expect(@source_entity.owner).to eq @tp_project.owner
    end

    it "maps the numeric priority" do
      expect(@source_entity.numeric_priority).to eq @tp_project.numeric_priority
    end

    it "does not set project for projects" do
      expect(@source_entity.project.nil?).to be true
    end
  end
end