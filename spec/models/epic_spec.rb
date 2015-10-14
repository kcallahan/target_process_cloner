require 'rails_helper'
require 'target_process_integration_toolkit'

RSpec.describe Epic, type: :model do
  before(:context) do
    @project = FactoryGirl.build(:project)
    @project.cloned_remote_id = 12345
    @epic = FactoryGirl.build(:epic)
    @epic.project = @project
  end
  
  it "sets resource_type to epic" do
    expect(@epic.resource_type).to eq "Epic"
  end

  describe "specific_remote_params" do
    before(:context) do
      @params = @epic.specific_remote_params
    end

    it "returns a param hash" do
      expect(@params).to be_instance_of(Hash)
    end

    it "param hash has a project_id" do
      expect(@params[:project][:id]).to eq @project.cloned_remote_id
    end
  end
end
