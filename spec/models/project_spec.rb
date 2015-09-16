require 'rails_helper'
require 'target_process_utilities'

RSpec.describe Project, type: :model do
  before(:context) do
    # TODO probably better to shove this into a Factory
    @project = Project.new
    @project.name = "Local Project Test"
    @project.owner = 1
    @project.source_remote_id = 191
  end

  after(:context) do
    # TODO probably better to shove this into a Factory
    @project.delete
  end

  describe "create_remote_project" do
    before(:context) do
      @remote_project = @project.create_remote_project
    end

    after(:context) do
      @remote_project.delete
    end

    it "creates and saves a remote Target Process project" do
      # TODO put this test in a higher-level suite; mock all calls to it
      expect(@remote_project).to be_instance_of(TargetProcess::Project)
    end

    it "remote project has correct name" do
      # TODO abstract this string into the Factory
      expect(@remote_project.name).to eq "Local Project Test"
    end

    it "remote project has correct owner" do
      # TODO abstract this 17 to the Factory
      expect(@remote_project.owner[:id]).to eq 1
    end
  end

  describe "create_remote_project_and_save_id" do
    it "stores new remote project id as cloned_remote_id" do
      @project.save
      expect(@project.cloned_remote_id).to be > 0
      # TODO once the create is mocked, this can be removed
      TargetProcess::Project.find(@project.cloned_remote_id).delete
    end
  end

end
