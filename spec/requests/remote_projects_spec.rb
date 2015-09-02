require 'rails_helper'

RSpec.describe "RemoteProjects", type: :request do
  describe "GET /remote_projects" do
    it "works! (now write some real specs)" do
      get remote_projects_path
      expect(response).to have_http_status(200)
    end
  end
end
