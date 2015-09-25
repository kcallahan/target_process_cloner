require 'rails_helper'

RSpec.describe TargetProcessEntity, type: :model do
  before(:context) do
    @entity = FactoryGirl.build(:project)
  end

  describe "common attributes" do
    it "has a resource_type that matches TargetProcess" do
      @tp_resource = eval("TargetProcess::#{@entity.resource_type}.new")
      expect(@tp_resource).to be_instance_of(TargetProcess::Project)
    end

    it "has a name" do
      expect(@entity).to respond_to(:name)
    end

    it "name is not empty" do
      expect(@entity.name.blank?).to be false
    end

    it "has a description" do
      expect(@entity).to respond_to(:description)
    end

    it "has an owner" do
      expect(@entity).to respond_to(:owner)
    end

    it "owner is set as a number" do
      expect(@entity.owner).to be > 0
    end

    it "has a numeric priority" do
      expect(@entity).to respond_to(:numeric_priority)
    end

    it "has a remote source id" do
      expect(@entity).to respond_to(:source_remote_id)
    end

    it "has a remote cloned id" do
      expect(@entity).to respond_to(:cloned_remote_id)
    end
  end
end
