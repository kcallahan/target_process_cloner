require 'rails_helper'
require 'target_process_utilities'

# Specs in this file have access to a helper object that includes
# the TargetProcessUtilities. For example:
#
# describe TargetProcessUtilities do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TargetProcessUtilities, type: :helper do
  before (:context) do
    @all_remote_projects_array = all_remote_projects
  end

  describe "map_remote_projects_to_local_objects" do
    before(:context) do
      @mapped_objects = map_remote_projects_to_local_objects
    end

    it "returns an array" do
      # FIXME this should be mocked and stubbed out so its not making live API calls
      expect(@mapped_objects).to be_instance_of(Array)
    end

    it "maps each array entry to a local object with an id" do
      receiver = double("map_remote_project_to_local_object")
      expect(receiver).to receive(:id)
      receiver.id
    end

    it "contains an item that has an id" do
      expect(@mapped_objects.first.id).to be > 0
    end
  end

  describe "all_remote_projects" do
    it "returns an array" do
      expect(@all_remote_projects_array).to be_instance_of(Array)
    end

    it "includes an object that has an id attribute" do
      expect(@all_remote_projects_array.first.id).to be > 0
    end
  end

  describe "retrieve_remote_project" do
    before(:context) do
      @remote_project = retrieve_remote_project(1611)
    end

    it "returns a TargetProcess::Project object" do
      expect(@remote_project).to be_instance_of(TargetProcess::Project)
    end
  end

  describe "map_remote_project_to_local_object" do
    before(:context) do
      @local_project = map_remote_project_to_local_object(1611)
    end

    it "initializes a local Project object" do
      expect(@local_project).to be_instance_of(Project)
    end

    it "has an id attribute" do
      expect(@local_project.id).to be > 0
    end

    it "has a name attribute" do
      expect(@local_project.name.length).to be > 0
    end

    it "has an owner attribute" do
      expect(@local_project.owner).to be > 0
    end

    it "maps to a remote project" do
      expect(@local_project.source_remote_id).to be > 0
    end
  end

  describe "all_remote_epics_for_project" do
    before(:context) do
      @epics = all_remote_epics_for_project(1611)
    end

    it "returns an array" do
      expect(@epics).to be_instance_of(Array)
    end

    it "contains at least one Target Process Epic" do
      expect(@epics.first).to be_instance_of(TargetProcess::Epic)
    end

    it "first epic belongs to intended project" do
      expect(@epics.first.project[:id]).to be 1611
    end
  end

  describe "map_remote_epics_to_local_objects" do
    before(:context) do
      @local_project = map_remote_project_to_local_object(1611)
    end

    it "initializes a local Project object" do
      expect(@local_project).to be_instance_of(Project)
    end

    it "has an id attribute" do
      expect(@local_project.id).to be > 0
    end

    it "has a name attribute" do
      expect(@local_project.name.length).to be > 0
    end

    it "has an owner attribute" do
      expect(@local_project.owner).to be > 0
    end

    it "maps to a remote project" do
      expect(@local_project.source_remote_id).to be > 0
    end
  end

  describe "brew_acid" do
    it "returns a hashed array" do
      acid = brew_acid
      expect(acid.length).to be > 0
    end
  end


end
