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

    it "has an acid" do
      expect(@collection).to respond_to(:acid)
    end

    it "acid is nil for Projects" do
      expect(@collection.acid.nil?).to be true
    end

    it "acid is a 32 character hash for non-projects" do
      @epics_collection = TargetProcessIntegrationToolkit::RemoteEntityCollection.new({:resource_type => "Epic", :acid_ids => [191]})
      expect(@epics_collection.acid.length).to be 32
      expect(@epics_collection.acid).to eq '39AB9051A237D9E57193F2FCC5F70409'
    end
  end

  describe 'retrieve_remote_entities' do
    before(:example) do
      acid = TargetProcess.context({ids: 191})[:acid]      
      @expected_number = TargetProcess::Epic.all({take:1000, acid: acid}).count
    end

    it "only retrives entities for a single project" do
      @epics_collection = TargetProcessIntegrationToolkit::RemoteEntityCollection.new({:resource_type => "Epic", :acid_ids => [191]})
      expect(@epics_collection.entities.count).to eq @expected_number
    end
  end

  describe "brew_acid" do
    it "brews an acid hash that matches TargetProcess direct call" do
      control_acid = TargetProcess.context({ids: @acid_ids.join(',')})[:acid]
      acid = @collection.brew_acid(@acid_ids)
      expect(acid).to eq control_acid
    end
  end
end