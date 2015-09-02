require 'rails_helper'

RSpec.describe "remote_projects/edit", type: :view do
  before(:each) do
    @remote_project = assign(:remote_project, RemoteProject.create!())
  end

  it "renders the edit remote_project form" do
    render

    assert_select "form[action=?][method=?]", remote_project_path(@remote_project), "post" do
    end
  end
end
