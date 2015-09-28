require 'rails_helper'
require 'target_process_integration_toolkit'

RSpec.describe TargetProcessIntegrationToolkit::RemoteEntityCollection do
  before(:context) do
    @resource_type = "Project"
    @acid_ids = [191]
    @collection = TargetProcessIntegrationToolkit::RemoteEntityCollection.new({:resource_type => "Project", :acid_ids => [191]})
  end
  
  describe "initialize" do
    it "has entities" do
      expect(@collection).to respond_to(:entities)
    end

    it "returns an array of Target Process entities" do
      expect(@collection.entities).to be_instance_of(Array)
    end

    it "has a resource_type" do
      expect(@collection).to respond_to(:resource_type)
    end

    it "has acid" do
      expect(@collection).to respond_to(:acid)
    end

    it "acid is a 32 character hash" do
      expect(@collection.acid.length).to be 32
    end
  end
end