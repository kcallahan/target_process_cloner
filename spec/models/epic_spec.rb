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
    @epic.numeric_priority = 400
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
  end

  describe "project" do
    it "project is a Project in the system" do
      expect(@epic.project).to be_instance_of(Project)
    end
  end
end
