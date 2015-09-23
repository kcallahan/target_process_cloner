require 'rails_helper'

RSpec.describe Epic, type: :model do
  before(:context) do
    # TODO probably better to shove this into a Factory
    @project = Project.new
    @project.name = "Local Project Test"
    @project.owner = 1
    @project.source_remote_id = 191
    @project.save!

    @epic = Epic.new
    @epic.name = "Local Epic Test"
    @epic.owner = 1
    @epic.source_remote_id = 192
    @epic.project_id = @project.id
  end

  after(:context) do
    TargetProcess::Project.find(@project.cloned_remote_id).delete unless @project.cloned_remote_id.nil?
    @project.delete

    #TargetProcess::Epic.find(@epic.cloned_remote_id).delete unless @epic.cloned_remote_id.nil?
    @epic.delete
  end

  describe "create_remote_epic" do
    before(:context) do
      @remote_epic = @epic.create_remote_epic
    end

    after(:context) do
      @remote_epic.delete
    end

    it "creates and saves a remote Target Process epic" do
      # TODO put this test in a higher-level suite; mock all calls to it
      expect(@remote_epic).to be_instance_of(TargetProcess::Epic)
    end

    it "remote epic has correct name" do
      # TODO abstract this string into the Factory
      expect(@remote_epic.name).to eq "Local Epic Test"
    end

    it "remote epic has correct owner" do
      # TODO abstract this 1 to the Factory
      expect(@remote_epic.owner[:id]).to eq 1
    end
  end

  describe "create_remote_epic_and_save_id" do
    it "stores new remote epic id as cloned_remote_id" do
      @epic.save
      expect(@epic.cloned_remote_id).to be > 0
      # TODO once the create is mocked, this can be removed
      TargetProcess::Epic.find(@epic.cloned_remote_id).delete
    end
  end

  describe "project" do
    it "project is an Project in the system" do
      expect(@epic.project).to be_instance_of(Project)
    end
  end
end
