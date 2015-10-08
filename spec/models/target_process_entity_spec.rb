require 'rails_helper'
require 'target_process_integration_toolkit'

RSpec.describe TargetProcessEntity, type: :model do
  before(:context) do
    @project = FactoryGirl.build(:project)
    @epic    = FactoryGirl.build(:epic)
  end

  describe "common attributes" do
    it "has a resource_type that matches TargetProcess" do
      @tp_resource = eval("TargetProcess::#{@project.resource_type}.new")
      expect(@tp_resource).to be_instance_of(TargetProcess::Project)
    end

    it "has a name" do
      expect(@project).to respond_to(:name)
    end

    it "name is not empty" do
      expect(@project.name.blank?).to be false
    end

    it "has a description" do
      expect(@project).to respond_to(:description)
    end

    it "has an owner" do
      expect(@project).to respond_to(:owner)
    end

    it "owner is set as a number" do
      expect(@project.owner).to be > 0
    end

    it "has a numeric priority" do
      expect(@project).to respond_to(:numeric_priority)
    end

    it "has a remote source id" do
      expect(@project).to respond_to(:source_remote_id)
    end

    it "has a remote cloned id" do
      expect(@project).to respond_to(:cloned_remote_id)
    end
  end

  describe "map_source_entity_to_self" do
    before(:context) do
      @control_entity = TargetProcess::Project.find(191)
      @project.map_source_entity_to_self(@control_entity)
    end

    after(:context) do
      TargetProcess::Project.find(@project.cloned_remote_id).delete
    end

    it "preserves project name" do
      expect(@project.name).not_to eq @control_entity.name
    end

    it "preserves remote epic name" do
      control_epic = TargetProcess::Epic.find(192)
      test_epic = @epic
      test_epic.map_source_entity_to_self(control_epic)
      expect(test_epic.name).to eq control_epic.name
    end

    it "maps owner id from a hash value to a number" do
      expect(@project.owner).to eq @control_entity.owner[:id]
    end

    it "owner is a number" do
      expect(@project.owner).to be > 0
    end

    it "maps priority" do
      expect(@project.numeric_priority).to eq @control_entity.numeric_priority
    end

    it "maps description" do
      expect(@project.description).to eq @control_entity.description
    end

    it "initializes a new source entity if not passed one" do
      @project = TargetProcessIntegrationToolkit::SourceRemoteEntity.new('Project', 191)
      expect(@project.remote_entity).to eq @control_entity
    end

    it "preserves a source entity if passed one" do
      @control_entity = TargetProcess::Epic.find(192)
      @epic.map_source_entity_to_self(@control_entity)
    end
  end
end
