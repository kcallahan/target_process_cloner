require 'rails_helper'

RSpec.describe Project, type: :model do
  before(:context) do
    @project = FactoryGirl.build(:project, source_remote_id: 191)
  end

  describe "on initialize" do
    it "has a type" do
      expect(@project).to respond_to(:type)
    end

    it "type is not empty" do
      expect(@project.type.blank?).to be false
    end

    it "has a resource_type" do
      expect(@project.resource_type.blank?).to be false
    end

    it "has a resource_type that matches TargetProcess::Project" do
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

    it "sets source remote id to passed param" do
      expect(@project.target_process_project_to_clone).to be > 0 
    end

    it "has a remote cloned id" do
      expect(@project).to respond_to(:cloned_remote_id)
    end
  end

  describe "create_remote_entity" do
    before(:context) do
      @remote_project = @project.create_remote_entity
    end

    after(:context) do
      @remote_project.delete
    end

    it "creates an instance of TargetProcess::Project" do
      expect(@remote_project).to be_instance_of(TargetProcess::Project)
    end

    it "maps name" do
      expect(@remote_project.name).to eq @project.name
    end

    it "maps owner" do
      expect(@remote_project.owner[:id]).to eq @project.owner
    end

    it "maps resource_type" do
      expect(@remote_project.resource_type).to eq "Project"
    end

    it "maps numeric priority" do
      pending "FIXME: the factory shouldn't know about the remote..."
    end

    it "returns an object with an id" do
      expect(@remote_project.id).to be > 0
    end
  end

  describe "create_remote_entity_and_save_id" do
    before(:context) do
      @remote_project = @project.create_remote_entity_and_save_id
    end

    after(:context) do
      @remote_project.delete
    end

    it "stores the cloned project id" do
      expect(@project.cloned_remote_id).to eq @remote_project.id
    end

    it "retains the source_remote_id" do
      expect(@project.source_remote_id).to eq 191
    end
  end

end