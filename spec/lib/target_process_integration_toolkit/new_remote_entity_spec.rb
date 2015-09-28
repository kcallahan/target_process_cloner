require 'rails_helper'
require 'target_process_integration_toolkit'

RSpec.describe TargetProcessIntegrationToolkit::NewRemoteEntity do
  before(:context) do
    factory = FactoryGirl.build(:remote_entity)
    @test_entity = TargetProcessIntegrationToolkit::NewRemoteEntity.new(factory)
  end

  describe "initialize" do
    it "has a remote_entity" do
      expect(@test_entity).to respond_to(:remote_entity)
    end

    it "remote_entity is a Target Process object" do
      expect(@test_entity.remote_entity).to be_instance_of(TargetProcess::Project)
    end
  end

  describe "save" do
    it "saves the remote entity to TargetProcess" do
      pending "FIXME: check that TargetProcess::Project.save() is called"
    end
  end

end