require 'rails_helper'

RSpec.describe "remote_projects/new", type: :view do
  before(:each) do
    assign(:remote_project, RemoteProject.new())
  end

  it "renders new remote_project form" do
    render

    assert_select "form[action=?][method=?]", remote_projects_path, "post" do
    end
  end
end
