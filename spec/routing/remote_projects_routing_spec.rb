require "rails_helper"

RSpec.describe RemoteProjectsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/remote_projects").to route_to("remote_projects#index")
    end

    it "routes to #new" do
      expect(:get => "/remote_projects/new").to route_to("remote_projects#new")
    end

    it "routes to #show" do
      expect(:get => "/remote_projects/1").to route_to("remote_projects#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/remote_projects/1/edit").to route_to("remote_projects#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/remote_projects").to route_to("remote_projects#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/remote_projects/1").to route_to("remote_projects#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/remote_projects/1").to route_to("remote_projects#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/remote_projects/1").to route_to("remote_projects#destroy", :id => "1")
    end

  end
end
