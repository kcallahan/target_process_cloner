require 'rails_helper'
require 'target_process_integration_toolkit'

RSpec.describe TargetProcessIntegrationToolkit::SourceRemoteEntity do
  
  before(:context) do
    # FIXME: these are hooked to a live TP Project; mock and stub the interface!
    @resource_type = 'Project'
    @id = 191
    @source_entity = TargetProcessIntegrationToolkit::SourceRemoteEntity.new(@resource_type, @id)
  end

  describe "initialize" do
    it "retrieves a remote entity to clone" do
      expect(@source_entity.remote_entity).to be_instance_of(TargetProcess::Project)
    end
  end
end