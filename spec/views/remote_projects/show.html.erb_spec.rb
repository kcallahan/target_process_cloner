require 'rails_helper'

RSpec.describe "remote_projects/show", type: :view do
  before(:each) do
    @remote_project = assign(:remote_project, RemoteProject.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
