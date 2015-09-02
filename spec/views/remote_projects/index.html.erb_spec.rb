require 'rails_helper'

RSpec.describe "remote_projects/index", type: :view do
  before(:each) do
    assign(:remote_projects, [
      RemoteProject.create!(),
      RemoteProject.create!()
    ])
  end

  it "renders a list of remote_projects" do
    render
  end
end
