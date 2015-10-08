require 'rails_helper'
require 'target_process_integration_toolkit'

RSpec.describe TargetProcessIntegrationToolkit::RemoteEntity do
  before(:context) do
    @remote_entity = TargetProcessIntegrationToolkit::RemoteEntity.new
  end

  describe "creates a template target process entity" do   
    it "has an id" do
      expect(@remote_entity).to respond_to(:id)
    end

    it "has a project" do
      expect(@remote_entity).to respond_to(:project)
    end

    it "has a resource_type" do
      expect(@remote_entity).to respond_to(:resource_type)
    end

    it "has a name" do
      expect(@remote_entity).to respond_to(:name)
    end

    it "has a description" do
      expect(@remote_entity).to respond_to(:description)
    end

    it "has an owner" do
      expect(@remote_entity).to respond_to(:owner)
    end

    it "has a numeric_priority" do
      expect(@remote_entity).to respond_to(:numeric_priority)
    end
  end
end