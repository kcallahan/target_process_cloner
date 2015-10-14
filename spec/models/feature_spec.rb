require 'rails_helper'
require 'target_process_integration_toolkit'

RSpec.describe Feature, type: :model do
  before(:context) do
    @project = FactoryGirl.build(:project)
    @project.cloned_remote_id = 12345
    @epic    = FactoryGirl.build(:epic)
    @epic.cloned_remote_id = 6789
    @feature = FactoryGirl.build(:feature)

    @feature.project = @project
    @feature.epic    = @epic
  end

  it "sets resource_type to feature" do
    expect(@feature.resource_type).to eq "Feature"
  end

  describe "specific_remote_params" do
    before(:context) do
      @params = @feature.specific_remote_params
    end

    it "returns a param hash" do
      expect(@params).to be_instance_of(Hash)
    end

    it "param hash has a project" do
      expect(@params[:project][:id]).to eq @project.cloned_remote_id
    end

    it "param hash has an epic if one is set" do 
      expect(@params[:epic][:id]).to eq @epic.cloned_remote_id
    end

    it "param hash does not have an epic if one is not set" do
      @feature.epic = nil
      @params = @feature.specific_remote_params
      expect(@params[:epic].nil?).to be true
    end
  end
end
